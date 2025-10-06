FROM ubuntu:22.04

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV TOMCAT_VERSION=10.1.46
ENV TOMCAT_USER=admin
ENV TOMCAT_PASS=admin123

RUN apt-get update && apt-get install -y \
    curl \
    openjdk-17-jdk \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Instalar Tomcat
RUN curl -fSL https://downloads.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -o /tmp/tomcat.tar.gz \
    && tar -xzf /tmp/tomcat.tar.gz -C /opt \
    && mv /opt/apache-tomcat-${TOMCAT_VERSION} $CATALINA_HOME \
    && rm /tmp/tomcat.tar.gz

# Copiar script de inicialização
COPY entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
