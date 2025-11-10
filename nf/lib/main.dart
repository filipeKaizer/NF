import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:nf/NF/invoiceData.dart';
import 'package:nf/pages/invoicePage.dart';
import 'package:nf/pages/otherPage.dart';
import 'package:nf/pages/taxPage.dart';
import 'package:nf/settings.dart';
import 'package:nf/src/memory.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Memory.new())],
      child: const MyApp(),
    ),
  );
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
    Memory memory = context.watch<Memory>();

    Future<void> selectFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xml'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          memory.addXMLFile(File(result.files.single.path!));
        });
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Settings.HomeBackgroundColor,
        // Cabeçalho
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Settings.appBarBackgoundColor,
          title: Text('NF', style: TextStyle(color: Settings.TextColor)),
          actions: [
            IconButton(
              onPressed: selectFile,
              icon: Icon(Icons.add, color: Settings.TextColor),
            ),
          ],
        ),

        // Home
        body:
            ((context.watch<Memory>().invoicedata).NFS.isNotEmpty ||
                context.watch<Memory>().files.isNotEmpty)
            ? Container(child: pages[navigationIndex])
            : Empty(),

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

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(MdiIcons.noteRemoveOutline, size: 100, color: Colors.white),
            Center(
              child: Text(
                'Nenhum arquivo ainda. Crregue um com o botão +.',
                style: TextStyle(color: Settings.TextColor, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
