import 'package:flutter/material.dart';

class SelectedRoleProvider with ChangeNotifier {
  String _role = '';

  String get getRole => _role;

  void setRole(String role) {
    _role = role;
    notifyListeners();
  }
}
