import 'package:flutter/material.dart';

/// Classe ActionMenu pour gérer les menus contextuels de l'application.
class ActionMenu {
  /// Menu pour la déconnexion.
  static final List<PopupMenuEntry<String>> logoutMenu = [
    const PopupMenuItem(
      value: 'logout',
      child: ListTile(
        leading: Icon(Icons.exit_to_app), // Icône pour la déconnexion
        title: Text('Logout'), // Texte du menu pour la déconnexion
      ),
    ),
  ];

  /// Menu pour les paramètres.
  static final List<PopupMenuEntry<String>> settingsMenu = [
    const PopupMenuItem(
      value: 'settings',
      child: ListTile(
        leading: Icon(Icons.settings), // Icône pour les paramètres
        title: Text('Settings'), // Texte du menu pour les paramètres
      ),
    ),
  ];

  static final List<PopupMenuEntry<String>> aboutMenu = [
    const PopupMenuItem(
      value: 'about',
      child: ListTile(
        leading:
            Icon(Icons.info), // Updated to an info icon, suitable for "About"
        title: Text('About'), // Texte du menu pour "À propos"
      ),
    ),
  ];

  /// Menu pour le profil de l'utilisateur.
  static final List<PopupMenuEntry<String>> profileMenu = [
    const PopupMenuItem(
      value: 'profile',
      child: ListTile(
        leading: Icon(Icons.person), // Icône pour le profil
        title: Text('Profile'), // Texte du menu pour le profil
      ),
    ),
  ];

  /// Construit et retourne le menu approprié selon la page spécifiée.
  ///
  /// [page] - Le nom de la page pour laquelle construire le menu.
  /// Retourne une liste de PopupMenuEntry<String> correspondant aux options de menu appropriées.
  static List<PopupMenuEntry<String>> buildMenu(String page) {
    switch (page) {
      case 'home':
        return [...settingsMenu, ...logoutMenu]; // Menu pour la page d'accueil
      case 'settings':
        return [...logoutMenu];
      case 'profile':
        return [...logoutMenu];
      default:
        return []; // Retourne un menu vide pour les pages non spécifiées
    }
  }
}
