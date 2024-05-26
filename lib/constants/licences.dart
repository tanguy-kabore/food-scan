/// Classe `HtmlAssets` fournissant un accès centralisé aux chemins des ressources HTML de l'application.
///
/// Cette classe utilise un modèle de conception singleton sans instance pour regrouper
/// et fournir un accès facile et centralisé aux chemins des fichiers HTML utilisés à travers l'application.
/// L'utilisation d'une classe sans instance et de membres statiques permet d'accéder aux chemins des fichiers HTML
/// sans avoir besoin d'instancier la classe `HtmlAssets`, facilitant ainsi l'accès aux ressources HTML de manière
/// cohérente et organisée.
///
/// Exemple d'utilisation :
/// ```
/// WebView.loadUrl(HtmlAssets.licenceAgreement);
/// ```
class HtmlAssets {
  /// Constructeur privé pour empêcher l'instanciation et encourager l'utilisation en tant que classe sans instance.
  HtmlAssets._();

  /// Chemin vers le fichier HTML de l'accord de licence de l'application.
  ///
  /// Ce champ statique contient le chemin relatif au dossier des assets pour accéder au fichier HTML de l'accord de licence.
  /// Il est utilisé à travers l'application pour afficher les termes et conditions ou l'accord de licence de l'application.
  static const String licenceAgreement = 'assets/html/licence_agreement.html';
}
