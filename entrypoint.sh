#!/bin/bash
set -e

echo "Iniciando Tomcat..."
echo "CATALINA_HOME = $CATALINA_HOME"

# Garantir permissões corretas
chmod -R 755 $CATALINA_HOME

# Configurar usuário admin se ainda não existir
TOMCAT_USERS_FILE="$CATALINA_HOME/conf/tomcat-users.xml"

if ! grep -q "username=\"admin\"" "$TOMCAT_USERS_FILE"; then
    echo "Criando usuário admin para Manager GUI..."
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

# Liberar acesso remoto ao Manager e Host Manager
for app in manager host-manager; do
    CONTEXT_FILE="$CATALINA_HOME/webapps/$app/META-INF/context.xml"
    if [ -f "$CONTEXT_FILE" ]; then
        echo "Removendo restrição de IP para $app..."
        sed -i '/Valve className="org.apache.catalina.valves.RemoteAddrValve"/,/\/Valve>/d' "$CONTEXT_FILE"
    fi
done

# Iniciar Tomcat em foreground
exec $CATALINA_HOME/bin/catalina.sh run
