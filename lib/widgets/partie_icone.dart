import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  Future<void> _appeler(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: '+33100000000');
    final peut = await canLaunchUrl(uri);
    if (!context.mounted) return;
    if (peut) {
      await launchUrl(uri);
    } else {
      _snack(context, 'Impossible d\'ouvrir le composeur téléphonique.');
    }
  }

  Future<void> _envoyerMail(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'contact@magazineinfos.fr',
      query: 'subject=Contact Magazine Infos',
    );
    final peut = await canLaunchUrl(uri);
    if (!context.mounted) return;
    if (peut) {
      await launchUrl(uri);
    } else {
      _snack(context, 'Impossible d\'ouvrir le client mail.');
    }
  }

  void _partager() {
    Share.share(
      'Découvrez Magazine Infos — la plateforme dédiée à la presse et aux tendances numériques !',
      subject: 'Magazine Infos',
    );
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget _icone(BuildContext context, IconData icon, String label,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nous contacter',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _icone(context, Icons.phone, 'TEL', () => _appeler(context)),
              _icone(context, Icons.email, 'MAIL',
                  () => _envoyerMail(context)),
              _icone(context, Icons.share, 'PARTAGE', _partager),
            ],
          ),
        ],
      ),
    );
  }
}
