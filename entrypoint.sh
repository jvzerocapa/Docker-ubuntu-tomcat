#!/bin/bash
set -e

# Criar usuário admin dinamicamente
echo "Configurando usuário admin no Tomcat..."

cat > $CATALINA_HOME/conf/tomcat-users.xml <<EOF
<tomcat-users>
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <role rolename="manager-status"/>
  <role rolename="admin-gui"/>
  <user username="${TOMCAT_USER}" password="${TOMCAT_PASS}" roles="manager-gui,manager-script,manager-status,admin-gui"/>
</tomcat-users>
EOF

# Liberar acesso remoto ao Manager e Host-Manager
echo "Liberando acesso remoto..."
sed -i '/Valve className="org.apache.catalina.valves.RemoteAddrValve"/,/\/Valve>/d' \
    $CATALINA_HOME/webapps/manager/META-INF/context.xml || true
sed -i '/Valve className="org.apache.catalina.valves.RemoteAddrValve"/,/\/Valve>/d' \
    $CATALINA_HOME/webapps/host-manager/META-INF/context.xml || true

# Exibir credenciais no log
echo "===================================================="
echo "Tomcat iniciado com sucesso!"
echo "Acesse: http://localhost:8080/manager/html"
echo "Usuário: ${TOMCAT_USER}"
echo "Senha:   ${TOMCAT_PASS}"
echo "===================================================="

# Iniciar Tomcat no foreground
exec $CATALINA_HOME/bin/catalina.sh run
