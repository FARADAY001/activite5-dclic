import 'package:flutter/material.dart';
import '../controllers/redacteur_controller.dart';
import 'redacteur_info_page.dart';

class AjoutRedacteurPage extends StatefulWidget {
  final RedacteurController controller;

  const AjoutRedacteurPage({super.key, required this.controller});

  @override
  State<AjoutRedacteurPage> createState() => _AjoutRedacteurPageState();
}

class _AjoutRedacteurPageState extends State<AjoutRedacteurPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _specialiteController = TextEditingController();
  bool _chargement = false;
  String? _erreur;

  final ButtonStyle _styleBouton = ElevatedButton.styleFrom(
    backgroundColor: Colors.pink.shade600,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  @override
  void dispose() {
    _nomController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }

  Future<void> _ajouterRedacteur() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _chargement = true;
      _erreur = null;
    });
    try {
      await widget.controller.ajouterRedacteur(
        _nomController.text.trim(),
        _specialiteController.text.trim(),
      );
      if (!mounted) return;
      _afficherSuccesDialog();
    } catch (e) {
      if (!mounted) return;
      setState(() => _erreur = 'Erreur lors de l\'enregistrement : $e');
    } finally {
      if (mounted) setState(() => _chargement = false);
    }
  }

  void _afficherSuccesDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Succès'),
        content: const Text('Le rédacteur a été ajouté avec succès.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      RedacteurInfoPage(controller: widget.controller),
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un rédacteur')),
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
                      style: _styleBouton,
                      icon: const Icon(Icons.save),
                      label: const Text('Enregistrer'),
                      onPressed: _ajouterRedacteur,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
