#!/bin/bash
set -e

echo "=== Inicializando Tomcat ==="

TOMCAT_USERS_FILE="$CATALINA_HOME/conf/tomcat-users.xml"

# Garante permissão total
chmod -R 755 $CATALINA_HOME

# Cria o usuário admin se não existir
if ! grep -q 'username="admin"' "$TOMCAT_USERS_FILE"; then
    echo "Criando usuário admin..."
    cat <<EOL > "$TOMCAT_USERS_FILE"
<tomcat-users>
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <role rolename="manager-status"/>
  <role rolename="admin-gui"/>
  <user username="admin" password="admin123" roles="manager-gui,manager-script,manager-status,admin-gui"/>
</tomcat-users>
EOL
fi

# Aguardar extração do WAR
echo "Aguardando extração dos WARs..."
sleep 5

# Remover restrição de IPs no manager e host-manager
for app in manager host-manager; do
    CONTEXT_FILE="$CATALINA_HOME/webapps/$app/META-INF/context.xml"
    if [ -f "$CONTEXT_FILE" ]; then
        echo "Liberando acesso remoto para $app..."
        sed -i '/Valve className="org.apache.catalina.valves.RemoteAddrValve"/,/\/Valve>/d' "$CONTEXT_FILE"
    fi
done

echo "Iniciando servidor Tomcat..."
exec $CATALINA_HOME/bin/catalina.sh run
