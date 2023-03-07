import 'package:flutter/material.dart';

class LecturesProvider extends ChangeNotifier {
  Map<String, dynamic> _lectures = {};

  Map<String, dynamic> get lectures => _lectures;

  void setLectures(Map<String, dynamic> value) {
    _lectures = value;
    notifyListeners();
  }
}
