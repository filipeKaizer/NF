import 'package:flutter/material.dart';
import 'package:nf/NF/NF.dart';
import 'package:nf/NF/taxData.dart';
import 'package:nf/pages/aboutnf.dart';
import 'package:nf/settings.dart';
import 'package:nf/src/memory.dart';
import 'package:provider/provider.dart';

class Taxpage extends StatefulWidget {
  const Taxpage({super.key});

  @override
  State<Taxpage> createState() => _TaxpageState();
}

class _TaxpageState extends State<Taxpage> {
  @override
  Widget build(BuildContext context) {
    Taxdata taxdata = context.watch<Memory>().taxdata;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 8, left: 8, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalTax(taxdata.getTotalTax()),
            SizedBox(height: 10),
            TaxListView(taxdata: taxdata),
            SizedBox(height: 10),
            Text(
              'Imposto por NF',
              style: TextStyle(color: Settings.TextColor, fontSize: 18),
            ),
            Expanded(child: ProductsListView(taxdata: taxdata)),
          ],
        ),
      ),
    );
  }
}

class TotalTax extends StatelessWidget {
  final double total;
  const TotalTax(this.total);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total de imposto',
          style: TextStyle(color: Settings.TextColor, fontSize: 18),
        ),
        Container(
          decoration: BoxDecoration(
            color: Settings.containerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            'R\$${this.total.toStringAsFixed(2)}',
            style: TextStyle(color: Settings.TextColor, fontSize: 40),
          ),
        ),
      ],
    );
  }
}

class TaxListView extends StatelessWidget {
  final Taxdata taxdata;
  TaxListView({required this.taxdata});

  @override
  Widget build(BuildContext context) {
    String convertValue(double value) {
      if (value >= 10000) {
        return "${(value / 100000).toStringAsFixed(0)}k";
      }
      return value.toStringAsFixed(2);
    }

    Widget getTaxBox(String tax, double value) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tax.toUpperCase(),
              style: TextStyle(color: Settings.TextColor, fontSize: 15),
            ),
            Text(
              "R\$${convertValue(value)}",
              style: TextStyle(color: Settings.TextColor, fontSize: 15),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lista de impostos',
          style: TextStyle(color: Settings.TextColor, fontSize: 18),
        ),
        Container(
          decoration: BoxDecoration(
            color: Settings.containerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Column(
            children: taxdata
                .getTaxOrder()
                .expand(
                  (e) => e.entries.map(
                    (entry) => getTaxBox(entry.key, entry.value),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class ProductsListView extends StatefulWidget {
  final Taxdata taxdata;
  const ProductsListView({Key? key, required this.taxdata}) : super(key: key);

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  @override
  Widget build(BuildContext context) {
    String convertValue(double value) {
      if (value >= 100000) {
        return "${(value / 100000).toStringAsFixed(0)}k";
      }
      return value.toStringAsFixed(2);
    }

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ListView.builder(
        itemCount: widget.taxdata.productsTax.length,
        itemBuilder: (context, index) {
          final product = widget.taxdata.productsTax[index];

          return Column(
            children: [
              Container(
                color: Settings.containerColor,
                child: InkWell(
                  onTap: () async {
                    final nf = await Nf.byNumber(number: product.id);

                    if (!mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Aboutnf(nf: nf)),
                    );
                  },
                  child: ListTile(
                    trailing: Text(
                      'R\$ ${convertValue(product.getTotalTax())}',
                      style: TextStyle(color: Settings.TextColor, fontSize: 15),
                    ),
                    leading: Text(
                      '${product.id.substring(0, 5)}...${product.id.substring(product.id.length - 5, product.id.length - 1)}',
                      style: TextStyle(color: Settings.TextColor, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const Divider(height: 0, color: Colors.white70),
            ],
          );
        },
      ),
    );
  }
}
