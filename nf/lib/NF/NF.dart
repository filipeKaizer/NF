import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nf/settings.dart';

class Nf {
  late double total;
  late double tax;
  late int qtdProd;

  late General general;
  late Emit emit;
  late Remet remet;
  late List<Product> products;

  Nf({
    required this.total,
    required this.tax,
    required this.qtdProd,
    required this.general,
    required this.emit,
    required this.remet,
    required this.products,
  });

  Nf.simply({
    required this.total,
    required this.tax,
    required this.qtdProd,
    required String number,
  }) {
    this.emit = Emit.none();
    this.general = General.none(number);
    this.remet = Remet.none();
    this.products = [];
  }

  Nf.byNumber({required String number}) {
    this.emit = Emit.none();
    this.general = General.none(number);
    this.remet = Remet.none();
    this.products = [];
    this.total = 0;
    this.tax = 0;
    this.qtdProd = 0;
  }

  static Future<Nf> fromServer(Nf nf) async {
    final Nf instance = Nf.simply(
      number: nf.general.number,
      qtdProd: nf.qtdProd,
      tax: nf.tax,
      total: nf.total,
    );

    // Obtem os dados do servidor
    Map<String, dynamic> json = {};

    String url = Settings.getUrlNf(instance.general.number);

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

    // ADIÇAO DOS DADOS
    final totalPrice = (json['totalPrice'] ?? '0').toString().replaceAll(
      ',',
      '.',
    );
    instance.total = double.tryParse(totalPrice) ?? 0.0;

    final taxPrice = (json['totalTax']["Total"] ?? '0').toString().replaceAll(
      ',',
      '.',
    );
    instance.tax = double.tryParse(taxPrice) ?? 0.0;

    // Dados gerais
    instance.general = General(
      accessNumber: (json['general']['accessNumber'] ?? "").toString(),
      emission: DateTime.parse((json['general']['emission'] ?? "").toString()),
      number: (json['general']['number'] ?? "").toString(),
      operationType: (json['general']['opType'] ?? "").toString(),
    );
    // Emit
    instance.emit = Emit(
      CNPJ: (json['emit']['CNPJ'] ?? "").toString(),
      IE: (json['emit']['IE'] ?? "").toString(),
      name: (json['emit']['name'] ?? "").toString(),
      address: Address.fromJson(json['emit']['address']),
    );

    // Remet
    instance.remet = Remet(
      CPF: (json['remet']['CPF'] ?? "").toString(),
      name: (json['remet']['name'] ?? "").toString(),
      address: Address.fromJson(json['remet']['address']),
    );

    // Produtos
    instance.products = [];

    final productsJson = json['products'];
    if (productsJson is List) {
      for (final item in productsJson) {
        final prod = (item['prod'] ?? {}) as Map<String, dynamic>;

        int qtd = 0;
        double valUnit = 0.0;
        try {
          final qStr = (prod['qCom'] ?? prod['qTrib'] ?? '0')
              .toString()
              .replaceAll(',', '.');
          final vStr = (prod['vUnCom'] ?? prod['vUnTrib'] ?? '0')
              .toString()
              .replaceAll(',', '.');
          qtd = (double.tryParse(qStr) ?? 0).toInt();
          valUnit = double.tryParse(vStr) ?? 0.0;
        } catch (_) {}

        instance.products.add(
          Product(
            name: (prod['xProd'] ?? '').toString(),
            EAN: (prod['cEAN'] ?? '').toString(),
            cod: (prod['cProd'] ?? '').toString(),
            qtd: qtd,
            valUnit: valUnit,
            total:
                double.tryParse(
                  (prod['vProd'] ?? '0').toString().replaceAll(',', '.'),
                ) ??
                0.0,
          ),
        );
      }
    }
    return instance;
  }
}

class Product {
  late int qtd = 0;
  late double total = 0;
  late double valUnit = 0;

  late String name;
  late String cod;
  late String EAN;

  Product({
    required this.qtd,
    required this.valUnit,
    required this.name,
    required this.cod,
    required this.EAN,
    required this.total,
  });
}

class General {
  // Dados gerais
  late String number;
  late DateTime emission;
  late String accessNumber;
  late String operationType;

  General({
    required this.accessNumber,
    required this.emission,
    required this.number,
    required this.operationType,
  });

  General.none(String number) {
    this.number = number;
    this.emission = DateTime.now();
    this.accessNumber = "";
    this.operationType = "";
  }

  String zeroBefor(int number) {
    return (number < 10) ? "0${number}" : "${number}";
  }

  String getEmissionDate() {
    return "${zeroBefor(emission.hour)}:${zeroBefor(emission.minute)} ${zeroBefor(emission.day)}/${zeroBefor(emission.month)}/${zeroBefor(emission.year)}";
  }
}

class Emit {
  late String name;
  late String CNPJ;
  late String IE;
  late Address address;

  Emit({
    required this.name,
    required this.CNPJ,
    required this.IE,
    required this.address,
  });

  Emit.none() {
    this.name = "";
    this.CNPJ = "";
    this.IE = "";
    this.address = Address.none();
  }
}

class Remet {
  late String name;
  late String CPF;
  late Address address;

  Remet({required this.name, required this.CPF, required this.address});

  Remet.none() {
    this.name = "";
    this.CPF = "";
    this.address = Address.none();
  }
}

class Address {
  late int number;
  late String Lgr;
  late String bairro;
  late String Mun;
  late String UF;
  late String CEP;
  late String country;

  Address({
    required this.CEP,
    required this.Lgr,
    required this.Mun,
    required this.UF,
    required this.bairro,
    required this.country,
    required this.number,
  });

  Address.none() {
    this.number = 64;
    Lgr = "ESTRADA DA PEDREIRA PAVILHAO 5";
    bairro = "Pedreira";
    Mun = "Nova Santa Rita";
    UF = "RS";
    CEP = "92480-000";
    country = "Brasil";
  }

  Address.fromJson(Map<String, dynamic> json) {
    this.CEP = (json['CEP'] ?? "").toString();
    this.Lgr = (json['lgr'] ?? "").toString();
    this.Mun = (json['mun'] ?? "").toString();
    this.UF = (json['UF'] ?? "").toString();
    this.bairro = (json['bairro'] ?? "").toString();
    this.country = (json['country'] ?? "").toString();
    this.number = int.tryParse(json['number']?.toString() ?? '0') ?? 0;
  }
}
