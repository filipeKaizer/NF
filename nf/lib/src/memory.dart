import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nf/NF/NF.dart';
import 'package:nf/NF/invoiceData.dart';
import 'package:nf/NF/taxData.dart';
import 'package:nf/settings.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

class Memory extends ChangeNotifier {
  late List<XmlDocument> files = [];

  late Invoicedata invoicedata;
  late Taxdata taxdata;

  Memory() {
    invoicedata = Invoicedata();
    taxdata = Taxdata();

    _refreshData();
  }

  Future<void> _refreshData() async {
    try {
      invoicedata = await Invoicedata.fromServer();
      taxdata = await Taxdata.fromServer();
      notifyListeners();
    } catch (e) {
      print("Erro ao atualizar dados: $e");
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
    _refreshData();
  }

  String plural(int val) {
    return (val > 1) ? "s" : "";
  }
}
