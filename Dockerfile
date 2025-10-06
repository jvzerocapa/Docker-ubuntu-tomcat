# Usa Ubuntu como base
FROM ubuntu:22.04

# Variáveis
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV TOMCAT_VERSION=10.1.46

# Instalar dependências
RUN apt-get update && apt-get install -y \
    curl \
    openjdk-17-jdk \
    dos2unix \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Baixar e instalar Tomcat
RUN curl -fSL https://dlcdn.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -o /tmp/tomcat.tar.gz \
    && tar -xzf /tmp/tomcat.tar.gz -C /tmp \
    && mv /tmp/apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME} \
    && rm /tmp/tomcat.tar.gz

# Baixar manager e host-manager (nem sempre vêm no tarball principal)
RUN curl -fSL https://dlcdn.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/webapps/manager.war -o ${CATALINA_HOME}/webapps/manager.war \
    && curl -fSL https://dlcdn.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/webapps/host-manager.war -o ${CATALINA_HOME}/webapps/host-manager.war

# Copiar entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

# Portas padrão
EXPOSE 8080 8443

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
