import 'package:flutter/material.dart';

class CurrentPage extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  setCurrentPage(int val) {
    _currentPage = val;
    notifyListeners();
  }
}
