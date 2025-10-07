# Docker-ubuntu-tomcat

Este repositório contém um Dockerfile e um script `entrypoint.sh` para configurar e iniciar automaticamente o Apache Tomcat em um contêiner Docker com JDK 17.

## 🚀 Funcionalidade

- Instalação do Apache Tomcat.
- Configuração do Tomcat com usuário administrador (`admin` / `admin`).
- Configuração do acesso remoto ao Tomcat Manager e Host Manager.
- Instalação de dependências Java necessárias para conexão a bancos de dados.
- Início automático do Tomcat em segundo plano.

## 🛠️ Arquivos

- **Dockerfile**: Define a imagem Docker com base no Tomcat 10 + JDK 17, copia o script de inicialização customizado e expõe as portas.
- **entrypoint.sh**: Script que configura o Tomcat, cria o usuário administrador, libera acesso remoto e inicia o Tomcat.

## 📦 Como Usar

### Opção 1: Usar a imagem já disponível no Docker Hub

```bash
docker pull joaovitorgomes12/tomcatmanager:10.1-jdk17
docker run -d -p 80:8080 --name tomcat joaovitorgomes12/tomcatmanager:10.1-jdk17
Opção 2: Buildar localmente
Clone o repositório:


git clone https://github.com/jvzerocapa/Docker-ubuntu-tomcat.git
cd Docker-ubuntu-tomcat
Construa a imagem Docker:


docker build -t ubuntu-tomcat .
Execute o contêiner:


docker run -d -p 80:8080 --name tomcat ubuntu-tomcat
🌐 Acesso ao Tomcat
Tomcat Manager: http://<host>/manager/html

Usuário: admin

Senha: admin

Observação: Como o contêiner está mapeando a porta 8080 do Tomcat para a porta 80 do host, basta acessar http://<host>/manager/html.

🔄 Alterar versão do Tomcat / JDK
Se precisar de outra versão, basta alterar a linha:

dockerfile
Copiar código
FROM tomcat:10.1-jdk17
no Dockerfile para a versão desejada.
