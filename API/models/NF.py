import xmltodict, json, jsonschema

class NF:
    def __init__(self, XML):
        self.xml = XML
        self.json : json = json.loads(self.convertToJson())

    def convertToJson(self):
        # Conversões
        if self.xml:
            xml = xmltodict.parse(self.xml, attr_prefix='@', cdata_key='#text', force_list=None)
            Json = json.dumps(xml, ensure_ascii=False, separators=(',', ':'))

        # Verificação do schema
        Json = self.validateJson(Json)

        if Json is not None:
            ...
        return Json

    def validateJson(self, Json):
        '''
        Valida o JSON com o schema.
        Garante que o JSON comece pela chave "NFe",
        ignorando o que vier antes (ex: nfeProc, protNFe etc).
        '''
        try:
            instance = json.loads(Json)

            # Garante que o JSON comece em "NFe"
            if "NFe" in instance:
                instance = instance["NFe"]
            elif "nfeProc" in instance and "NFe" in instance["nfeProc"]:
                instance = instance["nfeProc"]["NFe"]
            elif "enviNFe" in instance and "NFe" in instance["enviNFe"]:
                instance = instance["enviNFe"]["NFe"]
            else:
                print("Estrutura inválida: chave 'NFe' não encontrada.")
                return None

            # Validação contra o schema
            jsonschema.validate(instance=instance, schema=self.getSchema())
            print("Arquivo JSON é válido!")
            return json.dumps(instance, ensure_ascii=False)

        except jsonschema.ValidationError as e:
            print(f"Erro de validação do JSON: {e.message}")
            return None
        except Exception as e:
            print(f"Erro ao validar o JSON: {e}")
            return None
    
    def getSchema(self):
        '''
        Retorna um schema json para as NFs
        '''
        return {
            "$schema": "https://json-schema.org/draft-07/schema#",
                "files": {
                "type": "object",
                "properties": {
                    "nfeProc": {
                    "type": "object",
                    "properties": {
                        "@xmlns": { "type": "string" },
                        "@versao": { "type": "string" },
                        "NFe": {
                        "type": "object",
                        "properties": {
                            "infNFe": {
                            "type": "object",
                            "properties": {
                                "@Id": { "type": "string" },
                                "@versao": { "type": "string" },
                                "ide": {
                                "type": "object",
                                "properties": {
                                    "cUF": { "type": "string" },
                                    "cNF": { "type": "string" },
                                    "natOp": { "type": "string" },
                                    "mod": { "type": "string" },
                                    "serie": { "type": "string" },
                                    "nNF": { "type": "string" },
                                    "dhEmi": { "type": "string", "format": "date-time" },
                                    "tpNF": { "type": "string" },
                                    "idDest": { "type": "string" },
                                    "cMunFG": { "type": "string" },
                                    "tpImp": { "type": "string" },
                                    "tpEmis": { "type": "string" },
                                    "cDV": { "type": "string" },
                                    "tpAmb": { "type": "string" },
                                    "finNFe": { "type": "string" },
                                    "indFinal": { "type": "string" },
                                    "indPres": { "type": "string" },
                                    "indIntermed": { "type": "string" },
                                    "procEmi": { "type": "string" },
                                    "verProc": { "type": "string" }
                                },
                                "required": ["cUF", "cNF", "natOp", "mod", "nNF", "dhEmi"]
                                },
                                "emit": {
                                "type": "object",
                                "properties": {
                                    "CNPJ": { "type": "string" },
                                    "xNome": { "type": "string" },
                                    "xFant": { "type": "string" },
                                    "enderEmit": {
                                    "type": "object",
                                    "properties": {
                                        "xLgr": { "type": "string" },
                                        "nro": { "type": "string" },
                                        "xBairro": { "type": "string" },
                                        "cMun": { "type": "string" },
                                        "xMun": { "type": "string" },
                                        "UF": { "type": "string" },
                                        "CEP": { "type": "string" },
                                        "cPais": { "type": "string" },
                                        "xPais": { "type": "string" }
                                    },
                                    "required": ["xLgr", "nro", "xMun", "UF"]
                                    },
                                    "IE": { "type": "string" },
                                    "CRT": { "type": "string" }
                                },
                                "required": ["CNPJ", "xNome", "enderEmit"]
                                },
                                "dest": {
                                "type": "object",
                                "properties": {
                                    "CPF": { "type": "string" },
                                    "xNome": { "type": "string" },
                                    "enderDest": {
                                    "type": "object",
                                    "properties": {
                                        "xLgr": { "type": "string" },
                                        "nro": { "type": "string" },
                                        "xCpl": { "type": "string" },
                                        "xBairro": { "type": "string" },
                                        "cMun": { "type": "string" },
                                        "xMun": { "type": "string" },
                                        "UF": { "type": "string" },
                                        "CEP": { "type": "string" }
                                    },
                                    "required": ["xLgr", "nro", "xMun", "UF"]
                                    },
                                    "indIEDest": { "type": "string" }
                                },
                                "required": ["CPF", "xNome", "enderDest"]
                                },
                                "det": {
                                "type": "object",
                                "properties": {
                                    "@nItem": { "type": "string" },
                                    "prod": {
                                    "type": "object",
                                    "properties": {
                                        "cProd": { "type": "string" },
                                        "cEAN": { "type": "string" },
                                        "xProd": { "type": "string" },
                                        "NCM": { "type": "string" },
                                        "CEST": { "type": "string" },
                                        "CFOP": { "type": "string" },
                                        "uCom": { "type": "string" },
                                        "qCom": { "type": "string" },
                                        "vUnCom": { "type": "string" },
                                        "vProd": { "type": "string" },
                                        "uTrib": { "type": "string" },
                                        "qTrib": { "type": "string" },
                                        "vUnTrib": { "type": "string" },
                                        "vOutro": { "type": "string" },
                                        "indTot": { "type": "string" },
                                        "xPed": { "type": "string" }
                                    },
                                    "required": ["cProd", "xProd", "vProd"]
                                    },
                                    "imposto": {
                                    "type": "object"
                                    }
                                },
                                "required": ["@nItem", "prod"]
                                }
                            },
                            "required": ["@Id", "ide", "emit", "dest", "det"]
                            },
                            "Signature": { "type": "object" }
                        },
                        "required": ["infNFe"]
                        },
                        "protNFe": { "type": "object" }
                    },
                    "required": ["@xmlns", "NFe"]
                    }
                },
                "required": ["nfeProc"]
                }
            }

    def getAllProducts(self, order = False):
        '''
        Retorna todos os produtos da nota fiscal
        '''
        if self.json is not None:
            try:
                products = self.json["infNFe"]["det"]

                if isinstance(products, dict):
                    products = [products]

                sorted_products = sorted(products, key=lambda x: x["prod"]["xProd"])
                return sorted_products
            except Exception as e:
                print(e)
        return None
    
    def getIdNF(self):
        '''
        Retorna o ID da NF
        '''
        if self.json is not None:
            try:
                r = self.json["infNFe"]["@Id"]
                return r
            except Exception as e:
                print(e)
        return None

    def getAllTax(self):
        '''
        Busca por uma taxa informada
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
        
        if self.json is not None:
            products = self.getAllProducts()

            # Percorre todos os produtos
            for product in products:
                # Percorre as taxas
                tax["ICMS"]  += self.getICMS(product["imposto"].get("ICMS", {}))
                tax["IPI"]   += self.getIPI(product["imposto"].get("IPI", {}))
                tax["PIS"]   += self.getPIS(product["imposto"].get("PIS", {}))
                tax["COFINS"]+= self.getCOFINS(product["imposto"].get("COFINS", {}))
                tax["ISSQN"] += self.getISSQN(product["imposto"].get("ISSQN", {}))
                tax["II"]    += self.getII(product["imposto"].get("II", {}))

                # Soma todas as taxas
                for t in tax.keys():
                    if t != 'Total':
                        tax["Total"] += tax[t]
                return tax
        return 0


    def getICMS(self, product):
        '''
        Obtém o total de ICMS
        '''
        total_icms = 0.0

        # Percorre todas as chaves do dicionário principal (ex: ICMS00, ICMS10, etc)
        for _, conteudo in product.items():
            if isinstance(conteudo, dict):
                # Se existir vICMS, soma
                if 'vICMS' in conteudo:
                    total_icms += float(conteudo['vICMS'])
        print("ICMS:", total_icms)
        return total_icms

    def getIPI(self, product):
        '''
        Obtem o total de IPI
        '''
        total_ipi = 0.0
        for _, conteudo in product.items():
            if isinstance(conteudo, dict) and 'vIPI' in conteudo:
                total_ipi += float(conteudo['vIPI'])
        return total_ipi
    
    def getPIS(self, product):
        '''
        Obtem o total do PIS
        '''
        total_pis = 0.0
        for _, conteudo in product.items():
            if isinstance(conteudo, dict) and 'vPIS' in conteudo:
                total_pis += float(conteudo['vPIS'])
        return total_pis
    
    def getCOFINS(self, product):
        '''
        Obtem o total do COFINS
        '''
        total_cofins = 0.0
        for _, conteudo in product.items():
            if isinstance(conteudo, dict) and 'vCOFINS' in conteudo:
                total_cofins += float(conteudo['vCOFINS'])
        return total_cofins
    
    def getISSQN(self, product):
        '''
        Obtem o total do ISSQN
        '''
        total_issqn = 0.0

        if isinstance(product, dict):
            # Se o campo vISSQN estiver direto
            if 'vISSQN' in product:
                total_issqn += float(product['vISSQN'])
            # Caso o JSON venha com subgrupos (como outros impostos)
            for _, conteudo in product.items():
                if isinstance(conteudo, dict) and 'vISSQN' in conteudo:
                    total_issqn += float(conteudo['vISSQN'])

        return total_issqn
    
    def getII(self, product):
        '''
        Obtem o total do II
        '''
        total_ii = 0.0
        if isinstance(product, dict):
            if 'vII' in product:
                total_ii += float(product['vII'])
            # Caso venha aninhado em outro grupo
            for _, conteudo in product.items():
                if isinstance(conteudo, dict) and 'vII' in conteudo:
                    total_ii += float(conteudo['vII'])
        return total_ii