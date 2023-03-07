import 'package:flutter/material.dart';

class UserAttributesProviderMobile with ChangeNotifier {
  String name = '';
  String surname = '';
  String email = '';

  void setName(String userName) {
    name = userName;
    notifyListeners();
  }

  void setSurname(String userSurname) {
    surname = userSurname;
    notifyListeners();
  }

  void setEmail(String userEmail) {
    email = userEmail;
    notifyListeners();
  }
}
