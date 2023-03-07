import 'package:flutter/material.dart';

class RoleWhite {
  final String idWhite;
  final String imageWhite;

  // ignore: non_constant_identifier_names
  RoleWhite(this.idWhite, this.imageWhite);
}

List<RoleWhite> listaRolaWhite = [
  RoleWhite('qa', '../assets/images/qaBijela.png'),
  RoleWhite('productManager', '../assets/images/managerBijela.png'),
  RoleWhite('backend', '../assets/images/backendBijela.png'),
  RoleWhite('uiux', '../assets/images/uiuxBijela.png'),
  RoleWhite('fullstack', '../assets/images/fullstackBijela.png'),
];
