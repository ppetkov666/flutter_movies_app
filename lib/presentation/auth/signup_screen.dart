import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/presentation/auth/view_model/signup_view_model.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/core/providers/auth_provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(
        Provider.of<AuthProvider>(context, listen: false),
      ),
      child: const _SignupForm(),
    );
  }
}

class _SignupForm extends StatefulWidget {
  const _SignupForm({super.key});

  @override
  State<_SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<_SignupForm> {
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
      appBar: AppBar(
        title: const Text('Sign Up'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Consumer<SignupViewModel>(
              builder: (context, viewModel, _) => TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: viewModel.formErrors['email'],
                ),
              ),
            ),
            Consumer<SignupViewModel>(
              builder: (context, viewModel, _) => TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: viewModel.formErrors['password'],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<SignupViewModel>(
              builder: (context, viewModel, _) {
                return Column(
                  children: [
                    if (viewModel.error != null) ...[
                      Text(
                        viewModel.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 12),
                    ],
                    viewModel.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () {
                        viewModel.validateAndSignup(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                              () {
                            Provider.of<NavigatorProvider>(context, listen: false)
                                .pushAndRemoveUntil('/');
                          },
                        );
                      },
                      child: const Text('Create Account'),
                    ),
                  ],
                );
              },
            ),
            TextButton(
              onPressed: () {
                //allow tap splash animation to complete and avoid animation controller errors
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Provider.of<NavigatorProvider>(context, listen: false)
                      .pushAndRemoveUntil('/login');
                });
              },
              child: const Text("Already have an account? Log in"),
            ),
          ],
        ),
      ),
    );
  }
}

