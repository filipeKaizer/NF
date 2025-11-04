from models.NF import NF
from services.database import Database

class Data:
    def __init__(self, database : Database):
        self.database = database

        self.NFs = []

    def addNF(self, NF : NF):
        self.NFs.append(NF)
        # Salva na base de dados
        if NF.json is not None:
            self.database.saveNF(Json=NF.json, nf_number=NF.getIdNF())

    def getFromJSON(self, request):
        '''
        Retorna os dados solicitados em info
        '''
        if len(self.NFs) > 0 and request is not None:
            products = []

            # Todos os produtos nas notas fiscais
            if request['comand'] == 'Products':
                for nf in self.NFs:
                    prods = nf.getAllProducts()
                    if len(prods) > 0:
                        for prod in prods:
                            products.append(prod)
                if request['order']:
                    products.sort()
                return products
            
            # Todos os produtos de uma única nota fiscal
            if request['comand'] == 'ProductNF':
                for nf in self.NFs:
                    if nf.getIdNF() == request['id']:
                        return nf.getAllProducts()
        

        return None