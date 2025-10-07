Docker-ubuntu-tomcat

Este repositório contém um Dockerfile e um script entrypoint.sh para configurar e iniciar automaticamente o Apache Tomcat 10 com Java 17 em um contêiner Docker.

🚀 Funcionalidade

Usa imagem oficial do Tomcat 10 com Java 17.

Configuração do Tomcat com usuário administrador (admin / admin).

Configuração do acesso remoto ao Tomcat Manager e Host Manager.

Início automático do Tomcat em segundo plano via entrypoint.sh.

Instalação de dependências necessárias para que aplicações Java se conectem a bancos de dados.

🛠️ Arquivos

Dockerfile: Define a imagem Docker baseada no Tomcat oficial, copia o entrypoint.sh, dá permissão de execução e expõe a porta 8080.

entrypoint.sh: Script de inicialização que:

Copia os apps manager e host-manager se não existirem.

Cria o usuário admin com acesso total.

Libera o acesso remoto aos apps manager e host-manager.

Instala dependências do Java necessárias para conexão a bancos.

Inicia o Tomcat.

⚠️ Se você precisar usar outra versão do Tomcat ou Java, basta alterar a linha FROM tomcat:10.1-jdk17 no Dockerfile para a versão desejada.

📦 Como Usar

Clone o repositório:

git clone https://github.com/jvzerocapa/Docker-ubuntu-tomcat.git
cd Docker-ubuntu-tomcat


Construa a imagem Docker:

docker build -t ubuntu-tomcat .


Execute o contêiner:

docker run -d -p 8080:8080 --name tomcat ubuntu-tomcat


Acesse o Tomcat:

URL: http://localhost:8080

Usuário: admin

Senha: admin

🔐 Acesso Remoto

O acesso ao Tomcat Manager e Host Manager foi configurado para permitir conexões remotas. Certifique-se de que sua rede e firewall permitam acesso à porta 8080.