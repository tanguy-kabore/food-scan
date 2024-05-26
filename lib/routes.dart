import 'package:flutter/material.dart';
import 'package:foodscan/features/history/screens/history_screen.dart';

import 'features/home/screens/home_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/setting/screens/setting_screen.dart';
import 'features/splash/splash_screen.dart';

class Routes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String history = '/history';

  static Map<String, WidgetBuilder> appRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      home: (context) => const HomeScreen(),
      settings: (context) => const SettingScreen(),
      profile: (context) => const ProfileScreen(),
      history: (context) => const HistoryScreen(),
    };
  }
}
