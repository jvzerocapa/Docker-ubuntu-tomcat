#!/bin/bash
set -e

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

echo "Liberando acesso remoto..."
for ctx in $CATALINA_HOME/webapps/manager/META-INF/context.xml $CATALINA_HOME/webapps/host-manager/META-INF/context.xml; do
  if [ -f "$ctx" ]; then
    sed -i '/Valve className="org.apache.catalina.valves.RemoteAddrValve"/,/\/Valve>/d' "$ctx"
  fi
done

echo "===================================================="
echo "Tomcat iniciado com sucesso!"
echo "Acesse: http://localhost:8080/manager/html"
echo "Usuário: ${TOMCAT_USER}"
echo "Senha:   ${TOMCAT_PASS}"
echo "===================================================="

exec $CATALINA_HOME/bin/catalina.sh run
