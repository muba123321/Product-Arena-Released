import 'package:flutter/material.dart';

class ErrorMessage with ChangeNotifier {
  String errorText = '';
  IconData? errorIcon;
  double errorHeight = 0;
  String get text => errorText;
  IconData? get icon => errorIcon;
  double get height => errorHeight;
  void change() {
    errorHeight = 30;
    errorText = 'Molimo popunite polje!';
    errorIcon = Icons.error_rounded;
    notifyListeners();
  }

  void reset() {
    errorHeight = 0;
    errorText = '';
    errorIcon = null;
    notifyListeners();
  }
}
