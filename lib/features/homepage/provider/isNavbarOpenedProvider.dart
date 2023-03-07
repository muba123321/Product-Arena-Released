import 'package:flutter/material.dart';

class NavbarOpened with ChangeNotifier {
  bool _isOpened = false;

  bool get getIsOpenedNavbar => _isOpened;

  void toggleIsOpenned() {
    _isOpened = !_isOpened;
    notifyListeners();
  }
}
