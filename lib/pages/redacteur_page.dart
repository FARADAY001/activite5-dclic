import 'package:flutter/material.dart';
import '../database/database_manager.dart';
import '../modele/redacteur.dart';

class RedacteurPage extends StatefulWidget {
  const RedacteurPage({super.key});

  @override
  State<RedacteurPage> createState() => _RedacteurPageState();
}

class _RedacteurPageState extends State<RedacteurPage> {
  final _nomCtrl = TextEditingController();
  final _prenomCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  final DatabaseManager db = DatabaseManager();
  List<Redacteur> redacteurs = [];

  @override
  void initState() {
    super.initState();
    _charger();
  }

  // ================== UTILITAIRES ==================

  bool emailValide(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  void _message(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.pink.shade600),
    );
  }

  // ================== CRUD ==================

  void _charger() async {
    redacteurs = await db.getAllRedacteurs();
    setState(() {});
  }

  void _ajouter() async {
    if (_nomCtrl.text.isEmpty ||
        _prenomCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty) {
      _message("Tous les champs sont obligatoires");
      return;
    }

    if (!emailValide(_emailCtrl.text)) {
      _message("Adresse email invalide");
      return;
    }

    await db.insertRedacteur(
      Redacteur(
        nom: _nomCtrl.text,
        prenom: _prenomCtrl.text,
        email: _emailCtrl.text,
      ),
    );

    _nomCtrl.clear();
    _prenomCtrl.clear();
    _emailCtrl.clear();
    _charger();
  }

  void _supprimer(int id) async {
    await db.deleteRedacteur(id);
    _charger();
  }

  void _modifier(Redacteur r) {
    final nom = TextEditingController(text: r.nom);
    final prenom = TextEditingController(text: r.prenom);
    final email = TextEditingController(text: r.email);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Modifier le rédacteur"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nom,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: prenom,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (!emailValide(email.text)) {
                _message("Adresse email invalide");
                return;
              }

              await db.updateRedacteur(
                Redacteur(
                  id: r.id,
                  nom: nom.text,
                  prenom: prenom.text,
                  email: email.text,
                ),
              );
              Navigator.pop(context);
              _charger();
            },
            child: const Text("Enregistrer"),
          ),
        ],
      ),
    );
  }

  // ================== UI ==================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,

      //appBar: AppBar(title: const Text("Gestion des Rédacteurs")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _nomCtrl,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: _prenomCtrl,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Ajouter un rédacteur"),
              onPressed: _ajouter,
            ),

            const Divider(),

            Expanded(
              child: redacteurs.isEmpty
                  ? const Center(
                      child: Text(
                        "Ajoutez au moins un utilisateur pour gérer les rédacteurs",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: redacteurs.length,
                      itemBuilder: (_, i) {
                        final r = redacteurs[i];
                        return Card(
                          child: ListTile(
                            title: Text("${r.nom} ${r.prenom}"),
                            subtitle: Text(r.email),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _modifier(r),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _supprimer(r.id!),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
