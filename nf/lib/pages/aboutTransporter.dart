import 'package:flutter/material.dart';
import 'package:nf/NF/NF.dart';
import 'package:nf/NF/transportersData.dart';
import 'package:nf/pages/aboutnf.dart';
import 'package:nf/settings.dart';

class Abouttransporter extends StatefulWidget {
  final Transporter transporter;
  const Abouttransporter({required this.transporter});

  @override
  State<Abouttransporter> createState() => _AbouttransporterState();
}

class _AbouttransporterState extends State<Abouttransporter> {
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
        title: Text('${widget.transporter.name}'),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Settings.TextColor),
      ),
      backgroundColor: Settings.HomeBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InfoBox("Nome", widget.transporter.name, 15),
            InfoBox("CNPJ", widget.transporter.CNPJ, 15),
            SizedBox(height: 10),
            Text(
              "Notas fiscais",
              style: TextStyle(color: Settings.TextColor, fontSize: 18),
            ),
            NFsListViewTransporters(nfs: widget.transporter.nfs),
          ],
        ),
      ),
    );
  }
}

class NFsListViewTransporters extends StatelessWidget {
  final List<String> nfs;
  NFsListViewTransporters({required this.nfs});

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
