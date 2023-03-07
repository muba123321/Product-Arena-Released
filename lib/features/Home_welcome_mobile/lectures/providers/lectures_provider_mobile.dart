// import 'dart:convert';

// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:flutter/material.dart';

// class LectureListProvider extends ChangeNotifier {
 

//  List<Map<String, dynamic>> lecs = [];
//     if (lectures.isNotEmpty) {
//       List<dynamic> lecturesList = lectures["lectures"];
//       for (int i = 0; i < lecturesList.length; i++) {
//         Map<String, dynamic> lecture = lecturesList[i];
//         print(lecture);
//         dynamic role = lecture['roles'];
//         if (role.toString().contains("backend") && widget.role == "backend") {
//           lecs.add(lecture);
//         }
//         if (role.toString().contains("productManager") &&
//             widget.role == "productManager") {
//           lecs.add(lecture);
//         }
//         if (role.toString().contains("fullstack") &&
//             widget.role == "fullstack") {
//           lecs.add(lecture);
//         }
//         if (role.toString().contains("uiux") && widget.role == "uiux") {
//           lecs.add(lecture);
//         }
//         if (role.toString().contains("qa") && widget.role == "qa") {
//           lecs.add(lecture);
//         }
//       }
//     }
// }
