import 'dart:convert';

import 'package:nf/settings.dart';
import 'package:http/http.dart' as http;

class TransportersData {
  late List<Transporter> transporters;

  TransportersData() {
    transporters = [];
  }

  static Future<TransportersData> fromServer() async {
    TransportersData instance = TransportersData();

    Map<String, dynamic> json = {};

    String url = Settings.getUrlTransporters();

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

    if (json['Transporters'] is List) {
      instance.transporters.clear();
      for (Map<String, dynamic> item in (json['Transporters'] as List)) {
        instance.transporters.add(Transporter.fromJson(item));
      }
    }

    return instance;
  }
}

class Transporter {
  late String CNPJ;
  late String name;
  late List<String> nfs;

  Transporter.fromJson(Map<String, dynamic> json)
    : name = (json['NAME'] ?? "").toString(),
      CNPJ = (json['CNPJ'] ?? "").toString(),
      nfs = _parseNfs(json['NFs']);

  static List<String> _parseNfs(dynamic raw) {
    if (raw is List) {
      return raw.map((e) => e.toString()).toList();
    }
    return <String>[];
  }
}
