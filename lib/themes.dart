import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Classe AppTheme pour la gestion centralisée du thème de l'application.
///
/// Cette classe contient une méthode statique qui renvoie le thème principal utilisé dans toute l'application.
/// Elle permet une personnalisation cohérente de l'interface utilisateur en centralisant les configurations de thème.
class AppTheme {
  /// Méthode statique fournissant les données de thème de l'application.
  ///
  /// Ce thème inclut les configurations pour les couleurs primaires, les thèmes d'en-tête d'application, la densité visuelle,
  /// les couleurs d'arrière-plan par défaut des échafaudages, et les icônes.
  static ThemeData get themeData {
    return ThemeData(
      primarySwatch: AppColor
          .primarySwatch, // Nuancier principal basé sur la couleur violette personnalisée.
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor
              .primaryColor, // Couleur de base pour le schéma de couleurs.
          primary: AppColor
              .primaryColor // Couleur primaire utilisée à travers le schéma.
          ),
      appBarTheme: const AppBarTheme(
        backgroundColor:
            AppColor.primaryColor, // Couleur de fond de la barre d'application.
        foregroundColor: Colors
            .white, // Couleur pour le texte et les icônes dans la barre d'application.
        iconTheme: IconThemeData(
            color:
                Colors.white), // Thème des icônes pour la barre d'application.
      ),
      visualDensity: VisualDensity
          .adaptivePlatformDensity, // Densité visuelle adaptative pour diverses plateformes.
      scaffoldBackgroundColor:
          Colors.white, // Couleur de fond par défaut pour les échafaudages.
      iconTheme: const IconThemeData(
          color: AppColor
              .primaryColor // Couleur par défaut des icônes dans toute l'application.
          ),
    );
  }
}
