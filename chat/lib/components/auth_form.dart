import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submit() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  onChanged: (name) => _formData.name = name,
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                onChanged: (email) => _formData.email = email,
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                onChanged: (password) => _formData.password = password,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                child: Text(_formData.isLogin ? 'Enter' : 'Register'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(_formData.isLogin
                    ? 'Create new account?'
                    : 'Already have an account?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
