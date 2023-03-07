import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/common/custom_signlog_button.dart';
import 'package:delta_team/features/Home_welcome_mobile/contact%20us/contact-us_mobile.dart';
import 'package:delta_team/features/Home_welcome_mobile/home_second_screen.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/lectures_screen.dart';
import 'package:delta_team/features/Home_welcome_mobile/recentLessonTest.dart';
import 'package:delta_team/features/homepage/recentLectures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../auth/login/amplify_auth.dart';
import '../auth/login/login_mobile/loginmobile_body.dart';
import 'contactUsTest.dart';
import 'lectures/recent_lectures.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isLoadingEmail = true;
  bool isLoadingRoles = true;
  List<String> roles = [];
  @override
  void initState() {
    super.initState();
    getUserAttributes();
    getUserRoles().then((value) {
      setState(() {
        roles = value;
        isLoadingRoles = false;
      });
      //Lecture count
      // getLectureCounts();
    });
  }

  Map<String, dynamic> lectures = {};
  Future<List<String>> getUserRoles() async {
    try {
      final restOperation = Amplify.API.get('/api/user/lectures',
          apiName: "getUserLectures", queryParameters: {'paDate': 'Jan2023'});
      final response = await restOperation.response;
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      setState(() {
        lectures = responseMap;
      });
      List<String> roles = [];
      responseMap['lectures'].forEach((lecture) {
        List<dynamic> lectureRoles = lecture['roles'];
        roles.addAll(lectureRoles.map((role) => role.toString()));
      });
      Set<String> set = Set<String>.from(roles);
      List<String> mergedArr = set.toList();
      return mergedArr;
    } on ApiException catch (e) {
      throw Exception('Failed to load roles: $e');
    }
  }

  String _userName = '';
  String _userEmail = '';
  void getUserAttributes() async {
    try {
      List<AuthUserAttribute> userAttributes =
          await Amplify.Auth.fetchUserAttributes();
      Map<String, String> attributeMap = {};
      userAttributes.forEach((attribute) {
        attributeMap[attribute.userAttributeKey.toJson()] = attribute.value;
        // print("this is atribute value : $attribute");
      });
      String email = attributeMap['email'] ?? '';
      String givenName = attributeMap['given_name'] ?? '';
      String familyName = attributeMap['family_name'] ?? '';
      // print(" this is atribute map$attributeMap");
      // print('attributeMap: $attributeMap');
      setState(() {
        _userEmail = email;
        _userName = '$givenName $familyName';
        isLoadingEmail = false;
      });
    } on AuthException catch (e) {
      print('Failed to fetch user attributes: ${e.message}');
    }
  }

  final Map<String, String> roleIcons = {
    'uiux': "assets/images/uiuxDesigner.svg",
    'fullstack': "assets/images/fullstackIcon.svg",
    'backend': "assets/images/backendIcon.svg",
    "productManager": "assets/images/projMengIcon.svg",
    "qa": "assets/images/qaIcon.svg",
    // add more mappings as needed
  };
  bool isSelected = false;
  String? selectedRole;
  bool isSelectedRecentLessons = false;
  bool isSelectedContactUs = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: Drawer(
        shadowColor: Colors.black,
        child: Container(
          color: Colors.black,
          child: isLoadingEmail == false && isLoadingRoles == false
              ? ListView(
                  children: <Widget>[
                    const SizedBox(
                      height: 17,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            key: const Key('user_fullname'),
                            _userName,
                            style: const TextStyle(
                                color: Color.fromRGBO(34, 233, 116, 1),
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/images/user-line.svg"),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                key: const Key('user_email'),
                                _userEmail,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  "assets/images/uiuxDesigner.svg"),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "2/22 Lessons",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                      endIndent: 18,
                      indent: 18,
                    ),
                    for (var role in roles)
                      Padding(
                        key: const Key('user_roles'),
                        padding: const EdgeInsets.only(left: 21),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = true;
                              selectedRole = role;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LecturesScreen(
                                        role: role,
                                      )),
                            ).then((value) {
                              setState(() {
                                isSelected = false;
                                selectedRole = null;
                              });
                            });
                            print(role);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                roleIcons[role]!,
                                width: 19,
                                height: 19,
                              ),
                              const SizedBox(
                                width: 10,
                                height: 55,
                              ),
                              Text(
                                role == "fullstack"
                                    ? "Fulstack Development"
                                    : role == "backend"
                                        ? "Backend Development"
                                        : role == "uiux"
                                            ? "UI/UX Design"
                                            : role == "productMenager"
                                                ? "Project Management"
                                                : role == "qa"
                                                    ? "Quality Assurance"
                                                    : role,
                                style: TextStyle(
                                  color: isSelected && selectedRole == role
                                      ? Color.fromRGBO(34, 233, 116, 1)
                                      : Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/recent-lesson.svg",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            key: const Key('open_recent_lessonScreen'),
                            onTap: () {
                              setState(() {
                                isSelectedRecentLessons = true;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RecentLecturesMobile()),
                              ).then((value) {
                                setState(() {
                                  isSelectedRecentLessons = false;
                                });
                              });
                            },
                            child: Text(
                              "Recent Lessons",
                              style: TextStyle(
                                color: isSelectedRecentLessons
                                    ? Color.fromRGBO(34, 233, 116, 1)
                                    : Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 35),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/Vector.svg"),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            key: const Key('open_contacUs_screen'),
                            onTap: () {
                              setState(() {
                                isSelectedContactUs = true;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ContactMobile()),
                              ).then((value) {
                                setState(() {
                                  isSelectedContactUs = false;
                                });
                              });
                            },
                            child: Text(
                              "Contact us",
                              style: TextStyle(
                                color: isSelectedContactUs
                                    ? Color.fromRGBO(34, 233, 116, 1)
                                    : Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    Center(
                      child: ElevatedButton(
                        key: const Key('logout_user'),
                        onPressed: () async {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pop();
                            try {
                              signOutCurrentUser(null, null, context);
                              safePrint('User Signed Out');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginScreenMobile(),
                                ),
                              );
                            } on AmplifyException catch (e) {
                              print(e.message);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                        child: const Text(
                          "Log out",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(34, 233, 116, 1),
                  ),
                ),
        ),
      ),
    );
  }
}
