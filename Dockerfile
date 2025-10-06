# Base
FROM ubuntu:22.04

# Variáveis de ambiente
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV TOMCAT_VERSION=10.1.46

# Instalar dependências
RUN apt-get update && apt-get install -y \
    curl \
    openjdk-17-jdk \
    unzip \
    nano \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Baixar e instalar Tomcat
RUN curl -fSL https://downloads.apache.org/tomcat/tomcat-10/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz -o tomcat.tar.gz \
    && tar -xzf tomcat.tar.gz \
    && mv apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME \
    && rm tomcat.tar.gz

# Habilitar Manager GUI
#RUN echo "<tomcat-users>\n\
 # <role rolename=\"manager-gui\"/>\n\
  #<role rolename=\"admin-gui\"/>\n\
  #<user username=\"admin\" password=\"admin123\" roles=\"manager-gui,admin-gui\"/>\n\
#</tomcat-users>" > $CATALINA_HOME/conf/tomcat-users.xml

# Copiar entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

# Expor portas padrão
EXPOSE 8080 8005 8009 80

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
