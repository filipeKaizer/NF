import 'package:flutter/material.dart';
import 'package:nf/NF/transportersData.dart';
import 'package:nf/pages/aboutTransporter.dart';
import 'package:nf/settings.dart';

class TransportersPage extends StatefulWidget {
  final TransportersData transportersData;
  TransportersPage({required this.transportersData});

  @override
  State<TransportersPage> createState() => _TransportersPageState();
}

class _TransportersPageState extends State<TransportersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ListView.builder(
        itemCount: widget.transportersData.transporters.length,
        itemBuilder: (context, index) {
          final product = widget.transportersData.transporters[index];

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
                        builder: (context) =>
                            Abouttransporter(transporter: product),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Text(
                      '${product.CNPJ}',
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
