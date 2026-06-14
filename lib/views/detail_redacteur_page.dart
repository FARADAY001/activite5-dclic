import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../modele/redacteur.dart';
import 'modifier_redacteur_page.dart';

class DetailRedacteurPage extends StatelessWidget {
  final Redacteur redacteur;
  final RedacteurController controller;

  const DetailRedacteurPage({
    super.key,
    required this.redacteur,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du rédacteur'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ModifierRedacteurPage(
                  redacteur: redacteur,
                  controller: controller,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.pink.shade600,
              child: Text(
                redacteur.nom.isNotEmpty
                    ? redacteur.nom[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            _infoCard(Icons.person, 'Nom', redacteur.nom),
            const SizedBox(height: 12),
            _infoCard(Icons.work, 'Spécialité', redacteur.specialite),
            const SizedBox(height: 12),
            _infoCard(Icons.fingerprint, 'Identifiant Firestore', redacteur.id),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String label, String valeur) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.pink.shade600),
        title: Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(valeur,
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
