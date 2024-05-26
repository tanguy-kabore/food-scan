import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthRepository {
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
  );
  Future<void> login(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController usernameController,
    TextEditingController passwordController,
    FlutterSecureStorage secureStorage,
    Function(bool) setLoadingState,
  );
}
