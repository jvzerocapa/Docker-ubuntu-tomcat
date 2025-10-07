# Docker-Ubuntu-Tomcat

Este repositório contém um **Dockerfile** e um **entrypoint.sh** para configurar e iniciar automaticamente o **Apache Tomcat 10** com **JDK 17** em um contêiner Docker.

---

## 🚀 Funcionalidades

- Instalação do Apache Tomcat 10 + JDK 17  
- Criação automática do usuário administrador (`admin` / `admin`)  
- Acesso remoto liberado para **Tomcat Manager** e **Host Manager**  
- Instalação de dependências Java para conexão a bancos de dados  
- Início automático do Tomcat em segundo plano  

---

## 🛠️ Estrutura do Repositório

| Arquivo           | Descrição                                                                 |
|------------------|---------------------------------------------------------------------------|
| `Dockerfile`      | Define a imagem Docker, copia o entrypoint e expõe as portas 80 e 8080    |
| `entrypoint.sh`   | Script que configura o Tomcat, cria usuário admin, libera acesso remoto e inicia o Tomcat |

---

## 📦 Passo 1 – Usando a imagem pronta do Docker Hub

Você não precisa buildar nada, apenas faça pull da imagem pronta:

```bash
docker pull joaovitorgomes12/tomcatmanager:10.1-jdk17
Execute o contêiner mapeando a porta 80 do host para 8080 do Tomcat:

docker run -d -p 80:8080 --name tomcat joaovitorgomes12/tomcatmanager:10.1-jdk17
✅ Pronto! O Tomcat já estará rodando.

📦 Passo 2 – Buildando a imagem localmente
Clone o repositório:


git clone https://github.com/jvzerocapa/Docker-ubuntu-tomcat.git
cd Docker-ubuntu-tomcat
Construa a imagem:


docker build -t ubuntu-tomcat .
Execute o contêiner:


docker run -d -p 80:8080 --name tomcat ubuntu-tomcat
🔹 Agora o Tomcat está rodando localmente, igual à imagem do Docker Hub.

🌐 Passo 3 – Acessando o Tomcat Manager
URL: http://<host>/manager/html

Usuário: admin

Senha: admin

🔹 Como mapeamos a porta 8080 do Tomcat para a 80 do host, basta acessar a porta 80 no navegador.

🔄 Passo 4 – Alterando a versão do Tomcat / JDK
Se precisar usar outra versão do Tomcat ou JDK, altere a linha do Dockerfile:


FROM tomcat:10.1-jdk17
🔹 Substitua 10.1-jdk17 pela versão desejada.

⚙️ Passo 5 – O que o entrypoint.sh faz
Garante que os diretórios manager e host-manager existam

Cria o usuário admin com permissões manager-gui e admin-gui

Libera o acesso remoto aos aplicativos manager e host-manager

Instala dependências Java necessárias para conexão com bancos de dados

Inicia o Tomcat em segundo plano automaticamente

🔧 Observações
O container expõe as portas 8080 e 80, permitindo mapear a porta que desejar no host.

A imagem pronta no Docker Hub permite rodar diretamente sem precisar buildar localmente.

Se precisar de outra versão do Tomcat ou JDK, basta alterar a linha FROM tomcat:10.1-jdk17 no Dockerfile e rebuildar, ou fazer pull de outra tag correspondente.
