import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  String _value = "";
  String answerQuestion2 = "";

  String get value => _value;
  String get answer2 => answerQuestion2;

  set value(String value) {
    _value = value;
    notifyListeners();
  }

  set answer2(String value) {
    answerQuestion2 = value;
    notifyListeners();
  }
}
