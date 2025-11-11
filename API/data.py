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
            # Dados gerais
            if request['command'] == 'General':
                return {
                    'totalNF': len(self.NFs), # Qtd de NFs
                    'totalProducts': self.getTotalProducts(), # Qtd de produtos
                    'totalPrice': self.getTotalPrice(), # Preço total
                    'totalTax': self.getAllTax()['Total'] or 0, # Total de taxas
                    'products': self.getGeneralNFs() # Informações das NFs
                }

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
        if request['command'] == 'Tax':
            return self.getAllTax()

        # Retorna todas as informações de uma nota fiscal
        if request['command'] == 'NF':
            if request['id'] is not None:
                for nf in self.NFs:
                    if request['id'] == nf.getIdNF():
                        return nf.getAllInfo()

        return None
    
    def getTotalProducts(self):
        '''
        Conta o total de produtos
        '''
        produtcs = 0
        for nf in self.NFs:
            produtcs += len(nf.getAllProducts())

        return produtcs
    
    def getTotalPrice(self):
        '''
        Obtem o preço total de todos os produtos
        '''
        total = 0
        for nf in self.NFs:
            total += nf.getTotalPrice()
        return total
    
    def getAllTax(self):
        '''
        Obtem todas as taxas
        '''
        tax = {
                'ICMS': 0,
                'IPI': 0,
                'PIS': 0,
                'COFINS': 0,
                'ISSQN': 0,
                'II': 0,
                'Total': 0
            }
        products = []
        for nf in self.NFs:
            nf_tax = nf.getAllTax()
            products.append(nf_tax)
            
            for t in tax.keys():
                tax[t] += nf_tax[t] if nf_tax[t] is not None else 0

        tax['products'] = products

        return tax
    
    def getGeneralNFs(self):
        '''
        Gera uma lista com dados gerais das NFs
        '''
        nfs = []
        for nf in self.NFs:
            nfs.append(nf.getGeneralInfo())
        return nfs