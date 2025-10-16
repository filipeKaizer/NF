from flask import request, jsonify

class Flask_service:
    def __init__(self, controller):
        @controller.flask.route('/nf', methods=['POST'])
        def nf_route():
            '''
            Executa as funcionalidade do nf
            '''
            xml = request.data.decode('utf-8')

            print(xml)