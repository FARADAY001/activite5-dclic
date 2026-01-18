import 'package:flutter/material.dart';

class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "Magazine Infos est une plateforme numérique dédiée à la presse, "
        "à la mode et aux tendances modernes. Elle offre des contenus "
        "accessibles, variés et de qualité.",
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 14, height: 1.5),
      ),
    );
  }
}
