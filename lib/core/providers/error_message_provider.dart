import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/failure.dart';

class ErrorMessageProvider with ChangeNotifier {
  Failure? _modalError;
  String? _formError;

  Failure? get modalError => _modalError;

  String? get formError => _formError;

  void setModalError(Failure? error) {
    _modalError = error;
    notifyListeners();
  }
  // can be used in further implementation
  void setFormError(String? error) {
    _formError = error;
    notifyListeners();
  }

  // can be used in further implementationss
  void clearErrors() {
    _modalError = null;
    _formError = null;
    notifyListeners();
  }
}
