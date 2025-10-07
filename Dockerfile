# Usa imagem oficial estável do Tomcat 10 + Java 17
FROM tomcat:10.1-jdk17

# Copia o script de inicialização customizado
COPY entrypoint.sh /entrypoint.sh

# Dá permissão de execução ao script
RUN chmod +x /entrypoint.sh

# Expõe a porta padrão do Tomcat
EXPOSE 8080

# Usa o entrypoint customizado
ENTRYPOINT ["/entrypoint.sh"]
