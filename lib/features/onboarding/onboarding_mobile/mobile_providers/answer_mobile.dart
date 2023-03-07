import 'package:flutter/material.dart';

class AnswerProvider with ChangeNotifier {
  List<String> _answers = [];
  int get length => _answers.length;

  List<String> get answ => _answers;

  void addItem(String item) {
    _answers.add(item);
    print(answ);
    notifyListeners();
  }
}
