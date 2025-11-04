from dotenv import load_dotenv
import os

class Config:
    def __init__(self):
        load_dotenv()

        self.PORT = os.getenv("FLASK_PORT")
        self.DEBUG = os.getenv("FLASK_DEBUG")

        self.DATABASE_IP = os.getenv("DATABASE_IP")
        self.DATABASE_PORT = os.getenv("DATABASE_PORT")
        self.DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD")
        self.DATABASE_DATABASE = os.getenv("DATABASE_DATABASE")

        
