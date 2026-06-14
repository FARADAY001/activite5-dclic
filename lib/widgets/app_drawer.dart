import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../views/ajout_redacteur_page.dart';
import '../views/redacteur_info_page.dart';

class AppDrawer extends StatelessWidget {
  final RedacteurController controller;

  const AppDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.pink.shade50,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.pink.shade600),
            child: const Center(
              child: Icon(Icons.menu_book, size: 60, color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Accueil'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Ajouter un Rédacteur'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AjoutRedacteurPage(controller: controller),
                ),
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: controller.redacteursStream,
            builder: (context, snapshot) {
              final count = snapshot.data?.docs.length ?? 0;
              return ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Informations des Rédacteurs'),
                trailing: count > 0
                    ? CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.pink.shade600,
                        child: Text(
                          '$count',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          RedacteurInfoPage(controller: controller),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
