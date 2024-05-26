import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'providers.dart';
import 'routes.dart';
import 'themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Assurez-vous que les widgets Flutter sont initialisés avant d'exécuter le code asynchrone
  await dotenv.load(fileName: "../.env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: AppProviders.getProviders(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData,
          initialRoute: Routes.splash,
          routes: Routes.appRoutes(),
        ));
  }
}
