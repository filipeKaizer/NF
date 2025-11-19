from models.NF import NF
from services.database import Database

class Data:
    def __init__(self, database : Database):
        self.database = database

        self.NFs = self.database.loadAllNFs(15)

    def addNF(self, NF : NF):
        '''
        Adiciona uma nova NF e salva-a na base de dados
        '''
        if NF.json is not None:
            if not self.NFExists(NF.getIdNF()):
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
                    'products': self.getGeneralNFs(order=request['order']) # Informações das NFs
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
            return self.getAllTax(order=request['order']) 

        # Retorna todas as informações de uma nota fiscal
        if request['command'] == 'NF':
            if request['id'] is not None:
                for nf in self.NFs:
                    if request['id'] == nf.getIdNF():
                        return nf.getAllInfo()
                    
        # Retorna todos os fornecedores com suas notas fiscais
        if request['command'] == 'Suppliers':
            return self.getAllSuppliers()
        
        # Retorna todas as transportadoras com suas notas fiscais
        if request['command'] == 'Transporters':
            return self.getAllTransporters()

        return None
    
    def getAllSuppliers(self):
        """
        Obtém todos os suppliers distintos, agrupando NFs pelo mesmo CNPJ.
        """
        suppliers_map = {}

        for nf in self.NFs:
            supplier = nf.getSupplier()
            cnpj = supplier['CNPJ']

            # Se ainda não existe, adiciona o supplier no mapa
            if cnpj not in suppliers_map:
                suppliers_map[cnpj] = {
                    'NAME': supplier['NAME'],
                    'CNPJ': cnpj,
                    'SITE': supplier['SITE'],
                    'NFs': [supplier['NFs']]
                }
            else:
                # Se já existe, só adiciona a NF ao mesmo CNPJ
                suppliers_map[cnpj]['NFs'].append(supplier['NFs'])

        # Retorna como lista de dicionários
        return {
            'Suppliers': list(suppliers_map.values())
        }
    
    def getAllTransporters(self):
        """
        Obtém todos os transportadores distintos, agrupados pelo mesmo nome 
        """
        transporters_map = {}

        for nf in self.NFs:
            transporter = nf.getTransporter()
            cnpj = transporter['CNPJ']

            # Se ainda não existe, adiciona o transporter no mapa
            if cnpj not in transporters_map:
                transporters_map[cnpj] = {
                    'NAME': transporter['NAME'],
                    'CNPJ': cnpj,
                    'NFs': [transporter['NFs']]
                }
            else:
                # Se já existe, só adiciona a NF ao mesmo CNPJ
                transporters_map[cnpj]['NFs'].append(transporter['NFs'])

        # Retorna como lista de dicionários
        return {
            'Transporters': list(transporters_map.values())
        }
        
    def NFExists(self, number):
        '''
        Verifica se uma NF já existe na memória ou no banco de dados
        '''
        if len(self.NFs) > 0:
            for nf in self.NFs:
                if nf.getIdNF() == number:
                    return True
            return self.database.existsNF(number)

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
    
    def getAllTax(self, order = False):
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
                tax[t] += nf_tax.get(t, 0) or 0

        # Ordena por 'Total' decrescente
        if order:
            products.sort(key=lambda x: x.get('Total', 0) or 0, reverse=True)

        tax['products'] = products

        return tax
    
    def getGeneralNFs(self, order=False):
        '''
        Gera uma lista com dados gerais das NFs
        '''
        nfs = []
        for nf in self.NFs:
            nfs.append(nf.getGeneralInfo())
        
        if order:
            nfs.sort(key=lambda x: x.get('totalPrice', 0) or 0, reverse=True)

        return nfs