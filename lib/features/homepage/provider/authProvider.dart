import 'package:flutter/material.dart';

class ContactWeb with ChangeNotifier {
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
}
