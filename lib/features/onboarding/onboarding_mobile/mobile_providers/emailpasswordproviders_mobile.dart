import 'package:flutter/material.dart';

class EmailPasswordProviderMobile with ChangeNotifier {
  String password = '';
  String email = '';

  void setPassword(String newPassword) {
    password = newPassword;
    print(password);
    notifyListeners();
  }

  void setEmail(String userEmail) {
    email = userEmail;
    print(email);
    notifyListeners();
  }
}
