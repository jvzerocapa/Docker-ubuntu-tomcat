#!/bin/bash
set -e

# DEBUG
echo "Iniciando Tomcat..."
echo "CATALINA_HOME = $CATALINA_HOME"

# Garantir permissões corretas
chmod -R 755 $CATALINA_HOME

# Iniciar Tomcat em foreground
exec $CATALINA_HOME/bin/catalina.sh run
