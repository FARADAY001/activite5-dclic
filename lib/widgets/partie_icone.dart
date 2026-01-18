import 'package:flutter/material.dart';

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  Widget _icone(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.pink.shade50,
          child: Icon(icon, color: Colors.pink),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.pink.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _icone(Icons.phone, "TEL"),
          _icone(Icons.email, "MAIL"),
          _icone(Icons.share, "PARTAGE"),
        ],
      ),
    );
  }
}
