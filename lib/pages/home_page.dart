import 'package:flutter/material.dart';
import 'accueil_page.dart';
import 'redacteur_page.dart';
import '../widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final List<Widget> _pages = const [AccueilPage(), RedacteurPage()];

  final List<String> _titres = const ["Accueil", "Gestion des Rédacteurs"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text(_titres[_index]),
    ),
    drawer: AppDrawer(
      onSelect: (i) {
        setState(() {
          _index = i;
        });
      },
    ),
    body: _pages[_index],
  );
  }
}
