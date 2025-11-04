import json
from jsonpath_ng import parse


dados = ''

dados = json.loads(dados)


expr = parse('$.usuario.enderecos[*].cidade')
print([match.value for match in expr.find(dados)])