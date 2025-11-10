from models.NF import NF
from services.database import Database

class Data:
    def __init__(self, database : Database):
        self.database = database

        self.NFs = []

    def addNF(self, NF : NF):
        # Salva na base de dados
        if NF.json is not None:
            self.NFs.append(NF)
            self.database.saveNF(Json=NF.json, nf_number=NF.getIdNF())

    def getFromJSON(self, request):
        '''
        Retorna os dados solicitados em info
        '''
        if len(self.NFs) > 0 and request is not None:
            products = []
            # Todos os produtos nas notas fiscais
            if request['command'] == 'Products':
                for nf in self.NFs:
                    prods = nf.getAllProducts()
                    if len(prods) > 0:
                        for prod in prods:
                            products.append(prod)
                if request['order']:
                    products.sort(key=lambda p: p['prod']['xProd'])
                return products
            
        # Todos os produtos de uma única nota fiscal
        if request['command'] == 'ProductNF':
            for nf in self.NFs:
                if nf.getIdNF() == request['id']:
                    products = nf.getAllProducts()
                    if request['order']:
                        products.sort(key=lambda p: p['prod']['xProd'])
                    return products
        
        # Todas as tributações
        if request['command'] == 'TaxAll':
            tax = {
                'ICMS': 0,
                'IPI': 0,
                'PIS': 0,
                'COFINS': 0,
                'ISSQN': 0,
                'II': 0,
                'Total': 0
            }
            
            for nf in self.NFs:
                nf_tax = nf.getAllTax()
                for t in tax.keys():
                    tax[t] += nf_tax[t] if nf_tax[t] is not None else 0
            
            return tax

        return None