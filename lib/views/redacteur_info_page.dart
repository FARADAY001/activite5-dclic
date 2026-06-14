import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../modele/redacteur.dart';
import 'ajout_redacteur_page.dart';
import 'detail_redacteur_page.dart';
import 'modifier_redacteur_page.dart';

class RedacteurInfoPage extends StatefulWidget {
  final RedacteurController controller;

  const RedacteurInfoPage({super.key, required this.controller});

  @override
  State<RedacteurInfoPage> createState() => _RedacteurInfoPageState();
}

class _RedacteurInfoPageState extends State<RedacteurInfoPage> {
  String _recherche = '';
  String _tri = 'nom_asc';

  List<Redacteur> _filtrerEtTrier(List<Redacteur> liste) {
    var resultat = liste.where((r) {
      final q = _recherche.toLowerCase();
      return r.nom.toLowerCase().contains(q) ||
          r.specialite.toLowerCase().contains(q);
    }).toList();

    switch (_tri) {
      case 'nom_asc':
        resultat.sort((a, b) => a.nom.compareTo(b.nom));
        break;
      case 'nom_desc':
        resultat.sort((a, b) => b.nom.compareTo(a.nom));
        break;
      case 'specialite_asc':
        resultat.sort((a, b) => a.specialite.compareTo(b.specialite));
        break;
      case 'specialite_desc':
        resultat.sort((a, b) => b.specialite.compareTo(a.specialite));
        break;
    }
    return resultat;
  }

  Widget _avatar(Redacteur r) {
    return CircleAvatar(
      backgroundColor: Colors.pink.shade600,
      radius: 24,
      child: Text(
        r.nom.isNotEmpty ? r.nom[0].toUpperCase() : '?',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informations des rédacteurs'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (val) => setState(() => _tri = val),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'nom_asc', child: Text('Nom A → Z')),
              PopupMenuItem(value: 'nom_desc', child: Text('Nom Z → A')),
              PopupMenuItem(
                  value: 'specialite_asc', child: Text('Spécialité A → Z')),
              PopupMenuItem(
                  value: 'specialite_desc', child: Text('Spécialité Z → A')),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade600,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AjoutRedacteurPage(controller: widget.controller),
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher par nom ou spécialité...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (val) => setState(() => _recherche = val),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: widget.controller.redacteursStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(
                      child: Text('Erreur de connexion à Firestore.'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'Aucun rédacteur trouvé.\nAjoutez-en un depuis le menu.',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final tous = snapshot.data!.docs
                    .map((doc) => Redacteur.fromFirestore(doc))
                    .toList();
                final redacteurs = _filtrerEtTrier(tous);

                if (redacteurs.isEmpty) {
                  return const Center(
                      child: Text('Aucun résultat pour cette recherche.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: redacteurs.length,
                  itemBuilder: (context, index) {
                    final r = redacteurs[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailRedacteurPage(
                                redacteur: r,
                                controller: widget.controller),
                          ),
                        ),
                        leading: _avatar(r),
                        title: Text(r.nom,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(r.specialite),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ModifierRedacteurPage(
                                    redacteur: r,
                                    controller: widget.controller,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title:
                                      const Text('Confirmer la suppression'),
                                  content: Text(
                                      'Voulez-vous vraiment supprimer "${r.nom}" ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Annuler'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        try {
                                          await widget.controller
                                              .supprimerRedacteur(r.id);
                                        } catch (e) {
                                          if (!context.mounted) return;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Erreur de suppression : $e'),
                                            backgroundColor: Colors.red,
                                          ));
                                        }
                                      },
                                      child: const Text('Supprimer',
                                          style:
                                              TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
