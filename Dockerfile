# Base Ubuntu
FROM ubuntu:22.04

# Variáveis de ambiente
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV TOMCAT_USER=admin
ENV TOMCAT_PASSWORD=admin123
ENV TOMCAT_VERSION=10.1.46

# Instalar dependências
RUN apt-get update && apt-get install -y \
    curl \
    openjdk-17-jdk \
    nano \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Baixar e instalar Tomcat
RUN curl -LO https://downloads.apache.org/tomcat/tomcat-10/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && tar xzf apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && mv apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME \
    && rm apache-tomcat-$TOMCAT_VERSION.tar.gz

# Habilitar Manager GUI
RUN curl -LO https://archive.apache.org/dist/tomcat/tomcat-10/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION-manager.war \
    && mv apache-tomcat-$TOMCAT_VERSION-manager.war $CATALINA_HOME/webapps/manager.war

# Configurar usuário admin para Manager
RUN echo "<tomcat-users>\n\
  <role rolename=\"manager-gui\"/>\n\
  <role rolename=\"admin-gui\"/>\n\
  <user username=\"$TOMCAT_USER\" password=\"$TOMCAT_PASSWORD\" roles=\"manager-gui,admin-gui\"/>\n\
</tomcat-users>" > $CATALINA_HOME/conf/tomcat-users.xml

# Expor porta 8080
EXPOSE 8080

# Copiar entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Rodar Tomcat
ENTRYPOINT ["/entrypoint.sh"]
