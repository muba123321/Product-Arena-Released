import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/homepage/Navbar_homepage.dart';
import 'package:delta_team/features/homepage/homepage_sidebar.dart';
import 'package:delta_team/features/homepage/homescreen.dart';
import 'package:flutter/material.dart';

import '../auth/login/loadingScreens/loadingscreen_web.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // getUserLectures();
  }

  Map<String, dynamic> lectures = {};
  List varijablaRola = [];
  bool _loading = false;

  Future<Map<String, dynamic>> getUserLectures() async {
    setState(() {
      _loading = true;
    });
    try {
      final restOperation = Amplify.API.get('/api/user/lectures',
          apiName: 'getUserLectures',
          queryParameters: {
            'paDate': 'Jan2023'
            // , 'name': 'Flutter widgets'
          });
      final response = await restOperation.response;

      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());

      setState(() {
        lectures = responseMap;
      });

      List temp = [];
      responseMap['lectures'].forEach((lecture) {
        temp.addAll(lecture['roles']);
      });

      Set<String> set = Set<String>.from(temp);
      List<String> roles = set.toList();

      setState(() {
        varijablaRola = roles;
        _loading = false;
      });

      // responseMap.forEach((key, value) {
      //   print("$key: $value");
      // });

      // print(responseMap.values);
      return responseMap;
    } on ApiException catch (e) {
      throw Exception('Failed to load lectures: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? const LoadingScreenWeb() : const HomeScreen();
  }
}
