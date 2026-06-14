import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../widgets/app_drawer.dart';
import 'accueil_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final RedacteurController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RedacteurController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Magazine Infos')),
      drawer: AppDrawer(controller: _controller),
      body: const AccueilPage(),
    );
  }
}
