import 'package:flutter/material.dart';
import 'package:nf/NF/NF.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nf/settings.dart';

class Invoicedata {
  late double totalPrice = 0;
  late double totalTax = 0;
  late int TotalProducts = 0;
  late int totalNFs = 0;

  late List<Nf> NFS = [];

  static Future<Invoicedata> fromServer() async {
    final Invoicedata instance = Invoicedata();

    Map<String, dynamic> json = {};

    String url = Settings.getUrlInvoice();

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
    // Campos gerais
    instance.totalPrice = (json['totalPrice'] ?? 0).toDouble();
    instance.totalTax = (json['totalTax'] ?? 0).toDouble();
    instance.TotalProducts = (json['totalProducts'] ?? 0).toInt();
    // o JSON exemplo usa "totalNF" (singular)
    instance.totalNFs = (json['totalNF'] ?? json['totalNFs'] ?? 0).toInt();

    // Notas Fiscais
    instance.NFS = [];
    if (json['products'] is List) {
      instance.NFS = (json['products'] as List).map((item) {
        final Map<String, dynamic> p = Map<String, dynamic>.from(item);
        return Nf.simply(
          qtdProd: (p['totalProducts'] ?? 0).toInt(),
          tax: (p['totalTax'] ?? 0).toDouble(),
          total: (p['totalPrice'] ?? 0).toDouble(),
          number: (p['id'] ?? "").toString(),
        );
      }).toList();
    }

    return instance;
  }
}
