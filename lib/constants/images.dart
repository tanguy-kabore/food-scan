/// Classe `Images` fournissant un accès centralisé aux chemins des ressources image de l'application.
///
/// Cette classe utilise un modèle de conception singleton sans instance pour regrouper
/// et fournir un accès facile et centralisé aux chemins des images utilisées à travers l'application.
/// L'utilisation d'une classe sans instance et de membres statiques permet d'accéder aux chemins des images
/// sans avoir besoin d'instancier la classe `Images`, facilitant ainsi l'accès aux ressources image de manière
/// cohérente et organisée.
///
/// Exemple d'utilisation :
/// ```
/// Image.asset(Images.logo);
/// ```
class Images {
  /// Constructeur privé pour empêcher l'instanciation et encourager l'utilisation en tant que classe sans instance.
  Images._();

  /// Chemin vers l'image du logo de l'application.
  ///
  /// Ce champ statique contient le chemin relatif au dossier des assets pour accéder à l'image du logo.
  /// Il est utilisé à travers l'application pour représenter visuellement la marque ou l'identité de l'application.
  static const String logo1 = 'assets/images/logo/1.png';
  static const String logo2 = 'assets/images/logo/2.png';
  static const String logo3 = 'assets/images/logo/3.png';

  static const String onboard1 = 'assets/images/onboard/1.png';
  static const String onboard2= 'assets/images/onboard/2.png';
  static const String onboard3 = 'assets/images/onboard/3.png';
}