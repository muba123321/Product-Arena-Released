import 'package:flutter/material.dart';

class TitleProvider extends ChangeNotifier {
  List<String> _titles = [];

  List<String> get titles => _titles;

  void addTitle(String title) {
    _titles.add(title);
    notifyListeners();
  }
}
