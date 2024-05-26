import 'package:flutter/material.dart';

/// Classe `AppColor` centralisant la gestion des couleurs et des dégradés utilisés dans l'application.
///
/// Cette classe fournit un accès global à des couleurs spécifiques et à des configurations de dégradés,
/// facilitant ainsi la cohérence du design à travers l'ensemble de l'application.
/// En utilisant des membres statiques, `AppColor` permet d'accéder facilement à ces couleurs et dégradés
/// sans nécessiter d'instanciation, ce qui simplifie leur utilisation dans divers composants de l'UI.
///
/// Exemples d'utilisation :
/// - Pour appliquer une couleur : `color: AppColor.primaryColor`
/// - Pour appliquer un dégradé : `gradient: AppColor.linearGradient`
class AppColor {
  /// Constructeur privé pour empêcher l'instanciation et encourager l'utilisation en tant que classe sans instance.
  AppColor._();

  /// Couleur verte utilisée comme thème principal ou accent dans l'application.
  static const Color primaryColor = Color(0xFF268e02);

  /// Crée un `MaterialColor` à partir d'une couleur `Color`.
  ///
  /// Cette méthode prend un objet `Color` et génère un `MaterialColor` qui peut être utilisé pour
  /// le `primarySwatch` dans les thèmes Flutter. Elle calcule différentes intensités de la couleur
  /// pour permettre une utilisation cohérente dans différents composants de l'interface utilisateur.
  ///
  /// [color] - La couleur de base à convertir en `MaterialColor`.
  ///
  /// Retourne un `MaterialColor` permettant des variations de la couleur principale.
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  /// `MaterialColor` pour `primaryColor` utilisé comme thème principal.
  static final MaterialColor primarySwatch = createMaterialColor(primaryColor);

  /// Configuration de dégradé linéaire comprenant plusieurs nuances de vert.
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xFF268e02), // Vert foncé
      Color(0xFF3cae10), // Vert moyen foncé
      Color(0xFF52cd1e), // Vert moyen
      Color(0xFF68ec2c), // Vert clair
      Color(0xFF7ffb3a), // Vert très clair
      Color(0xFF95fc48), 
      Color(0xFFabfd56),
      Color(0xFFc1fe64),
      Color(0xFFd7ff72),
    ],
  );
}