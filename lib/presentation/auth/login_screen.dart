import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.isLoading
                  ? null
                  : () {
                viewModel.login(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                      () {
                    Provider.of<NavigatorProvider>(context, listen: false)
                        .pushAndRemoveUntil('/');
                  },
                );
              },
              child: viewModel.isLoading
                  ? const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<NavigatorProvider>(context, listen: false)
                    .pushAndRemoveUntil('/signup');
              },
              child: const Text("Do not have an account? Sign up"),
            ),
            if (viewModel.error != null) ...[
              const SizedBox(height: 12),
              Text(
                viewModel.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
