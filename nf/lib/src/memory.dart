import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nf/NF/NF.dart';
import 'package:nf/settings.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

class Memory extends ChangeNotifier {
  late List<Nf> nfs = [];
  late List<XmlDocument> files = [];

  Memory.new() {
    List<Tax> tax = [
      Tax(type: "ICMS", percent: 10),
      Tax(type: "IPI", percent: 9),
    ];

    List<Product> products = [
      Product(
        qtd: 10,
        valUnit: 5.53,
        name: "Desodorante",
        cod: "626231",
        EAN: "6223145",
        tax: tax,
      ),
      Product(
        qtd: 7,
        valUnit: 72,
        name: "Travesseiro",
        cod: "623295",
        EAN: "983375",
        tax: tax,
      ),
    ];

    nfs = [
      Nf(
        total: 1000,
        tax: 10,
        qtdProd: 5,
        general: General("16546518", DateTime.now(), 6232923, "Sla", 1),
        emit: Emit("Amazon", "166", "626260959", "62626", Address.none()),
        remet: Remet(
          "Filipe Sacchet Kaizer",
          "04097842064",
          "",
          Address.none(),
        ),
        products: products,
      ),
      Nf(
        total: 2000,
        tax: 23,
        qtdProd: 3,
        general: General("6233", DateTime.now(), 1, "Sdqwd", 1),
        emit: Emit("Google", "13", "6262163", "62213", Address.none()),
        remet: Remet(
          "Filipe Sacchet Kaizer",
          "04097842064",
          "",
          Address.none(),
        ),
        products: products,
      ),
    ];
  }

  void addXMLFile(File xmlFile) {
    String content = xmlFile.readAsStringSync();

    // Remove <?xml ... ?> declaration if present
    content = content.replaceFirst(RegExp(r'<\?xml.*?\?>'), '');

    final document = XmlDocument.parse(content);

    files.add(document);

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
          print(response.body);
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

    // Mostra caixa de texto com o status
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$sended $failure")));
    files = [];
  }

  String plural(int val) {
    return (val > 1) ? "s" : "";
  }
}
