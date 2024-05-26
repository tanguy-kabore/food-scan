import 'package:flutter/material.dart';

enum ButtonPosition {
  left,
  right,
  center,
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final ButtonPosition position;
  final bool loading;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.position = ButtonPosition.center,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: position == ButtonPosition.left
          ? MainAxisAlignment.start
          : position == ButtonPosition.right
              ? MainAxisAlignment.end
              : MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: loading ? null : onPressed,
          child: loading
              ? const CircularProgressIndicator()
              : Text(buttonText),
        ),
      ],
    );
  }
}

