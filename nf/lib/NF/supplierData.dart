import 'dart:convert';

import 'package:nf/settings.dart';
import 'package:http/http.dart' as http;

class Supplierdata {
  late String name;
  late String site;
  late String CNPJ;

  late List<String> nfs;

  static Future<Supplierdata> fromServer() async {
    Supplierdata instance = Supplierdata();

    Map<String, dynamic> json = {};

    String url = Settings.getUrlSuppliers();

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          json = decoded;
        } else {
          json = Map<String, dynamic>.from(decoded);
        }
      } else {
        throw Exception('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      json = {};
    }

    instance.CNPJ = (json['CNPJ'] ?? "").toString();
    instance.name = (json['NAME'] ?? "").toString();
    instance.site = (json['SITE'] ?? "").toString();

    if (json['nfs'] is List) {
      instance.nfs = (json['products'] as List).map((item) {
        return (item ?? "").toString();
      }).toList();
    }

    return instance;
  }
}
