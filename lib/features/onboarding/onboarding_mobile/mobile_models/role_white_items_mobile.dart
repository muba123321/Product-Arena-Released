// class RoleWhite {
//   final String idWhite;
//   final String imageWhite;
//   RoleWhite(this.idWhite, this.imageWhite);
// }

// List<RoleWhite> listaRolaWhite = [
//   RoleWhite('QA Engineering', 'assets/images/qa_white.svg'),
//   RoleWhite('Project Management', 'assets/images/manager_white.svg'),
//   RoleWhite('Backend', 'assets/images/backend_white.svg'),
//   RoleWhite('UI/UX Design', 'assets/images/designer_white.svg'),
//   RoleWhite('Full Stack Developer', 'assets/images/fullstack_white.svg')
// ];

import 'package:flutter/material.dart';

class RoleWhite {
  final String idWhite;
  final String imageWhite;

  // ignore: non_constant_identifier_names
  RoleWhite(this.idWhite, this.imageWhite);
}

List<RoleWhite> listaRoleWhite = [
  RoleWhite('qa', 'assets/images/qa_white.svg'),
  RoleWhite('productManager', 'assets/images/manager_white.svg'),
  RoleWhite('backend', 'assets/images/backend_white.svg'),
  RoleWhite('uiux', 'assets/images/designer_white.svg'),
  RoleWhite('fullstack', 'assets/images/fullstack_white.svg'),
];
