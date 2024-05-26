import 'package:flutter/material.dart';

class SlideWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback? onButtonPressed;
  final IconData buttonIcon;

  const SlideWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.onButtonPressed,
    this.buttonIcon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 200),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          IconButton(
            icon: Icon(buttonIcon),
            onPressed: onButtonPressed,
          ),
        ],
      ),
    );
  }
}
