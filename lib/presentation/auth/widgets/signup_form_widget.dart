import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/constants/ui_strings.dart';
import 'package:movies_app/core/providers/auth_provider.dart';
import 'package:movies_app/core/providers/form_switch_provider.dart';
import 'package:movies_app/models/enums/form_type.dart';
import 'package:movies_app/presentation/auth/view_model/signup_view_model.dart';
import 'package:movies_app/presentation/components/movie_input_field.dart';
import 'package:movies_app/presentation/components/movie_primary_button.dart';
import 'package:movies_app/presentation/components/movie_error_text.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({super.key});

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode repeatPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    passwordFocusNode.dispose();
    repeatPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(
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
            Consumer<SignupViewModel>(
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
            Consumer<SignupViewModel>(
              builder: (context, viewModel, _) => MovieInputField(
                controller: passwordController,
                label: UIStrings.passwordLabel,
                obscure: true,
                errorText: viewModel.formErrors['password'],
                focusNode: passwordFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(repeatPasswordFocusNode);
                },
              ),
            ),
            const SizedBox(height: 16),
            Consumer<SignupViewModel>(
              builder: (context, viewModel, _) => MovieInputField(
                controller: repeatPasswordController,
                label: UIStrings.repeatPasswordLabel,
                obscure: true,
                errorText: viewModel.formErrors['repeatPassword'],
                focusNode: repeatPasswordFocusNode,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  viewModel.validateAndSignup(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                    repeatPasswordController.text.trim(),
                    () {
                      debugPrint("Signup success");
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Consumer<SignupViewModel>(
              builder: (context, viewModel, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (viewModel.error != null) ...[
                      MovieErrorText(viewModel.error!),
                      const SizedBox(height: 12),
                    ],
                    viewModel.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : MoviePrimaryButton(
                            label: UIStrings.createAccount,
                            isLoading: false,
                            onPressed: () {
                              viewModel.validateAndSignup(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                repeatPasswordController.text.trim(),
                                () {
                                  debugPrint("Signup success");
                                },
                              );
                            },
                          ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Provider.of<FormSwitchProvider>(context, listen: false)
                    .setFormType(FormType.login);
              },
              child: const Text(UIStrings.alreadyHaveAccount),
            ),
          ],
        ),
      ),
    );
  }
}
