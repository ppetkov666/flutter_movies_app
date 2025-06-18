import 'package:flutter/material.dart';
import 'package:movies_app/core/providers/auth_provider.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthProvider _authProvider;

  SignupViewModel(this._authProvider);

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> signup(String email, String password, VoidCallback onSuccess) async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authProvider.signUp(email, password);
      onSuccess();
    } catch (e) {
      _error = _friendlyError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _friendlyError(Object e) {
    return e.toString().replaceFirst('Exception: ', '');
  }
}
