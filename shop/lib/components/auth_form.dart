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

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMode authMode = AuthMode.login;
  Map<String, String> authData = {
    'email': '',
    'password': '',
  };

  AnimationController? controller;
  Animation<double>? opacityAnimation;
  Animation<Offset>? slideAnimation;

  bool _isLogin() => authMode == AuthMode.login;
  bool _isSignUp() => authMode == AuthMode.singUp;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );

    opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller!,
      curve: Curves.linear,
    ));

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: controller!,
      curve: Curves.linear,
    ));

    // heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        authMode = AuthMode.singUp;
        controller?.forward();
      } else {
        authMode = AuthMode.login;
        controller?.reverse();
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 310 : 400,
        // height: _heightAnimation?.value.height ?? (_isLogin() ? 310 : 400),
        width: deviceSize.width * 0.75,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => authData['email'] = email ?? '',
                validator: (emailValue) {
                  final email = emailValue ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Please provide a valid email.';
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
                    return 'Please provide a valid password';
                  }
                  return null;
                },
              ),
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isLogin() ? 0 : 60,
                  maxHeight: _isLogin() ? 0 : 120,
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: opacityAnimation!,
                  child: SlideTransition(
                    position: slideAnimation!,
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Confirm password'),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      validator: _isLogin()
                          ? null
                          : (passwordValue) {
                              final password = passwordValue ?? '';
                              if (password != passwordController.text) {
                                return 'Entered passwords do not match.';
                              }
                              return null;
                            },
                    ),
                  ),
                ),
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
                    ),
                  ),
                  child: Text(
                    authMode == AuthMode.login ? 'Login' : 'Register',
                  ),
                ),
              const Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  _isLogin() ? 'Want to register?' : 'Already have an account?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
