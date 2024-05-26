import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/auth_repository.dart';

class RegisterForm extends StatefulWidget {
  final Function(bool) setLoadingState;

  const RegisterForm({super.key, required this.setLoadingState});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  late final AuthRepository _authRepository;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _orgNameController = TextEditingController();
  bool _newsletter = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authRepository = Provider.of<AuthRepository>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _orgNameController,
            decoration: const InputDecoration(labelText: 'Organization Name'),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Checkbox(
                value: _newsletter,
                onChanged: (bool? value) {
                  setState(() {
                    _newsletter = value ?? true;
                  });
                },
              ),
              const Text('Subscribe to newsletter'),
            ],
          ),
          const SizedBox(height: 20),
          _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    _authRepository.register(
                      context,
                      _formKey,
                      _usernameController,
                      _passwordController,
                      _nameController,
                      _emailController,
                      _orgNameController,
                      _newsletter,
                      (isLoading) => setState(() => _isLoading = isLoading),
                    );
                  },
                  child: const Text('Register'),
                ),
        ],
      ),
    );
  }
}
