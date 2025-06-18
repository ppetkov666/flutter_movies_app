import 'package:flutter/material.dart';
import 'package:movies_app/core/providers/auth_provider.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthProvider _authProvider;

  LoginViewModel(this._authProvider);

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> login(String email, String password, VoidCallback onSuccess) async {
    if (_isLoading) return; // prevent duplicate login calls

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authProvider.login(email, password);
    } catch (e) {
      _error = _friendlyError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _friendlyError(Object e) {
    // still in devellopment
    return e.toString().replaceFirst('Exception: ', '');
  }
}
