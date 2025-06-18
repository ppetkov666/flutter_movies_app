import 'package:flutter/material.dart';
import 'package:movies_app/core/providers/auth_provider.dart';
import 'package:movies_app/utils/form_errors.dart';
import 'package:movies_app/utils/validation_utils.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthProvider _authProvider;

  SignupViewModel(this._authProvider);

  final FormErrors formErrors = FormErrors();

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void validateAndSignup(
      String email,
      String password,
      String repeatPassword,
      VoidCallback onSuccess,
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

    if (repeatPassword.isEmpty) {
      formErrors.setError('repeatPassword', 'Repeat password is required');
    } else if (password != repeatPassword) {
      formErrors.setError('repeatPassword', 'Passwords do not match');
    }

    notifyListeners();

    if (!formErrors.hasErrors) {
      signup(email, password, onSuccess);
    }
  }

  Future<void> signup(
      String email,
      String password,
      VoidCallback onSuccess,
      ) async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authProvider.signUp(email, password);
      onSuccess();
    } catch (e) {
      _error = ValidationUtils.friendlyError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
