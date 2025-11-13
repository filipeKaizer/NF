import mysql.connector
from mysql.connector import Error
import json
from models.NF import NF
class Database:
    def __init__(self, controller):
        self.host = controller.config.DATABASE_IP
        self.user = controller.config.DATABASE_USER
        self.password = controller.config.DATABASE_PASSWORD
        self.port = controller.config.DATABASE_PORT
        self.database = controller.config.DATABASE_DATABASE
        self.limit = controller.config.DATABASE_LIMIT or 15

    def create_connection(self):
        '''
        Inicializa a conexão
        '''
        try:
            connection = mysql.connector.connect(
                host=self.host,
                database=self.database,
                user=self.user,
                password=self.password,
                port=self.port
            )
            if connection.is_connected():
                return connection
        except Error as e:
            print(f"MySQL: Erro ao conectar ({e})")
            return None

    def saveNF(self, Json, nf_number):
        '''
        Salva um Json no banco de dados
        '''
        if Json is not None:
            try:
                connection = self.create_connection()

                cursor = connection.cursor()

                query = "INSERT IGNORE INTO nf (Date, json, number) VALUES (NOW(), %s, %s)"

                cursor.execute(query, (json.dumps(Json), nf_number))

                connection.commit()

                cursor.close()
                connection.close()
            except Error as e:
                ...

    def loadNFByNumber(self, nf_number):
        '''
        Carrega uma nota fiscal com base no seu número 
        '''
        if nf_number is not None:
            try:
                connection = self.create_connection()

                cursor = connection.cursor()

                query = f"SELECT json from nf where number = {nf_number} limit 1"

                cursor.execute(query)

                for (Json,) in cursor.fetchall():
                    result = json.loads(Json)

                    if result is not None:
                        return result

                cursor.close()
                connection.close()
            except Error as e:
                return None
        return None
    
    def existsNF(self, number):
        '''
        Verifica se uma nota fiscal já existe na base de dados
        '''
        nf = self.loadNFByNumber(number)

        print(nf)

        return False if nf is None else True

    def loadAllNFs(self, limit : int):
        '''
        Carrega as 'limit' mais recentes notas fiscais da base de dados 
        '''
        NFs = []
        limit = limit if limit is not None else self.limit
        try:
            connection = self.create_connection()

            cursor = connection.cursor()

            query = f"SELECT json from nf ORDER BY Date DESC limit {limit}"

            cursor.execute(query)

            for (Json,) in cursor.fetchall():
                r = json.loads(Json)
                if r is not None:
                    NFs.append(NF(JSON=Json))

        except Exception as e:
            print(f"Erro ao carregar notas fiscas do banco de dados: {e}")

        return NFs