import 'dart:convert';

import 'package:amplify_core/amplify_core.dart';
import 'package:delta_team/features/homepage/account_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login/login_web/loginweb_body.dart';
import 'homepage_sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showModal = false;
  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  String selectedRole = "";
  dynamic token = "";

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role');
    dynamic strToken = await FlutterSession().get("token");

    setState(() {
      token = strToken;
      selectedRole = role!;
    });
  }

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
    bool removePhoto = false;

    double sizebarWidthBlack = MediaQuery.of(context).size.width * 0.25;
    double sizebarWidthWhite = MediaQuery.of(context).size.width * 0.75;

    bool smallScreensSidebar = false;

    if (MediaQuery.of(context).size.width < 650) {
      setState(() {
        smallScreensSidebar = true;
      });
    }

    if (MediaQuery.of(context).size.width < 970) {
      sizebarWidthBlack = MediaQuery.of(context).size.width * 0.35;
      sizebarWidthWhite = MediaQuery.of(context).size.width * 0.65;
      removePhoto = true;
    }

    return Scaffold(
      body: Row(
        children: [
          !smallScreensSidebar
              ? Container(
                  color: Colors.black,
                  width: sizebarWidthBlack,
                  child: const Sidebar())
              : Container(),
          SingleChildScrollView(
            child: Container(
              width: smallScreensSidebar
                  ? MediaQuery.of(context).size.width
                  : sizebarWidthWhite,
              color: Colors.white,
              child: Stack(
                children: [
                  Column(children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, right: 50, left: 50),
                      child: smallScreensSidebar
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  key: const Key("user_menu_key"),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/homepage_sidebar');
                                  },
                                  child: const Icon(
                                    Icons.menu,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  key: const Key("user_icon_key"),
                                  onTap: () {
                                    setState(() {
                                      showModal = !showModal;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.account_circle_rounded,
                                    color: Colors.green,
                                    size: 50,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  key: const Key("user_icon_key1"),
                                  onTap: () {
                                    setState(() {
                                      showModal = !showModal;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.account_circle_rounded,
                                    color: Colors.green,
                                    size: 50,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    //container za sliku profile
                    Padding(
                      padding: EdgeInsets.only(
                        left: (950 / 1440) * MediaQuery.of(context).size.width,
                        top: 30,
                      ),
                      // child: Container(
                      //   color: Colors.red,
                      //   child: Image.asset('assets/images/homepageui.png'),
                      // ),
                    ),

                    //container za sliku koja trci
                    removePhoto
                        ? Column(
                            children: const [
                              Text(
                                'Welcome to',
                                style: TextStyle(fontSize: 45),
                              ),
                              Text(
                                'Product Arena',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 50),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.252,
                                  height: MediaQuery.of(context).size.height *
                                      0.235,
                                  child: Image.asset(
                                      'assets/images/homepageui.png'),
                                ),
                              ),
                              Column(
                                children: const [
                                  Text(
                                    'Welcome to',
                                    style: TextStyle(fontSize: 45),
                                  ),
                                  Text(
                                    'Product Arena',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50),
                                  )
                                ],
                              ),
                            ],
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right:
                              (90 / 1440) * MediaQuery.of(context).size.width),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.437,
                        child: const Text(
                          'Our goal is to recognise persistence, motivation and adaptability, thats why we encourage you to dive into these materials and wish you the best of luck in your studies.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right:
                              (90 / 1440) * MediaQuery.of(context).size.width),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: const Text(
                          'Once you have gone through all the lessons you ll be able to take a test to show us what you have learned!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, fontFamily: 'Outfit'),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left:
                              (400 / 1440) * MediaQuery.of(context).size.width),
                      child: Image.asset('assets/images/homepageqa.png'),
                    ),
                  ]),
                  !showModal ? Container() : const AccountModal(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
