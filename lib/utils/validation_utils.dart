import 'package:cloud_firestore/cloud_firestore.dart';

class ValidationUtils {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  static String friendlyError(Object e) {
    if (e is FirebaseException) {
      return e.message ?? 'An error occurred';
    } else if (e is Exception) {
      return e.toString().replaceFirst('Exception: ', '');
    } else {
      return 'An unexpected error occurred';
    }
  }

}
