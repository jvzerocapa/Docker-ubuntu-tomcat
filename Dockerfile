# Base Ubuntu
FROM ubuntu:22.04

# Variáveis de ambiente
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV TOMCAT_VERSION=10.1.46
ENV TOMCAT_USER=admin
ENV TOMCAT_PASS=admin123

# Instalar dependências
RUN apt-get update && apt-get install -y \
    curl \
    openjdk-17-jdk \
    unzip \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Instalar Tomcat base
RUN curl -fSL https://dlcdn.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -o /tmp/tomcat.tar.gz \
    && tar -xzf /tmp/tomcat.tar.gz -C /opt \
    && mv /opt/apache-tomcat-${TOMCAT_VERSION} $CATALINA_HOME \
    && rm /tmp/tomcat.tar.gz

# Instalar Manager e Host Manager (não vêm no Tomcat base)
RUN curl -fSL https://dlcdn.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/extras/apache-tomcat-${TOMCAT_VERSION}-manager.tar.gz -o /tmp/manager.tar.gz \
    && tar -xzf /tmp/manager.tar.gz -C $CATALINA_HOME/webapps \
    && rm /tmp/manager.tar.gz

RUN curl -fSL https://dlcdn.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/extras/apache-tomcat-${TOMCAT_VERSION}-host-manager.tar.gz -o /tmp/host-manager.tar.gz \
    && tar -xzf /tmp/host-manager.tar.gz -C $CATALINA_HOME/webapps \
    && rm /tmp/host-manager.tar.gz

# Copiar entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

# Expor porta
EXPOSE 8080

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
