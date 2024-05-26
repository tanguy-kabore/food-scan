import 'package:flutter/material.dart';

import 'custom_button_widget.dart';
import '../screens/licence_screen.dart';

class LastSlideWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const LastSlideWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Utilisez l'image spécifiée par l'utilisateur
          Image.asset(imagePath, height: 200),
          const SizedBox(height: 10),
          // Affichez le titre fourni par l'utilisateur
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // Affichez la description fournie par l'utilisateur
          Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 40),
          CustomButton(
            buttonText: 'Finish',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LicenceScreen()),
                (Route<dynamic> route) => false,
              );
            },
            position: ButtonPosition.center,
          )
        ],
      ),
    );
  }
}
