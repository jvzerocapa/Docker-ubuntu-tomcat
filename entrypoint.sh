#!/bin/bash
set -e

TOMCAT_HOME=/usr/local/tomcat

echo "🔧 Iniciando configuração do Tomcat..."

# 0️⃣ Instalar dependências essenciais para apps Java
echo "📦 Instalando dependências Java e drivers JDBC..."
apt-get update && apt-get install -y \
    libpostgresql-jdbc-java \
    libmysql-java \
    libcommons-dbcp2-java \
    libtomcat10-java \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Adiciona drivers ao classpath do Tomcat
ln -sf /usr/share/java/postgresql.jar $TOMCAT_HOME/lib/postgresql.jar || true
ln -sf /usr/share/java/mysql-connector-java.jar $TOMCAT_HOME/lib/mysql-connector-java.jar || true

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
        sed -i '/Valve className="org.apache.catalina.valves.RemoteAddrValve"/d' "$CTX"
        sed -i '/allow="127\\\.0\\\.0\\\.1"/d' "$CTX"
    fi
done

echo "✅ Configuração concluída. Iniciando o Tomcat..."
exec catalina.sh run
