import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:share/share.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../auth/screens/login_screen.dart';

const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
Future<String> scanBarcode(BuildContext context) async {
  try {
    final ScanResult scanResult = await BarcodeScanner.scan();
    final String barcode = scanResult.rawContent;

    if (barcode.isNotEmpty) {
      return barcode;
    }
  } catch (e) {
    //print('Scan failed: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scan failed: $e')),
      );
    }
  }
  return ''; // Retourne une chaîne vide si le scan a échoué
}

Future<void> logout(BuildContext context) async {
  await _secureStorage.delete(key: 'username');
  await _secureStorage.delete(key: 'password');
  if (context.mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}

Future<void> shareOnWhatsApp(
    BuildContext context, Product? product, ChatSession chat) async {
  if (product != null) {
    String productName = product.productName ?? 'Unknown Product';
    String productDescription =
        product.ingredientsText ?? 'No description available';
    String productDetails = '''
    Product Name: $productName
    Description: $productDescription
    ''';

    try {
      String aiResponse = await sendToAIForAnalysis(chat, productDetails);
      await Share.share(aiResponse, subject: 'Product Analysis');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to analyze product: $e')),
        );
      }
    }
  }
}

Future<String> sendToAIForAnalysis(
    ChatSession chat, String productDetails) async {
  try {
    var response = await chat.sendMessage(
      Content.text(
          'Analyze the following product details and provide a brief summary:\n$productDetails'),
    );

    var text = response.text;
    if (text == null) {
      throw Exception('No response from API.');
    }
    return correctAndFormatText(text);
  } catch (e) {
    throw Exception('Failed to get response from AI: $e');
  }
}

String correctAndFormatText(String text) {
  // Appliquer ici des corrections et un joli formatage
  text =
      text.replaceAll('\n', '\n'); // Ajouter des espaces entre les paragraphes
  text = text.replaceAll('Product Name:', 'Nom du Produit:');
  text = text.replaceAll('Description:', 'Description:');
  return text;
}

Future<void> showAIAnalysis(
    BuildContext context, Product? product, ChatSession chat) async {
  if (product != null) {
    String productName = product.productName ?? 'Unknown Product';
    String productDescription =
        product.ingredientsText ?? 'No description available';
    String productDetails = '''
    Product Name: $productName
    Description: $productDescription
    ''';

    // Afficher la boîte de dialogue avec le message d'attente
    showDialog(
      context: context,
      barrierDismissible:
          false, // Empêcher la fermeture de la boîte de dialogue
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('AI Analysis'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Veuillez patienter que nous analysions les résultats...')
            ],
          ),
        );
      },
    );

    try {
      String aiResponse = await sendToAIForAnalysis(chat, productDetails);

      // Remplacer le contenu de la boîte de dialogue par le résultat de l'analyse
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      if (context.mounted) {
        // Fermer la boîte de dialogue de chargement
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('AI Analysis'),
              content: SingleChildScrollView(
                child: Text(aiResponse),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context)
            .pop(); // Fermer la boîte de dialogue de chargement
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to analyze product: $e')),
        );
      }
    }
  }
}

Future<void> saveProduct(BuildContext context, Product product) async {
  final prefs = await SharedPreferences.getInstance();
  final barcode = product.barcode ?? 'Unknown Barcode';

  if (!prefs.containsKey(barcode)) {
    try {
      // Vérifiez et demandez la permission de localisation
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // Obtenez la localisation précise
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final double latitude = position.latitude;
      final double longitude = position.longitude;
      final DateTime now = DateTime.now();

      // Créez un objet map pour stocker le produit avec des informations supplémentaires
      final productData = {
        'product': product.toJson(),
        'createdAt': now.toIso8601String(),
        'location': {'latitude': latitude, 'longitude': longitude},
      };

      // Sauvegardez l'objet en tant que chaîne JSON
      await prefs.setString(barcode, jsonEncode(productData));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product saved successfully.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to get location: $e')),
        );
      }
    }
  } else {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product already exists.')),
      );
    }
  }
}

void resetProduct(BuildContext context, Function resetState) {
  resetState();
}
