class Nf {
  final double total;
  final double tax;
  final int qtdProd;

  final General general;

  final Emit emit;

  Nf({
    required this.total,
    required this.tax,
    required this.qtdProd,
    required this.general,
    required this.emit,
  });
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
    return "${zeroBefor(emission.hour)}:${zeroBefor(emission.minute)} ${zeroBefor(emission.day)}-${zeroBefor(emission.month)}-${zeroBefor(emission.year)}";
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
    this.number = 0;
    Lgr = "";
    bairro = "";
    Mun = "";
    UF = "";
    CEP = "";
    country = "";
  }
}
