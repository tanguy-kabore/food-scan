import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<void> showExitDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Exit?'),
          content: const Text(
              "Are you sure you want to give up and exit the app?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator
                      .pop(); // Use this for Android to close the app
                } else {
                  // Optionally handle iOS differently, perhaps minimizing or just popping navigation
                  // Navigator.of(context).pop(); // This would just pop the screen not exit the app
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> setPreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}
