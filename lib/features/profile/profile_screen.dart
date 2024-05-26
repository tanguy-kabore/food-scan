import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final TextEditingController _emailController = TextEditingController();
  bool _isResettingPassword = false;
  String? _username;
  String? _statusMessage;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    // Charger le nom d'utilisateur depuis le stockage sécurisé ou une autre source de données
    String? username = await _secureStorage.read(key: 'username');
    setState(() {
      _username = username;
    });
  }

  Future<void> _resetPassword() async {
    setState(() {
      _isResettingPassword = true;
      _statusMessage = null;
    });

    String emailOrUserID = _emailController.text;

    try {
      Status status = await OpenFoodAPIClient.resetPassword(
        emailOrUserID,
        language: OpenFoodFactsLanguage.FRENCH,
        country: OpenFoodFactsCountry.FRANCE,
      );

      setState(() {
        _statusMessage = status.status == 200
            ? 'A reset email has been sent.'
            : 'Error: ${status.body}';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Exception: $e';
      });
    } finally {
      setState(() {
        _isResettingPassword = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (_username != null)
              Text(
                'Username: $_username',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email or username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isResettingPassword ? null : _resetPassword,
              child: _isResettingPassword
                  ? const CircularProgressIndicator()
                  : const Text('Reset password'),
            ),
            if (_statusMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  _statusMessage!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
