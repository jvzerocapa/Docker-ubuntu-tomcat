FROM ubuntu:22.04

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV TOMCAT_VERSION=10.1.46

RUN apt-get update && apt-get install -y \
    curl \
    openjdk-17-jdk \
    unzip \
    nano \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Baixar Tomcat base
RUN curl -fSL https://downloads.apache.org/tomcat/tomcat-10/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz -o tomcat.tar.gz \
    && tar -xzf tomcat.tar.gz \
    && mv apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME \
    && rm tomcat.tar.gz

# Baixar e instalar Manager e Host Manager apps
RUN curl -fSL https://downloads.apache.org/tomcat/tomcat-10/v$TOMCAT_VERSION/webapps/manager.war -o $CATALINA_HOME/webapps/manager.war \
    && curl -fSL https://downloads.apache.org/tomcat/tomcat-10/v$TOMCAT_VERSION/webapps/host-manager.war -o $CATALINA_HOME/webapps/host-manager.war

# Copiar entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 8080
EXPOSE 8443

ENTRYPOINT ["/entrypoint.sh"]
