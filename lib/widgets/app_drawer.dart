import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final Function(int) onSelect;

  const AppDrawer({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.pink.shade50,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pink.shade600,
            ),
            child: const Center(
              child: Icon(
                Icons.menu_book,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Accueil"),
            onTap: () {
              Navigator.pop(context);
              onSelect(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Gestion des Rédacteurs"),
            onTap: () {
              Navigator.pop(context);
              onSelect(1);
            },
          ),
        ],
      ),
    );
  }
}
