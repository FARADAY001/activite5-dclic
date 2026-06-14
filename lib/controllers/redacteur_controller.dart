import 'package:cloud_firestore/cloud_firestore.dart';

class RedacteurController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get redacteursStream =>
      _firestore.collection('redacteurs').snapshots();

  Future<void> ajouterRedacteur(String nom, String specialite) async {
    await _firestore.collection('redacteurs').add({
      'nom': nom,
      'specialite': specialite,
    });
  }

  Future<void> modifierRedacteur(String id, String nom, String specialite) async {
    await _firestore.collection('redacteurs').doc(id).update({
      'nom': nom,
      'specialite': specialite,
    });
  }

  Future<void> supprimerRedacteur(String id) async {
    await _firestore.collection('redacteurs').doc(id).delete();
  }
}
