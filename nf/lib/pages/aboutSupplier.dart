import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nf/NF/NF.dart';
import 'package:nf/NF/supplierData.dart';
import 'package:nf/pages/aboutNF.dart';
import 'package:nf/settings.dart';

class Aboutsupplier extends StatefulWidget {
  final Supplier supplier;
  Aboutsupplier({required this.supplier});

  @override
  State<Aboutsupplier> createState() => _AboutsupplierState();
}

class _AboutsupplierState extends State<Aboutsupplier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Settings.appBarBackgoundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('${widget.supplier.name}'),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Settings.TextColor),
      ),
      backgroundColor: Settings.HomeBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InfoBox("Nome", widget.supplier.name, 15),
            InfoBox("CNPJ", widget.supplier.cnpj, 15),
            InfoBox(
              "Site",
              (widget.supplier.site.isNotEmpty)
                  ? widget.supplier.site
                  : "Não informado",
              15,
            ),
            SizedBox(height: 10),
            Text(
              "Notas fiscais",
              style: TextStyle(color: Settings.TextColor, fontSize: 18),
            ),
            NFsListViewSuppliers(nfs: widget.supplier.nfs),
          ],
        ),
      ),
    );
  }
}

class NFsListViewSuppliers extends StatelessWidget {
  final List<String> nfs;
  NFsListViewSuppliers({required this.nfs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemCount: nfs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "${nfs[index].substring(0, 5)}...${nfs[index].substring(nfs[index].length - 4, nfs[index].length)}",
              style: TextStyle(color: Settings.TextColor, fontSize: 15),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(
                index.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.info_outlined),
              color: Settings.selectedColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Aboutnf(nf: Nf.byNumber(number: nfs[index])),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
