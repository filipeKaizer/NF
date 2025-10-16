class Nf {
  final double total;
  final double tax;
  final int qtdProd;

  final General general;
  final Emit emit;
  final Remet remet;
  final List<Product> products;

  Nf({
    required this.total,
    required this.tax,
    required this.qtdProd,
    required this.general,
    required this.emit,
    required this.remet,
    required this.products,
  });
}

class Product {
  late int qtd = 0;
  late double total = 0;
  late double totalTax = 0;
  late List<Tax> tax;
  late double valUnit = 0;

  late String name;
  late String cod;
  late String EAN;

  Product({
    required int qtd,
    required double valUnit,
    required String name,
    required String cod,
    required String EAN,
    required List<Tax> tax,
  }) {
    this.qtd = qtd;
    this.valUnit = valUnit;
    this.tax = tax;
    this.cod = cod;
    this.EAN = EAN;
    this.name = name;

    // Calcula as taxas e o valor total
    this.total = qtd * valUnit;

    for (Tax t in tax) {
      this.totalTax += t.percent * total;
    }
    this.total += this.totalTax;
  }
}

class Tax {
  late String type;
  late double percent;

  Tax({required this.type, required this.percent});
}

class General {
  // Dados gerais
  final int number;
  final int series;
  final DateTime emission;
  final String accessNumber;
  final String operationType;

  General(
    this.accessNumber,
    this.emission,
    this.number,
    this.operationType,
    this.series,
  );

  String zeroBefor(int number) {
    return (number < 10) ? "0${number}" : "${number}";
  }

  String getEmissionDate() {
    return "${zeroBefor(emission.hour)}:${zeroBefor(emission.minute)} ${zeroBefor(emission.day)}/${zeroBefor(emission.month)}/${zeroBefor(emission.year)}";
  }
}

class Emit {
  final String name;
  final String CNPJ;
  final String IE;
  final Address address;
  final String CNAE;

  Emit(this.name, this.CNAE, this.CNPJ, this.IE, this.address);
}

class Remet {
  final String name;
  final String CPF;
  final String IE;
  final Address address;

  Remet(this.name, this.CPF, this.IE, this.address);
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
}
