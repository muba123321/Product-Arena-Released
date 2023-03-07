import 'package:flutter/material.dart';

//KLASA ZA ROLE MODEL
class Role {
  final String id;
  final String image;

  Role(this.id, this.image);
}

List<Role> listaRola = [
  Role('qa', '../assets/images/qa.png'),
  Role('productManager', '../assets/images/manager.png'),
  Role('backend', '../assets/images/backend.png'),
  Role('uiux', '../assets/images/uiux.png'),
  Role('fullstack', '../assets/images/fullstack.png'),
];
