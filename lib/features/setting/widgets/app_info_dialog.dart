import 'package:flutter/material.dart';

const String appName = "foodscan";
const String version = "1.0.0";
const String buildNumber = "1";

class AppInfoDialog extends StatelessWidget {
  const AppInfoDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AppInfoDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(appName),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Nom complet : $appName'),
            Text('Version : $version'),
            Text('Build number : $buildNumber'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
