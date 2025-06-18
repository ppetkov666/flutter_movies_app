import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/constants/ui_strings.dart';
import 'package:movies_app/core/providers/auth_provider.dart';
import 'package:movies_app/core/providers/form_switch_provider.dart';
import 'package:movies_app/models/enums/form_type.dart';
import 'package:movies_app/presentation/auth/view_model/login_view_model.dart';
import 'package:movies_app/presentation/components/movie_input_field.dart';
import 'package:movies_app/presentation/components/movie_primary_button.dart';
import 'package:movies_app/presentation/components/movie_error_text.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(
        Provider.of<AuthProvider>(context, listen: false),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Center(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      UIStrings.movieLoginBanner,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Consumer<LoginViewModel>(
              builder: (context, viewModel, _) => MovieInputField(
                controller: emailController,
                label: UIStrings.emailLabel,
                errorText: viewModel.formErrors['email'],
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
            ),
            const SizedBox(height: 16),
            Consumer<LoginViewModel>(
              builder: (context, viewModel, _) => MovieInputField(
                controller: passwordController,
                label: UIStrings.passwordLabel,
                obscure: true,
                errorText: viewModel.formErrors['password'],
                focusNode: passwordFocusNode,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  viewModel.validateAndLogin(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                    () {
                      debugPrint("Login success");
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Consumer<LoginViewModel>(
              builder: (context, viewModel, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (viewModel.error != null) ...[
                      const SizedBox(height: 12),
                      MovieErrorText(viewModel.error!),
                      const SizedBox(height: 12),
                    ],
                    MoviePrimaryButton(
                      onPressed: viewModel.isLoading
                          ? null
                          : () {
                              viewModel.validateAndLogin(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                () {
                                  debugPrint("Login success");
                                },
                              );
                            },
                      isLoading: viewModel.isLoading,
                      label: UIStrings.loginTitle,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Provider.of<FormSwitchProvider>(context, listen: false)
                    .setFormType(FormType.signUp);
              },
              child: const Text(UIStrings.doNotHaveAccount),
            ),
          ],
        ),
      ),
    );
  }
}
