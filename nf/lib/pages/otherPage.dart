import 'package:flutter/material.dart';
import 'package:nf/NF/supplierData.dart';
import 'package:nf/NF/transportersData.dart';
import 'package:nf/NF/utils/suppliers.dart';
import 'package:nf/NF/utils/transporters.dart';
import 'package:nf/settings.dart';
import 'package:nf/src/memory.dart';
import 'package:provider/provider.dart';

class Otherpage extends StatefulWidget {
  const Otherpage({super.key});

  @override
  State<Otherpage> createState() => _OtherpageState();
}

class _OtherpageState extends State<Otherpage> {
  bool savedNF = true;

  @override
  Widget build(BuildContext context) {
    Supplierdata supplierdata = context.watch<Memory>().supplierdata;
    TransportersData transportersData = context
        .watch<Memory>()
        .transportersData;

    Widget getContent() {
      if (savedNF) {
        return SuppliersPage(supplierdata: supplierdata);
      } else {
        return TransportersPage(transportersData: transportersData);
      }
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 5),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ToggleButtons(
                color: Colors.white, // texto não selecionado em branco
                selectedColor: Colors.white70,
                selectedBorderColor: Colors.white70,
                disabledColor: Colors.white70,
                splashColor: Settings.selectedColor.withOpacity(0.12),
                hoverColor: Settings.selectedColor,
                borderRadius: BorderRadius.circular(4.0),
                isSelected: [savedNF, !savedNF],
                onPressed: (index) {
                  setState(() {
                    savedNF = index == 0;
                  });
                },
                constraints: BoxConstraints.expand(
                  width: (MediaQuery.of(context).size.width - 16) / 2 - 2,
                ),
                children: const [
                  Text(
                    'Fornecedores',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Transportadores',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            // Conteúdo dinâmico (recriado corretamente)
            Expanded(child: getContent()),
          ],
        ),
      ),
    );
  }
}
