class FormErrors {
  final Map<String, String?> _errors = {};

  String? operator [](String field) => _errors[field];

  void setError(String field, String? message) {
    if (message == null) {
      _errors.remove(field);
    } else {
      _errors[field] = message;
    }
  }

  bool get hasErrors => _errors.isNotEmpty;

  void clear() => _errors.clear();
}
