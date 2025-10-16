from Flask_service import Flask_service
from flask import Flask
from config import Config

class Controller:
    def __init__(self):
        self.flask = Flask(__name__)
        self.config = Config()

        # Importa as rotas
        Flask_service(self)
        self.flask.run(host='127.0.0.1', port=self.config.PORT, debug=self.config.DEBUG)

if __name__ == "__main__":
    Controller()