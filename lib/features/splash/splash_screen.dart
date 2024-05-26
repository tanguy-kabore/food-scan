import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/images.dart';
import '../auth/screens/login_screen.dart';
import '../home/screens/home_screen.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../onboard/screens/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _startSplashScreenTimer();
  }

  void _startSplashScreenTimer() {
    Timer(const Duration(seconds: 3), () async {
      // Déterminer si c'est le premier lancement
      final prefs = await SharedPreferences.getInstance();
      final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
      final String? username = await _secureStorage.read(key: 'username');
      final String? password = await _secureStorage.read(key: 'password');

      if (username != null && password != null) {
        // Set the global user
        OpenFoodAPIConfiguration.globalUser = User(
          userId: username,
          password: password,
        );
        _navigateToNextScreen(const HomeScreen());
      } else {
        isFirstLaunch
            ? _navigateToNextScreen(const OnBoardScreen())
            : _navigateToNextScreen(const LoginScreen());
      }
    });
  }

  void _navigateToNextScreen(Widget nextScreen) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => nextScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(Images.logo3, width: 150.0),
          ],
        ),
      ),
    );
  }
}
