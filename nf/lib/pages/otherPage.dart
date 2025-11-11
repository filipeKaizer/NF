import 'package:flutter/material.dart';
import 'package:nf/NF/utils/suppliers.dart';
import 'package:nf/NF/utils/transporters.dart';
import 'package:nf/settings.dart';

class Otherpage extends StatefulWidget {
  const Otherpage({super.key});

  @override
  State<Otherpage> createState() => _OtherpageState();
}

class _OtherpageState extends State<Otherpage> {
  bool savedNF = true;
  List<Widget> content = [Suppliers(), Transporters()];

  Widget getContent() {
    if (savedNF) {
      return content[0];
    }
    return content[1];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 5),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ToggleButtons(
                color: Colors.black.withOpacity(0.60),
                selectedColor: Colors.white70,
                selectedBorderColor: Colors.white70,
                splashColor: Settings.selectedColor.withOpacity(0.12),
                hoverColor: Settings.selectedColor,
                borderRadius: BorderRadius.circular(4.0),
                isSelected: [savedNF, !savedNF],
                onPressed: (index) {
                  setState(() {
                    if (index == 0) {
                      savedNF = true;
                    } else {
                      savedNF = false;
                    }
                  });
                },
                constraints: BoxConstraints.expand(
                  width: (MediaQuery.of(context).size.width - 16) / 2 - 2,

                  // 16 is the horizontal padding from parent
                ),
                children: [
                  Text(
                    'Fornecedores',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Settings.TextColor, fontSize: 18),
                  ),
                  Text(
                    'Transportadores',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Settings.TextColor, fontSize: 18),
                  ),
                ],
              ),
            ),

            // Conteúdo
            getContent(),
          ],
        ),
      ),
    );
  }
}
