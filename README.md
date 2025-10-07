# Docker-Ubuntu-Tomcat

Este repositório contém um **Dockerfile** e um **script entrypoint.sh** para configurar e iniciar automaticamente o **Apache Tomcat 10** com **JDK 17** em um contêiner Docker.

---

## 🚀 Funcionalidades

- Instalação do Apache Tomcat.
- Criação automática de usuário administrador (`admin` / `admin`).
- Acesso remoto liberado para Tomcat Manager e Host Manager.
- Instalação de dependências Java para conexão a bancos de dados.
- Início automático do Tomcat em segundo plano.

---

## 🛠️ Estrutura do Repositório

| Arquivo | Descrição |
|---------|-----------|
| `Dockerfile` | Define a imagem Docker com base no Tomcat 10 + JDK 17, copia o entrypoint e expõe as portas. |
| `entrypoint.sh` | Script que configura o Tomcat, cria o usuário admin, libera acesso remoto e inicia o Tomcat. |

---

## 📦 Como Usar

### 1️⃣ Usar a imagem pronta do Docker Hub

Você não precisa buildar nada, apenas fazer pull da imagem:

```bash
docker pull joaovitorgomes12/tomcatmanager:10.1-jdk17
docker run -d -p 80:8080 --name tomcat joaovitorgomes12/tomcatmanager:10.1-jdk17
2️⃣ Buildar localmente
Clone o repositório:


git clone https://github.com/jvzerocapa/Docker-ubuntu-tomcat.git
cd Docker-ubuntu-tomcat
Construa a imagem:


docker build -t ubuntu-tomcat .
Execute o contêiner:


docker run -d -p 80:8080 --name tomcat ubuntu-tomcat
🌐 Acesso ao Tomcat
Manager: http://<host>/manager/html

Usuário: admin

Senha: admin

Como o contêiner mapeia a porta 8080 do Tomcat para 80 do host, basta acessar http://<host>/manager/html.

🔄 Alterar versão do Tomcat / JDK
Se precisar de outra versão, basta alterar a linha no Dockerfile:

dockerfile
Copiar código
FROM tomcat:10.1-jdk17
para a versão que desejar.

✅ Observações
O script entrypoint.sh garante que o Tomcat Manager e Host Manager sejam copiados caso não existam.

Cria o usuário admin com todas as permissões necessárias.

Remove restrições de acesso remoto padrão do Tomcat.

Instala dependências Java necessárias para conexões com bancos de dados.
