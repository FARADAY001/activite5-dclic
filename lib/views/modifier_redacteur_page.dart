import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import '../modele/redacteur.dart';

class ModifierRedacteurPage extends StatefulWidget {
  final Redacteur redacteur;
  final RedacteurController controller;

  const ModifierRedacteurPage({
    super.key,
    required this.redacteur,
    required this.controller,
  });

  @override
  State<ModifierRedacteurPage> createState() => _ModifierRedacteurPageState();
}

class _ModifierRedacteurPageState extends State<ModifierRedacteurPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _specialiteController;
  bool _chargement = false;
  String? _erreur;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.redacteur.nom);
    _specialiteController =
        TextEditingController(text: widget.redacteur.specialite);
  }

  @override
  void dispose() {
    _nomController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }

  Future<void> _enregistrerModifications() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _chargement = true;
      _erreur = null;
    });
    try {
      await widget.controller.modifierRedacteur(
        widget.redacteur.id,
        _nomController.text.trim(),
        _specialiteController.text.trim(),
      );
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Succès'),
          content: const Text('Les informations ont été mises à jour.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _erreur = 'Erreur lors de la mise à jour : $e');
    } finally {
      if (mounted) setState(() => _chargement = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modifier un rédacteur')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_erreur != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(_erreur!,
                      style: const TextStyle(color: Colors.red, fontSize: 13)),
                ),
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Le nom est obligatoire' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _specialiteController,
                decoration: const InputDecoration(
                  labelText: 'Spécialité',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'La spécialité est obligatoire' : null,
              ),
              const SizedBox(height: 24),
              _chargement
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.save),
                      label: const Text('Enregistrer les modifications'),
                      onPressed: _enregistrerModifications,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
