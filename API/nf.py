import xmltodict, json

class NF:
    def __init__(self, XML, Json):
        self.xml = XML
        self.json = Json
        ...

    def fromXML(XML):
        xml = xmltodict.parse(XML, attr_prefix='@', cdata_key='#text', force_list=None)
        Json = json.dumps(xml, ensure_ascii=False, indent=2)

        super.__init__(XML, Json)

