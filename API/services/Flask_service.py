from flask import request, jsonify
from models.NF import NF

class Flask_service:
    def __init__(self, controller):
        @controller.flask.route('/nf', methods=['POST'])
        def nf_route():
            '''
            Executa a inserção de NFs
            '''
            xml = request.data.decode('utf-8')

            nf = NF(XML=xml)

            if nf.json is not None:
                controller.data.addNF(nf)
            
                return jsonify(nf.json), 200
            
            return jsonify({'status': 'error'}), 201
        
        @controller.flask.route('/info', methods=['GET'])
        def info():
            '''
            Executa buscas em NFs
            '''
            req = {}
            req['command'] = request.args.get('command', type=str)
            req['id'] = request.args.get('id', type=str)
            req['order'] = request.args.get('order', type=bool)

            req['order'] = True if req['order'] is None else req['order']

            response = controller.data.getFromJSON(req)

            return jsonify(response)
        