import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:nf/NF/NF.dart';
import 'package:nf/settings.dart';

class Aboutnf extends StatefulWidget {
  final Nf nf;
  const Aboutnf({required this.nf, Key? key}) : super(key: key);

  @override
  State<Aboutnf> createState() => _AboutnfState();
}

class _AboutnfState extends State<Aboutnf> {
  late Nf nf;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    nf = widget.nf;
    _loadNF();
  }

  Future<void> _loadNF() async {
    try {
      nf = await Nf.fromServer(nf);
    } catch (e) {
      print(e);
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Settings.appBarBackgoundColor,
          title: Text(
            'NF ${nf.general.number}',
            style: TextStyle(color: Settings.TextColor),
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Aqui a interface só é exibida após carregar
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Settings.appBarBackgoundColor,
        title: Text(
          'NF ${nf.general.number}',
          style: TextStyle(color: Settings.TextColor),
        ),
        centerTitle: true,
      ),
      backgroundColor: Settings.HomeBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Row(
              children: [
                CostValue("Total", nf.total, MdiIcons.currencyUsd),
                SizedBox(width: 10),
                CostValue("Impostos", nf.tax, MdiIcons.bank),
              ],
            ),
            Divider(),
            Center(
              child: Text(
                "Geral",
                style: TextStyle(fontSize: 24, color: Colors.white70),
              ),
            ),
            GeneralInfo(nf: nf),
            Divider(),
            Center(
              child: Text(
                "Emitente",
                style: TextStyle(fontSize: 24, color: Colors.white70),
              ),
            ),
            Emit(nf: nf),
            Divider(),
            Center(
              child: Text(
                "Remetente",
                style: TextStyle(fontSize: 24, color: Colors.white70),
              ),
            ),
            Remet(nf: nf),
            Divider(),
            Center(
              child: Text(
                "Produtos",
                style: TextStyle(fontSize: 24, color: Colors.white70),
              ),
            ),
            Products(nf: nf),
          ],
        ),
      ),
    );
  }
}

class Products extends StatelessWidget {
  final Nf nf;
  const Products({Key? key, required this.nf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: nf.products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              nf.products[index].name,
              style: TextStyle(color: Settings.TextColor, fontSize: 15),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(
                index.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            trailing: Text(
              'R\$${nf.products[index].total.toStringAsFixed(2)}',
              style: TextStyle(color: Settings.TextColor, fontSize: 12),
            ),
            subtitle: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: Row(
                      children: [
                        Icon(
                          MdiIcons.cart,
                          color: Settings.TextColor,
                          size: 12,
                        ),
                        SizedBox(width: 2),
                        Text(
                          '${nf.products[index].qtd}',
                          style: TextStyle(
                            color: Settings.TextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: Row(
                      children: [
                        Icon(
                          MdiIcons.identifier,
                          color: Settings.TextColor,
                          size: 12,
                        ),
                        SizedBox(width: 2),
                        Text(
                          '${nf.products[index].cod}',
                          style: TextStyle(
                            color: Settings.TextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GeneralInfo extends StatelessWidget {
  final Nf nf;
  const GeneralInfo({required this.nf});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoBox('Número', '${nf.general.number.toString()}', 20),
        InfoBox('Data de emissão', nf.general.getEmissionDate(), 20),
        InfoBox('Chave de acesso', nf.general.accessNumber, 20),
        InfoBox('Natureza', nf.general.operationType, 13),
      ],
    );
  }
}

class CostValue extends StatelessWidget {
  final double value;
  final IconData icon;
  final String name;

  const CostValue(this.name, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          (MediaQuery.of(context).size.width / 2) -
          13, // Metade - padding - (sizedbox / 2)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Settings.containerColor,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          // Legenda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(color: Settings.TextColor, fontSize: 15),
                ),
                Icon(icon, size: 20, color: Settings.TextColor),
              ],
            ),
          ),
          // Corpo
          Text(
            "R\$${value.toStringAsFixed(2)}",
            style: TextStyle(color: Settings.TextColor, fontSize: 25),
          ),
        ],
      ),
    );
  }
}

class Emit extends StatelessWidget {
  final Nf nf;
  const Emit({required this.nf});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoBox("Nome", nf.emit.name, 20),
        InfoBox('CNPJ', nf.emit.CNPJ, 20),
        AddressBox(nf.emit.address),
      ],
    );
  }
}

class Remet extends StatelessWidget {
  final Nf nf;
  const Remet({required this.nf});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoBox('Nome', nf.remet.name, 20),
        InfoBox('CPF', nf.remet.CPF, 20),
        AddressBox(nf.remet.address),
      ],
    );
  }
}

Widget AddressBox(Address address) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InfoBox(
        'Rua',
        '${address.Lgr}, ${address.number} - ${address.bairro}',
        15,
      ),
      InfoBox(
        'Cidade',
        '${address.Mun} (${address.UF}/${address.country}) - ${address.CEP}',
        15,
      ),
    ],
  );
}

Widget InfoBox(String title, String value, double size) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      decoration: BoxDecoration(
        color: Settings.containerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  title,
                  style: TextStyle(color: Settings.TextColor, fontSize: 14),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
            child: Center(
              child: Text(
                value,
                style: TextStyle(color: Settings.TextColor, fontSize: size),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
