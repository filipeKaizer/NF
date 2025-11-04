from NF import NF

class Data:
    def __init__(self):
        self.NFs = []

    
    def addNF(self, NF : NF):
        self.NFs.append(NF)

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