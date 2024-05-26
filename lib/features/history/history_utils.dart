// history_utils.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';

Future<void> showLocationDialog(BuildContext context, String key,
    double latitude, double longitude, Function deleteProduct) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        //title: const Text('Location Options'),
        content: SizedBox(
          height: 100, // Hauteur fixe du conteneur
          width: double.maxFinite, // Utilise toute la largeur disponible
          child: Center(
            // Centre les enfants horizontalement
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete),
                          SizedBox(
                              height:
                                  4), // Espacement entre l'icône et le texte
                          Text('Delete'),
                        ],
                      ),
                      onTap: () {
                        deleteProduct(key);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map_sharp),
                          SizedBox(
                              height:
                                  4), // Espacement entre l'icône et le texte
                          Text('Map'),
                        ],
                      ),
                      onTap: () {
                        launchMap(latitude, longitude);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share),
                          SizedBox(
                              height:
                                  4), // Espacement entre l'icône et le texte
                          Text('Share'),
                        ],
                      ),
                      onTap: () {
                        shareLocationOnWhatsApp(context, latitude, longitude);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> launchMap(double latitude, double longitude) async {
  Uri uri;

  if (Platform.isAndroid) {
    uri = Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude');
  } else {
    uri = Uri.parse('comgooglemaps://?q=$latitude,$longitude');
  }

  final fallbackUri = Uri(
    scheme: "https",
    host: "maps.google.com",
    queryParameters: {'q': '$latitude, $longitude'},
  );

  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await launchUrl(fallbackUri);
    }
  } catch (e) {
    await launchUrl(fallbackUri);
    debugPrint(e.toString());
  }
}

Future<void> shareLocationOnWhatsApp(
    BuildContext context, double latitude, double longitude) async {
  final message = Uri.encodeFull(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

  try {
    await Share.share(message, subject: 'Product Location');
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to share location: $e')),
    );
  }
}

Future<String> getCityAndCountry(double latitude, double longitude) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
  if (placemarks.isNotEmpty) {
    Placemark place = placemarks.first;
    return '${place.locality}, ${place.country}';
  }
  return 'Unknown Location';
}
