import 'package:flutter/material.dart';

class LoginProviderAuth with ChangeNotifier {
  String name = '';
  String surname = '';
  String email = '';

  void setName(String userName) {
    name = userName;
    notifyListeners();
  }

  void setSurname(String userSurname) {
    name = userSurname;
    notifyListeners();
  }

  void setEmail(String userEmail) {
    email = userEmail;
    notifyListeners();
  }
}
