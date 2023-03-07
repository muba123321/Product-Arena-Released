import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'modelRole.dart';

//PROVIDER
class MyItemWeb with ChangeNotifier {
  List<String> myItems = [];
  // var imeRole = [];

  int get length => myItems.length;
  List<String> get selectedList => myItems;

//dodaj u niz rolu
  void add(Role role) {
    myItems.add(role.id);
    // imeRole.add(role.text);
    // print(imeRole);
    print(myItems);
    notifyListeners();
    // print(imeRole.length);
  }

//izbrisi iz niza rolu
  void remove(Role role) {
    myItems.remove(role.id);
    // imeRole.remove(role.text);
    notifyListeners();
  }
  // provjeri da li vec ima ta rola u nizu

  bool hasRole(Role role) {
    return myItems.where((element) => element == role.id).isNotEmpty;
  }
}
