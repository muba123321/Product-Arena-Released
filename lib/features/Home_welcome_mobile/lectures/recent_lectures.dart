import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/providers/lectures_provider_mobile.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/single_lecture_screen.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/widgets/detailed_lecture.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../auth/login/loadingScreens/loadingscreen_mobile.dart';
import '../../onboarding/onboarding_mobile/mobile_widgets/custom_footer_mobile.dart';
import '../menu_navigation_screen.dart';
import '../welcoming_message_screen.dart';

class RecentLecturesMobile extends StatefulWidget {
  const RecentLecturesMobile({super.key});

  @override
  State<RecentLecturesMobile> createState() => _RecentLecturesMobileState();
}

class _RecentLecturesMobileState extends State<RecentLecturesMobile> {
  bool _isBurgerIcon = true;
  @override
  void initState() {
    super.initState();
    getUserLectures();
    print("recent" + recentLectures.toString());
    print("recent" + lectures.toString());
  }

  List recentLectures = [];
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

      // responseMap.forEach((key, value) {
      //   print("$key: $value");
      // });
      // prin(responseMap.values);

      setState(() {
        lectures = responseMap;
      });
      return responseMap;
    } on ApiException catch (e) {
      throw Exception('Failed to load lectures: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context).size;
    String role = "";
    List<Map<String, dynamic>> lecs = [];
    if (lectures.isNotEmpty) {
      List<dynamic> lecturesList = lectures["lectures"];
      for (int i = 0; i < 3; i++) {
        Map<String, dynamic> lecture = lecturesList[i];
        lecs.add(lecture);
      }
    }
    print(lectures.toString());
    print(recentLectures.toString());
    print(lecs.toString());

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
          ? SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 32.0, right: 32.0, top: 12.0),
                  child: Column(
                    children: [
                      Text(
                        'Recent Lessons',
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      lectures.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              height: mediaQuery.height * 0.90,
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: lecs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // final lectures = lecs[index];
                                  // final name = lectures['name'];
                                  // final image = lectures['imageSrc'];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SingleLectureScreen(
                                                  lectures: lecs, index: index),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            border: Border.all(width: 0.5)),
                                        child: Column(
                                          children: [
                                            //Video Player

                                            SizedBox(
                                              width: mediaQuery.width * 0.8,
                                              height: mediaQuery.height * 0.2,
                                              child: Image.network(
                                                lecs[index]['imageSrc'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              width: mediaQuery.width * 0.4,
                                              alignment: Alignment.topLeft,
                                              padding: const EdgeInsets.only(
                                                left: 7,
                                                top: 5,
                                              ),
                                              child: Text(
                                                lecs[index]['name'],
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      const Color(0xFF000000),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: mediaQuery.width * 0.1,
                                              alignment: Alignment.topRight,
                                              padding: const EdgeInsets.only(
                                                left: 7,
                                                top: 5,
                                              ),
                                              child: SvgPicture.asset(
                                                  'assets/images/arrow_lecture.svg'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Container(
                                    height: 15,
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            )
          : const MyDrawer(),
      bottomNavigationBar: _isBurgerIcon ? const CustomFooter() : null,
    );
  }
}
