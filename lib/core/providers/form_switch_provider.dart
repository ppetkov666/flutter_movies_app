import 'package:flutter/material.dart';
import 'package:movies_app/models/enums/form_type.dart';

class FormSwitchProvider extends ChangeNotifier {
  FormType type = FormType.login;

  final BuildContext context;

  FormSwitchProvider(this.context);

  void setFormType(FormType newType) {
    type = newType;
    notifyListeners();
  }
}
