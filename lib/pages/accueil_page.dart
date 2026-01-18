import 'package:flutter/material.dart';
import '../widgets/partie_titre.dart';
import '../widgets/partie_texte.dart';
import '../widgets/partie_icone.dart';
import '../widgets/partie_rubrique.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: AssetImage('assets/images/magazineInfo.jpg')),
          PartieTitre(),
          PartieTexte(),
          PartieIcone(),
          PartieRubrique(),
        ],
      ),
    );
  }
}
