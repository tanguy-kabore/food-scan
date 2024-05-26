import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/openfoodfacts.dart';
import 'auth_repository.dart';

/// Implémente l'interface [AuthRepository] pour fournir des fonctionnalités liées à l'authentification.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  /// Construit une instance de [AuthRepositoryImpl] avec la [remoteDataSource] requise.
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> register(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController usernameController,
      TextEditingController passwordController,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController orgNameController,
      bool newsletter,
      Function(bool p1) setLoadingState) async {
    return remoteDataSource.register(
        context,
        formKey,
        usernameController,
        passwordController,
        nameController,
        emailController,
        orgNameController,
        newsletter,
        (p0) => null);
  }

  @override
  Future<void> login(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController usernameController,
      TextEditingController passwordController,
      FlutterSecureStorage secureStorage,
      Function(bool p1) setLoadingState) async {
    return await remoteDataSource.login(context, formKey, usernameController,
        passwordController, secureStorage, (p0) => null);
  }
}
