import 'package:flutter/material.dart';

class EmailPasswordProvider with ChangeNotifier {
  String password = '';
  String email = '';

  void setPassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  void setEmail(String userEmail) {
    email = userEmail;
    notifyListeners();
  }
}
