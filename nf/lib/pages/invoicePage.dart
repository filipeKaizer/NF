import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:nf/NF/NF.dart';
import 'package:nf/NF/mock.dart';
import 'package:nf/pages/aboutNF.dart';
import 'package:nf/settings.dart';

class Invoicepage extends StatefulWidget {
  const Invoicepage({super.key});

  @override
  State<Invoicepage> createState() => _InvoicepageState();
}

class _InvoicepageState extends State<Invoicepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 5),
          child: Column(
            children: [
              // Numero de notas
              TotalNF(10),
              SizedBox(height: 10),
              // Número de produtos
              TotalProducts(10),
              SizedBox(height: 20),
              // Valores
              Row(
                children: [
                  CostValue("Total", 1000, MdiIcons.currencyUsd),
                  SizedBox(width: 10),
                  CostValue("Impostos", 100, MdiIcons.bank),
                ],
              ),
              SizedBox(height: 30),
              // Lista de NF
              NFList(),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalNF extends StatelessWidget {
  final int total;
  const TotalNF(this.total);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total de notas',
          style: TextStyle(color: Settings.TextColor, fontSize: 18),
        ),
        Container(
          decoration: BoxDecoration(
            color: Settings.containerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            '${this.total} NFs',
            style: TextStyle(color: Settings.TextColor, fontSize: 40),
          ),
        ),
      ],
    );
  }
}

class TotalProducts extends StatelessWidget {
  final int total;
  const TotalProducts(this.total);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total de produtos',
          style: TextStyle(color: Settings.TextColor, fontSize: 18),
        ),
        Container(
          decoration: BoxDecoration(
            color: Settings.containerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            '${this.total} Produtos',
            style: TextStyle(color: Settings.TextColor, fontSize: 40),
          ),
        ),
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

class NFList extends StatelessWidget {
  final List<Nf> nfs = data;

  NFList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notas',
          style: TextStyle(color: Settings.TextColor, fontSize: 18),
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          height: (MediaQuery.of(context).size.height / 3) - 30,
          child: ListView.builder(
            itemCount: nfs.length,
            itemBuilder: (context, index) {
              final rf = nfs[index];
              return Column(
                children: [
                  Container(
                    color: Settings.containerColor,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Aboutnf(nf: rf),
                          ),
                        );
                      },
                      child: ListTile(
                        trailing: Text(
                          'R\$${rf.total.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Settings.TextColor,
                            fontSize: 15,
                          ),
                        ),
                        leading: Text(
                          'Nf ${index}',
                          style: TextStyle(
                            color: Settings.TextColor,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 6,
                                  right: 6,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      MdiIcons.cart,
                                      color: Settings.TextColor,
                                      size: 12,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      '${rf.qtdProd}',
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
                                padding: const EdgeInsets.only(
                                  left: 6,
                                  right: 6,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      MdiIcons.bank,
                                      size: 12,
                                      color: Settings.TextColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      'R\$${rf.tax.toStringAsFixed(2)}',
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
                      ),
                    ),
                  ),
                  Divider(height: 0, color: Colors.white70),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
