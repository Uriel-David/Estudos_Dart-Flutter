// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { singUp, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMode authMode = AuthMode.login;
  Map<String, String> authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => authMode == AuthMode.login;
  bool _isSignUp() => authMode == AuthMode.singUp;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        authMode = AuthMode.singUp;
      } else {
        authMode = AuthMode.login;
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Oops! Error.'),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  void _submit() async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => isLoading = true);
    formKey.currentState?.save();
    Auth auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.signIn(
          authData['email']!,
          authData['password']!,
        );
      }

      if (_isSignUp()) {
        await auth.signUp(
          authData['email']!,
          authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Unexpected error!');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 310 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => authData['email'] = email ?? '',
                validator: (emailValue) {
                  final email = emailValue ?? '';

                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Email invalid.';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: passwordController,
                onSaved: (password) => authData['password'] = password ?? '',
                validator: (passwordValue) {
                  final password = passwordValue ?? '';

                  if (password.isEmpty || password.length < 5) {
                    return 'Password invalid: length less than 5 or empty.';
                  }

                  return null;
                },
              ),
              if (_isSignUp())
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Password Confirm'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: _isLogin()
                      ? null
                      : (passwordValue) {
                          final password = passwordValue ?? '';

                          if (password != passwordController) {
                            return 'Password empty or not equals.';
                          }

                          return null;
                        },
                ),
              const SizedBox(height: 20),
              if (isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      )),
                  child:
                      Text(authMode == AuthMode.login ? 'Login' : 'Register'),
                ),
              const Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(_isLogin()
                    ? 'Do you want to register?'
                    : 'Already have an account?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
