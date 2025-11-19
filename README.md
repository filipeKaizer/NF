# NF System

`Dev: Filipe Sacchet Kaizer`
`Disciplina: Linguagens de Marcação Extensíveis` 

`Apresetação no Youtube: https://youtu.be/I5WyfdAn6aY`

O presente projeto contempla um sistema completo destinado armazenamento, processamento e visualização de notas fiscais eletrônicas. 

O sistema desenvolvido é composto por uma API central em `Python` e uma aplicação móvel desenvolvida em `Flutter`.  

# Clonando Este Respositório

Para clonar este respositório, execute o comando abaixo no diretório de destino desejado:

~~~bash
git clone https://github.com/filipeKaizer/NF.git
~~~

Após clonado, acesse o repositório clonado com o comando abaixo:

~~~bash
cd NF
~~~

# Executando o Sistema

## Banco de dados

A API foi planejada para trabalhar com o SGBD **Mysql**. Embora também seja possível utilizar a API com outros SGBDs, por questões de compatibilidade, recomenda-se fortemente que seja utilizado o MySQL.

1°. **Instalando o MySQL:**
Antes de iniciar a configuração do Mysql, certifique-se que o mesmo já se encontra instalado no seu sistema operacional executando o comando:

~~~bash
sudo apt install mysql-server 
~~~

2°. **Criando a base de dados:**

Uma vez instalado, acesse-o:

~~~bash
sudo mysql -u root -p 'senha_aqui'
~~~

Dentro do Mysql, crie a base de dados para a API e acesse-a:

~~~SQL
CREATE DATABASE nf;
USE nf;
~~~

Dentro da base de dados criada, crie a tabela de dados para o armazenamento das notas fiscais:

~~~SQL
CREATE TABLE nf(
    id INT AUTO_INCREMENT PRIMARY KEY,
    number VARCHAR(255) UNIQUE,
    json JSON,
    Date DATETIME NOT NULL
);
~~~

3°. **Crie o usuario:**

Para garantir a segurança dos dados, crie um usuário exclusivo para a base de dados criada:

~~~SQL
CREATE USER 'user'@'localhost' IDENTIFIED BY 'senha_forte';
GRANT ALL PRIVILEGES ON nf.* TO 'user'@'localhost';
FLUSH PRIVILEGES;
~~~

***OBS:** O locahost garante apenas acesso local. Caso deseje acessar o banco de dados de outra máquina, troque para o IP da mesma ou deixe o acesso livre com o '%' **(não recomendado)**.*

## API

A API foi inteiramente desenvolvida em Python. Desta forma, é importante que o usuário possua uma versão atual do Python instalado em seu sistema operacional. Além do ambiente python, o usuário deverá se certificar que todas as bibliotecas estejam instaladas. Abaixo são listados os passos para a execução da API:

1°. **Crie um ambiente virtual Python:**

Para isolar a execução da API do restante do sistema operacional, execute o comando abaixo para criar o seu ambiente virtual, substituindo o `virtual` pelo nome do seu ambiente virtual:

~~~bash
python -m venv virtual
~~~

Depois entre no seu ambiente virtual com o comando `source`:

~~~bash
source virtual/bin/activate
~~~

2°. **Instale os pacotes:**

Uma vez dentro do seu ambiente virtual, instale as bibliotecas necessárias disponíveis em *API/requirements.txt*:

~~~bash
pip install -r API/requirements.txt
~~~

3°. **Configurando a API**:

Após configurado o ambiente de execução, configure a API criando um arquivo *.env* dentro da pasta API/. 

~~~bash
touch API/.env
nano API/.env
~~~

A API utilizará este arquivo para a inicialização das suas variáveis internas, utilizando a biblioteca *dotenv*. Para que a mesma funcione corretamente, copie o conteúdo abaixo para dentro do *.env* criado e substitua os valores das suas variáveis com os seus respectivos dados.

~~~.env
FLASK_PORT=5000 
FLASK_DEBUG=False
FLASK_IP="192.168.0.1" 
DATABASE_IP="127.0.0.1"
DATABASE_PORT=3306 
DATABASE_PASSWORD="senha_do_banco_de_dados"
DATABASE_DATABASE="nf"
DATABASE_USER="usuario"
DATABASE_LIMIT=15
~~~

**Descrição das variáveis:**

| Variável | Descrição |
|-----------|------------|
| `FLASK_PORT` | Porta utilizada pelo serviço Flask — **não alterar** |
| `FLASK_IP` | IP utilizado pelo serviço Flask — **altere para o ip da sua máquina** |
| `FLASK_DEBUG` | Ativa o modo debug do Flask — **mantenha False em produção** |
| `DATABASE_IP` | IP do banco de dados — **use 127.0.0.1 se for na mesma máquina** |
| `DATABASE_PORT` |Porta do banco de dados — **MySQL usa o 3306 por padrão** |
| `DATABASE_PASSWORD` |Senha do banco de dados |
| `DATABASE_DATABASE` |Nome da base de dados usada pela API — **Deve ser o mesmo utilizado durante a configuração do banco de dados** |
| `DATABASE_USER` |Usuário do banco de dados com privilégios de escrita e leitura na database da API — **Não é recomendado o uso de 'admin'** |
| `DATABASE_LIMIT` |É o número de NFs carregadas do banco de dados ao iniciar a API — **aumente ou diminua conforme a memória RAM do seu sistema** |

4°. **Executando a API:**

Uma vez concluídos os passos anteriores, já é possível executar a API. Como a arquitetura da API é *MVC*, a mesma conta com uma classe inicial `controller.py`. Esta deverá ser executada para inicializar o sistema. Execute o comando abaixo dentro do ambiente virtual python:

~~~bash
python controller.py
~~~

A sua saída deverá ser parecida com essa: 

~~~bash
* Serving Flask app 'controller'
 * Debug mode: on
 * Running on http://'FLASK_IP':FLASK_PORT 
Press CTRL+C to quit
 * Restarting with stat
 * Debugger is active!
 * Debugger PIN: ***-***-***
~~~

## App

A aplicação foi inteiramente desenvolvida utilizando o framework de desenvolvimento multiplataforma **Flutter**. 

1°. **Instale o Flutter:**

Antes de prosseguir para o passos de configuração e compilação da aplicação, instale o Flutter na sua máquina, seguindo os passos disponíveis em [Flutter - Get Started](https://docs.flutter.dev/get-started/quick?_gl=1*ozh3ba*_ga*MTQ1NDg1ODA0MS4xNzYwMDM1MDYw*_ga_04YGWK0175*czE3NjMwNTI5NzgkbzckZzAkdDE3NjMwNTI5NzgkajYwJGwwJGgw).

2°. **Configure o App:**

Para que a aplicação funcione corretamente, é necessário configura-la para que a mesma se comunique com a API. Para configurá-la, acesse o arquivo de configurações `nf/lib/settings.dart`.

Nste arquivo, altere as linhas abaixo conforme a configuração da API:

~~~Dart
static String serverIP = 'FLASK_IP'; // Mesmo do FLASK_IP
static int serverPort = 5000; // Mesmo do FLASK_PORT 
~~~

3°. **Compile e execute:**

Por ser multiplataforma, o mesmo permite a execução da aplicação em diversos ambientes: Android/IOS, Web e Desktop. É possível tanto executar a aplicação localmente, como também compilar o projeto para o formato desejado. Abaixo são apresentadas estas duas possibilidades:


3.1. **Execução:**

Para verificar os dispositivos dispovíveis, execute o comando abaixo:

~~~bash
flask devices
~~~

A sua saída deverá ser parecida com essa:

~~~bash
Chrome (web)      • chrome      [...]
Edge (web)        • edge        [...]
Windows (desktop) • windows     [...]
...
~~~

Execute trocando o *id* abaixo pelo dispositivo desejado: 

~~~bash
flutter run -d id
~~~

Exemplo:

~~~bash
flutter run -d windows
~~~

ou

~~~bash
flutter run -d chrome
~~~

3.2. **Compilando projeto:**

É possível também compilar o projeto para posterior execução em um servidor próprio utilizando os comandos:

**Para WEB:**
~~~bash
flutter build web
~~~

**Para Windows:**
~~~bash
flutter build windows
~~~

**Para Linux**
~~~bash
flutter build linux
~~~

**Para MacOS**
~~~bash
flutter build macos
~~~

**Para Android:**
~~~bash
flutter build apk --release
~~~
