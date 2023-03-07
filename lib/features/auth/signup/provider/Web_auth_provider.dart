import 'package:flutter/material.dart';

class MyEmailWeb with ChangeNotifier {
  String _email = '';

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }
}
