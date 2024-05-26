import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/licences.dart';
import '../../auth/screens/register_screen.dart';
import '../widgets/custom_button_widget.dart';
import '../onboard_utils.dart';

/// Classe LicenceScreen
///
/// Cette classe crée un écran qui affiche les termes de licence dans un WebView.
/// L'utilisateur doit accepter les termes pour continuer à utiliser l'application.
/// Si l'utilisateur accepte, les termes sont sauvegardés dans les préférences et l'application
/// redirige vers l'écran d'authentification.
class LicenceScreen extends StatefulWidget {
  const LicenceScreen({super.key});

  @override
  LicenceScreenState createState() => LicenceScreenState();
}

class LicenceScreenState extends State<LicenceScreen> {
  bool _isAccepted = false; // Gère l'état de l'acceptation des termes.
  bool _isLoading = true; // Indicateur de chargement du WebView.
  WebViewController? _webViewController; // Contrôleur pour le WebView.

  @override
  void initState() {
    super.initState();
    initializeWebView(); // Initialisation du WebView.
  }

  /// Initialise le WebView avec les paramètres nécessaires et charge le contenu.
  void initializeWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset(HtmlAssets
          .licenceAgreement) // Chargement du fichier des termes de licence.
      ..addJavaScriptChannel("messageHandler",
          onMessageReceived: (JavaScriptMessage message) {
        setState(() {
          _isLoading = false; // Cache le loader une fois le contenu chargé.
        });
      });
  }

  /// Gère le changement d'état de la checkbox pour accepter les termes.
  void _handleAccept(bool? value) {
    setState(() {
      _isAccepted = value ?? false;
    });
  }

  /// Gère l'action d'acceptation des termes.
  /// Sauvegarde la préférence et navigue vers l'écran suivant.
  Future<void> _onAccept() async {
    if (_isAccepted) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstLaunch', false);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: WebViewWidget(
                          controller: _webViewController!,
                        ),
                      ),
                      CheckboxListTile(
                        title: const Text("I accept the contract term"),
                        value: _isAccepted,
                        onChanged: _handleAccept,
                      ),
                      Center(
                        child: CustomButton(
                          buttonText: _isAccepted ? 'Continue' : 'Refuse',
                          onPressed: _isAccepted
                              ? _onAccept
                              : () async => await Utils.showExitDialog(context),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
