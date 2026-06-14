import 'package:flutter/material.dart';
import '../widgets/partie_titre.dart';
import '../widgets/partie_texte.dart';
import '../widgets/partie_icone.dart';
import '../widgets/partie_rubrique.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/magazineInfo.jpg',
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
            errorBuilder: (ctx, e, _) => Container(
              width: double.infinity,
              height: 220,
              color: Colors.pink.shade100,
              child: Icon(Icons.image_not_supported,
                  size: 60, color: Colors.pink.shade300),
            ),
          ),
          const PartieTitre(),
          const PartieTexte(),
          const SizedBox(height: 8),
          const PartieIcone(),
          const PartieRubrique(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
