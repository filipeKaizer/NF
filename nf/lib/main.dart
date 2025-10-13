import 'package:flutter/material.dart';
import 'package:nf/pages/invoicePage.dart';
import 'package:nf/pages/otherPage.dart';
import 'package:nf/pages/taxPage.dart';
import 'package:nf/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NF();
  }
}

class NF extends StatefulWidget {
  const NF({super.key});

  @override
  State<NF> createState() => _NFState();
}

class _NFState extends State<NF> {
  // AppBar
  int navigationIndex = 0;
  List<BottomNavigationBarItem> navigationItens = [
    BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Notas'),
    BottomNavigationBarItem(
      icon: Icon(Icons.monetization_on_outlined),
      label: 'Imposto',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.delivery_dining_outlined),
      label: 'Forn./Tran.',
    ),
  ];

  // Pages
  List<Widget> pages = [Invoicepage(), Taxpage(), Otherpage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Settings.HomeBackgroundColor,
        // Cabeçalho
        appBar: AppBar(
          backgroundColor: Settings.appBarBackgoundColor,
          title: Center(
            child: Text('NF', style: TextStyle(color: Settings.TextColor)),
          ),
        ),

        // Home
        body: Container(child: pages[navigationIndex]),

        // Navegação
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Settings.appBarBackgoundColor,
          unselectedItemColor: Settings.unselectedColor,
          selectedItemColor: Settings.selectedColor,
          selectedFontSize: 13,
          selectedIconTheme: IconThemeData(
            color: Settings.selectedColor,
            size: 28,
          ),
          unselectedIconTheme: IconThemeData(
            color: Settings.unselectedColor,
            size: 20,
          ),
          onTap: (value) => {
            setState(() {
              navigationIndex = value;
            }),
          },
          currentIndex: navigationIndex,
          items: navigationItens,
        ),
      ),
    );
  }
}
