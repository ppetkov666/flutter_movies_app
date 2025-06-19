import 'package:flutter/material.dart';
import 'package:movies_app/core/providers/auth_provider.dart';
import 'package:movies_app/core/utils/query_executor.dart';
import 'package:movies_app/utils/form_errors.dart';
import 'package:movies_app/utils/validation_utils.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthProvider _authProvider;

  LoginViewModel(this._authProvider);

  final FormErrors formErrors = FormErrors();

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void validateAndLogin(
      String email,
      String password,
      VoidCallback onSuccess,
      BuildContext context,
      ) {
    formErrors.clear();

    if (email.isEmpty) {
      formErrors.setError('email', 'Email is required');
    } else if (!ValidationUtils.isValidEmail(email)) {
      formErrors.setError('email', 'Enter a valid email');
    }

    if (password.isEmpty) {
      formErrors.setError('password', 'Password is required');
    } else if (password.length < 6) {
      formErrors.setError('password', 'Password must be at least 6 characters');
    }

    notifyListeners();

    if (!formErrors.hasErrors) {
      login(email, password, onSuccess, context);
    }
  }

  Future<void> login(
      String email,
      String password,
      VoidCallback onSuccess,
      BuildContext context,
      ) async {
    if (_isLoading) return; // Prevent duplicate login calls

    _isLoading = true;
    _error = null;
    notifyListeners();

    await QueryExecutor.safeExecute(context, () async {
      await _authProvider.login(email, password);
      onSuccess();
    });

    _isLoading = false;
    notifyListeners();
  }
}
