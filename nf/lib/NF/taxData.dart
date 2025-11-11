import 'dart:convert';
import 'package:nf/settings.dart';
import 'package:http/http.dart' as http;

class Taxdata {
  late double cofins = 0;
  late double icms = 0;
  late double ii = 0;
  late double ipi = 0;
  late double issqn = 0;
  late double pis = 0;

  late List<ProductTax> productsTax;

  static Future<Taxdata> fromServer() async {
    final Taxdata instance = Taxdata();

    Map<String, dynamic> json = {};

    String url = Settings.getUrlTax();

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

    instance.cofins = (json['COFINS'] ?? 0).toDouble();
    instance.icms = (json['ICMS'] ?? 0).toDouble();
    instance.ii = (json['II'] ?? 0).toDouble();
    instance.ipi = (json['IPI'] ?? 0).toDouble();
    instance.issqn = (json['ISSQN'] ?? 0).toDouble();
    instance.pis = (json['PIS'] ?? 0).toDouble();

    // Produtos
    if (json['products'] is List) {
      instance.productsTax = (json['products'] as List).map((item) {
        final Map<String, dynamic> p = Map<String, dynamic>.from(item);
        return ProductTax.fromJson(p);
      }).toList();
    }
    return instance;
  }

  double getTotalTax() {
    return cofins + icms + ii + ipi + issqn + pis;
  }

  List<Map<String, double>> getTaxOrder() {
    List<Map<String, double>> tax = [
      {'cofins': cofins},
      {'icms': icms},
      {'ii': ii},
      {'ipi': ipi},
      {'issqn': issqn},
      {'pis': pis},
    ];

    // Ordena em ordem decrescente pelo valor
    tax.sort((a, b) {
      final double va = a.values.first;
      final double vb = b.values.first;
      return vb.compareTo(va); // use va.compareTo(vb) para crescente
    });

    return tax;
  }
}

class ProductTax {
  late String id;
  late double cofins = 0;
  late double icms = 0;
  late double ii = 0;
  late double ipi = 0;
  late double issqn = 0;
  late double pis = 0;

  ProductTax.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cofins = json['COFINS'];
    icms = json['ICMS'];
    ii = json['II'];
    ipi = json['IPI'];
    issqn = json['ISSQN'];
    pis = json['PIS'];
  }

  double getTotalTax() {
    return cofins + icms + ii + ipi + issqn + pis;
  }
}
