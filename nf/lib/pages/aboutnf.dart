import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:nf/NF/NF.dart';
import 'package:nf/settings.dart';

class Aboutnf extends StatelessWidget {
  final Nf nf;
  const Aboutnf({required this.nf});

  @override
  Widget build(BuildContext context) {
    Widget title(String text) {
      return Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white70),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Settings.appBarBackgoundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('NF 1', style: TextStyle(color: Settings.TextColor)),
        centerTitle: true,
      ),
      backgroundColor: Settings.HomeBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 8, left: 8),
        child: ListView(
          children: [
            // Informações gerais
            title("Geral"),
            GeneralInfo(nf: nf),
            SizedBox(height: 15),
            Divider(),
            title('Emitente'),
            Emit(nf: nf),
            Divider(),
            title('Remetente'),
            Remet(nf: nf),
            Divider(),
            title('Produtos'),
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
                          MdiIcons.bank,
                          size: 12,
                          color: Settings.TextColor,
                        ),
                        SizedBox(width: 2),
                        Text(
                          'R\$${nf.products[index].tax.toStringAsFixed(2)}',
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
        InfoBox(
          'Número/Serie',
          'N° ${nf.general.number.toString()} / Serie ${nf.general.series}',
          20,
        ),
        InfoBox('Data de emissão', nf.general.getEmissionDate(), 20),
        InfoBox('Chave de acesso', nf.general.accessNumber, 20),
        InfoBox('Natureza', nf.general.operationType, 13),
      ],
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
