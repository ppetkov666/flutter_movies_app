import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/core/providers/error_message_provider.dart';
import 'package:movies_app/domain/entities/failure.dart';
import 'package:provider/provider.dart';

class QueryExecutor {
  static Future<T?> safeExecute<T>(
      BuildContext context,
      Future<T> Function() task, {
        bool showError = true,
      }) async {
    try {
      return await task();
    } on FirebaseAuthException catch (e) {
      if (showError) {
        reportError(context, 'Auth error: ${e.message}');
      }
    } on SocketException {
      if (showError) {
        reportError(context, 'No internet connection.');
      }
    } on FormatException {
      if (showError) {
        reportError(context, 'Bad response format.');
      }
    } catch (e) {
      if (showError) {
        reportError(context, 'Unexpected error: $e');
      }
    }

    return null;
  }

  static void reportError(BuildContext context, String message) {
    Provider.of<ErrorMessageProvider>(context, listen: false).setModalError(
      Failure(message: message),
    );
  }
}
