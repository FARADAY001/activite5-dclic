import 'package:flutter/material.dart';

class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  Widget _carte(String asset, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              asset,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (ctx, e, _) => Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.image_not_supported,
                    size: 40, color: Colors.pink.shade200),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nos rubriques',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _carte('assets/images/presse.jpg', 'Presse'),
              const SizedBox(width: 12),
              _carte('assets/images/design.jpg', 'Design'),
            ],
          ),
        ],
      ),
    );
  }
}
