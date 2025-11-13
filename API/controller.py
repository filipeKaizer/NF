from services.Flask_service import Flask_service
from flask import Flask
from config import Config
from data import Data
from services.database import Database

class Controller:
    def __init__(self):
        self.flask = Flask(__name__)
        self.config = Config()

        # Base de dados
        self.database = Database(self)

        # Memória principal
        self.data = Data(self.database)

        # Importa as rotas
        Flask_service(self)
        self.flask.run(host=self.config.FLASK_IP, port=self.config.PORT, debug=self.config.DEBUG)

if __name__ == "__main__":
    Controller()
    