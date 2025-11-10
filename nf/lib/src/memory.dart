import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nf/NF/NF.dart';
import 'package:nf/NF/invoiceData.dart';
import 'package:nf/settings.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

class Memory extends ChangeNotifier {
  late List<XmlDocument> files = [];
  late Invoicedata invoicedata;

  Memory() {
    // Inicializa com valores padrão
    invoicedata = Invoicedata();
    // Busca os dados do servidor de forma assíncrona
    _loadInvoiceData();
  }

  // Método privado para carregar os dados do servidor
  Future<void> _loadInvoiceData() async {
    try {
      invoicedata = await Invoicedata.fromServer();
      print(invoicedata.totalPrice);
      notifyListeners(); // notifica os listeners quando os dados chegam
    } catch (e) {
      print("Erro ao carregar invoiceData: $e");
      // mantém invoicedata com valores padrão se houver erro
    }
  }

  void addXMLFile(File xmlFile) {
    String content = xmlFile.readAsStringSync();

    // Remove <?xml ... ?> declaration if present
    content = content.replaceFirst(RegExp(r'<\?xml.*?\?>'), '');

    final document = XmlDocument.parse(content);

    files.add(document);
    print("Adicionado");
    notifyListeners();
  }

  Future<void> sendXMLFile(BuildContext context) async {
    int send = 0;
    for (XmlDocument file in files) {
      try {
        final response = await http.post(
          Uri.parse(Settings.getUrl()),
          headers: {'Content-type': 'application/xml'},
          body: file.toString(),
        );

        if (response.statusCode == 200) {
          send++;
        }
      } catch (error) {
        // Nada a fazer
      }
    }

    String sended = "$send NF${plural(send)} enviado${plural(send)}";
    String failure = ((files.length - send) == 0)
        ? ""
        : "e ${(files.length - send)} NF${plural(files.length - send)} com erro.";

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$sended $failure")));

    files = [];
    _loadInvoiceData();
  }

  String plural(int val) {
    return (val > 1) ? "s" : "";
  }
}
