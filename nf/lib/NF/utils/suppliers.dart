import 'package:flutter/material.dart';
import 'package:nf/NF/supplierData.dart';
import 'package:nf/pages/aboutSupplier.dart';
import 'package:nf/settings.dart';
import 'package:nf/src/memory.dart';
import 'package:provider/provider.dart';

class SuppliersPage extends StatefulWidget {
  late Supplierdata supplierdata;
  SuppliersPage({required this.supplierdata});

  @override
  State<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends State<SuppliersPage> {
  @override
  Widget build(BuildContext context) {
    String getMaxText(String text) {
      int maxLength = 20;
      if (text.length > maxLength) {
        return '${text.substring(0, maxLength)}...';
      }
      return text;
    }

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ListView.builder(
        itemCount: widget.supplierdata.suppliers.length,
        itemBuilder: (context, index) {
          final product = widget.supplierdata.suppliers[index];

          return Column(
            children: [
              Container(
                color: Settings.containerColor,
                child: InkWell(
                  onTap: () async {
                    if (!mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Aboutsupplier(supplier: product),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Text(
                      '${getMaxText(product.name)}',
                      style: TextStyle(color: Settings.TextColor, fontSize: 15),
                    ),
                    trailing: Text(
                      '${product.nfs.length} NFs',
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
