from flask import request, jsonify
from API.models.NF import NF

class Flask_service:
    def __init__(self, controller):
        @controller.flask.route('/nf', methods=['POST'])
        def nf_route():
            '''
            Executa as funcionalidade do nf
            '''
            xml = request.data.decode('utf-8')

            nf = NF(xml)

            if nf.json is not None:
                controller.data.addNF(nf)
            
                return jsonify(nf.json), 200
            
            return jsonify({'status': 'error'}), 201
        