import 'package:flutter/material.dart';
import 'package:movies_app/constants/ui_strings.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/presentation/auth/view_model/login_view_model.dart';
import 'package:movies_app/core/providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(
        Provider.of<AuthProvider>(context, listen: false),
      ),
      child: const _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(UIStrings.loginTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Consumer<LoginViewModel>(
              builder: (context, viewModel, _) => TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: UIStrings.emailLabel,
                  errorText: viewModel.formErrors['email'],
                ),
              ),
            ),
            Consumer<LoginViewModel>(
              builder: (context, viewModel, _) => TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: UIStrings.passwordLabel,
                  errorText: viewModel.formErrors['password'],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<LoginViewModel>(
              builder: (context, viewModel, _) {
                return Column(
                  children: [
                    if (viewModel.error != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        viewModel.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    ElevatedButton(
                      onPressed: viewModel.isLoading
                          ? null
                          : () {
                              viewModel.validateAndLogin(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                () {
                                  Provider.of<NavigatorProvider>(context,
                                          listen: false)
                                      .pushAndRemoveUntil('/');
                                },
                              );
                            },
                      child: viewModel.isLoading
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(UIStrings.loginTitle),
                    ),
                  ],
                );
              },
            ),
            TextButton(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Provider.of<NavigatorProvider>(context, listen: false)
                      .pushAndRemoveUntil('/signup');
                });
              },
              child: const Text(UIStrings.doNotHaveAccount),
            ),
          ],
        ),
      ),
    );
  }
}
