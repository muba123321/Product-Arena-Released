import 'package:flutter/material.dart';

class ShowModal with ChangeNotifier {
  bool show = false;

  bool get isEnabled => show;

  void toggleModal() {
    show = !show;
    notifyListeners();
  }
}
