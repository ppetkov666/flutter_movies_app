import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/core/providers/form_switch_provider.dart';
import 'package:movies_app/core/providers/error_message_provider.dart';
import 'package:movies_app/models/enums/form_type.dart';
import 'package:movies_app/presentation/auth/widgets/login_form_widget.dart';
import 'package:movies_app/presentation/auth/widgets/signup_form_widget.dart';
import 'package:movies_app/presentation/components/movie_error_modal.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormSwitchProvider(context)),
        ChangeNotifierProvider(create: (_) => ErrorMessageProvider()),
      ],
      child: const _AuthScreenContent(),
    );
  }
}

class _AuthScreenContent extends StatelessWidget {
  const _AuthScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Consumer<FormSwitchProvider>(
              builder: (_, formSwitch, __) {
                return formSwitch.type == FormType.login
                    ? const LoginFormWidget()
                    : const SignupFormWidget();
              },
            ),
            const MovieErrorModal(),
          ],
        ),
      ),
    );
  }
}
