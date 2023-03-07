import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YoutubeLinkProvider with ChangeNotifier {
  String link = "";

  String get urlLink => link;

  void setLink(String url) {
    link = url;
    notifyListeners();
  }
}
