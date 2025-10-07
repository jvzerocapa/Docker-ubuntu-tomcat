#!/bin/bash
set -e

TOMCAT_HOME=/usr/local/tomcat

echo "🔧 Iniciando configuração do Tomcat..."

# 1️⃣ Garante que os diretórios do manager e host-manager existam
if [ ! -d "$TOMCAT_HOME/webapps/manager" ]; then
    echo "📁 Copiando manager e host-manager padrão..."
    cp -r $TOMCAT_HOME/webapps.dist/manager $TOMCAT_HOME/webapps/
    cp -r $TOMCAT_HOME/webapps.dist/host-manager $TOMCAT_HOME/webapps/
fi

# 2️⃣ Cria o usuário admin com acesso total
echo "👤 Criando usuário admin..."
cat <<EOF > $TOMCAT_HOME/conf/tomcat-users.xml
<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">
  <role rolename="manager-gui"/>
  <role rolename="admin-gui"/>
  <user username="admin" password="admin" roles="manager-gui,admin-gui"/>
</tomcat-users>
EOF

# 3️⃣ Libera acesso remoto aos apps manager e host-manager
echo "🌐 Liberando acesso remoto..."
for CTX in $TOMCAT_HOME/webapps/manager/META-INF/context.xml $TOMCAT_HOME/webapps/host-manager/META-INF/context.xml; do
    if [ -f "$CTX" ]; then
        # Remove linhas que bloqueiam acesso remoto
        sed -i '/Valve className="org.apache.catalina.valves.RemoteAddrValve"/d' "$CTX"
        sed -i '/allow="127\\\.0\\\.0\\\.1"/d' "$CTX"
    fi
done

echo "✅ Configuração concluída. Iniciando o Tomcat..."
exec catalina.sh run
