import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import '../../home/screens/home_screen.dart';

class AuthRemoteDataSource {
  Future<void> register(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController usernameController,
    TextEditingController passwordController,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController orgNameController,
    bool newsletter,
    Function(bool) setLoadingState,
  ) async {
    if (formKey.currentState!.validate()) {
      setLoadingState(true);

      OpenFoodAPIConfiguration.userAgent = UserAgent(
        name: 'foodscan',
      );

      OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
        OpenFoodFactsLanguage.ENGLISH,
      ];

      User offUser = User(
        userId: usernameController.text,
        password: passwordController.text,
      );

      try {
        SignUpStatus status = await OpenFoodAPIClient.register(
          user: offUser,
          name: nameController.text,
          email: emailController.text,
          orgName:
              orgNameController.text.isNotEmpty ? orgNameController.text : null,
          newsletter: newsletter,
        );

        setLoadingState(false);

        if (status.status == 201) {
          OpenFoodAPIConfiguration.globalUser = offUser;
          await const FlutterSecureStorage()
              .write(key: 'username', value: offUser.userId);
          await const FlutterSecureStorage()
              .write(key: 'password', value: offUser.password);
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created successfully!')),
          );
          if (!context.mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${status.error}')),
          );
        }
      } catch (e) {
        setLoadingState(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exception: $e')),
        );
      }
    }
  }

  Future<void> login(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController usernameController,
    TextEditingController passwordController,
    FlutterSecureStorage secureStorage,
    Function(bool) setLoadingState,
  ) async {
    if (formKey.currentState!.validate()) {
      setLoadingState(true);

      OpenFoodAPIConfiguration.userAgent = UserAgent(
        name: 'foodscan',
      );

      User offUser = User(
        userId: usernameController.text,
        password: passwordController.text,
      );

      try {
        LoginStatus? status = await OpenFoodAPIClient.login2(offUser);

        setLoadingState(false);

        if (status == null) {
          throw Exception('Network error');
        }

        if (status.successful) {
          OpenFoodAPIConfiguration.globalUser = offUser;
          await secureStorage.write(key: 'username', value: offUser.userId);
          await secureStorage.write(key: 'password', value: offUser.password);
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged in successfully!')),
          );
          if (!context.mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Error, wrong credentials: ${status.statusVerbose}')),
          );
        }
      } catch (e) {
        setLoadingState(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exception: $e')),
        );
      }
    }
  }
}
