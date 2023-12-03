import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  final void Function(AuthFormData) onSubmit;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Image not select');
    }

    widget.onSubmit(_formData);
  }

  void _handleImagePicker(File image) {
    _formData.image = image;
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
                UserImagePicker(onImagePick: _handleImagePicker),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  onChanged: (name) => _formData.name = name,
                  validator: (nameValue) {
                    final name = nameValue ?? '';

                    if (name.trim().length < 3) {
                      return 'name must have at least 3 characters.';
                    }

                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
                onChanged: (email) => _formData.email = email,
                validator: (emailValue) {
                  final email = emailValue ?? '';

                  if (!email.contains('@')) {
                    return 'email format invalid.';
                  }

                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                onChanged: (password) => _formData.password = password,
                validator: (passValue) {
                  final password = passValue ?? '';

                  if (password.trim().length < 6) {
                    return 'password must have at least 6 characters.';
                  }

                  return null;
                },
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
