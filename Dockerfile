# Base Ubuntu
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

# Copiar tomcat-users.xml
COPY tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

# Copiar entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

# Expor portas
EXPOSE 8080
EXPOSE 8009
EXPOSE 8443

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
