import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/single_lecture_screen.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/widgets/lecture_card.dart';
import 'package:delta_team/features/Home_welcome_mobile/menu_navigation_screen.dart';
import 'package:delta_team/features/auth/login/loadingScreens/loadingscreen_mobile.dart';

import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../onboarding/onboarding_mobile/mobile_widgets/custom_footer_mobile.dart';
import '../welcoming_message_screen.dart';

class LecturesScreen extends StatefulWidget {
  final String role;
  const LecturesScreen({super.key, required this.role});

  @override
  State<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  bool _isBurgerIcon = true;
  @override
  void initState() {
    super.initState();
    getUserLectures();
  }

  Map<String, dynamic> lectures = {};
  Future<Map<String, dynamic>> getUserLectures() async {
    // signInUser();
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
      // responseMap.forEach((key, value) {
      //   print("$key: $value");
      // });
      // prin(responseMap.values);
      return responseMap;
    } on ApiException catch (e) {
      throw Exception('Failed to load lectures: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context).size;
    print(widget.role);
    List<Map<String, dynamic>> lecs = [];
    if (lectures.isNotEmpty) {
      List<dynamic> lecturesList = lectures["lectures"];
      for (int i = 0; i < lecturesList.length; i++) {
        Map<String, dynamic> lecture = lecturesList[i];
        print(lecture);
        dynamic role = lecture['roles'];
        if (role.toString().contains("backend") && widget.role == "backend") {
          lecs.add(lecture);
        }
        if (role.toString().contains("productManager") &&
            widget.role == "productManager") {
          lecs.add(lecture);
        }
        if (role.toString().contains("fullstack") &&
            widget.role == "fullstack") {
          lecs.add(lecture);
        }
        if (role.toString().contains("uiux") && widget.role == "uiux") {
          lecs.add(lecture);
        }
        if (role.toString().contains("qa") && widget.role == "qa") {
          lecs.add(lecture);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, WelcomingScreen.routeName2);
              },
              child: SvgPicture.asset("assets/images/appbar_logo.svg")),
        ),
        actions: [
          Padding(
            key: const Key('open_menu_burger_icon'),
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: _isBurgerIcon
                  ? const Icon(Icons.menu)
                  : const Icon(Icons.close),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  _isBurgerIcon = !_isBurgerIcon;
                });
              },
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _isBurgerIcon
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: lecs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, left: 32.0, right: 32.0),
                  child: GestureDetector(
                    key: const Key('onLectureClickKey'),
                    onTap: () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     content: Text('Lesson clicked!'),
                      //   ),
                      // );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SingleLectureScreen(lectures: lecs, index: index),
                        ),
                      );
                    },
                    child: LectureCard(
                      imageSrc: lecs[index]['imageSrc'],
                      name: lecs[index]['name'],
                    ),
                  ),
                );
              },
            )
          : const MyDrawer(),
      bottomNavigationBar: _isBurgerIcon ? const CustomFooter() : null,
    );
  }
}
