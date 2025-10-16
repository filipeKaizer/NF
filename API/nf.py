import xmltodict, json, jsonschema

class NF:
    def __init__(self, XML):
        self.xml = XML
        self.json = self.convertToJson()
        ...

    def convertToJson(self):
        # Conversões
        if self.xml:
            xml = xmltodict.parse(self.xml, attr_prefix='@', cdata_key='#text', force_list=None)
            Json = json.dumps(xml, ensure_ascii=False, indent=2)

        #Verificação do schema
        Json = self.validateJson(Json)
        return Json

    def validateJson(self, Json):
        '''
        Valida o Json com o schema
        '''
        if jsonschema.validate(instance=Json, schema=self.getSchema()):
            print("Arquivo Json é válido!")
            return Json
        else:
            return None
        
    def getSchema(self):
        return {
            "$schema": "https://json-schema.org/draft-07/schema#",
            "type": "object",
            "properties": {
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
            },
            "required": ["files"]
            }
