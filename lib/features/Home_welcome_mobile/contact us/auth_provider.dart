import 'package:flutter/material.dart';

class AuthProviderContact with ChangeNotifier {
  String name = '';
  String email = '';

  void setName(String userName) {
    name = userName;
    notifyListeners();
  }

  void setEmail(String userEmail) {
    email = userEmail;
    notifyListeners();
  }

  // Add the rest of the necessary functions here
}
