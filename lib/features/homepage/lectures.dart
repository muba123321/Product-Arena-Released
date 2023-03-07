import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/homepage/homepage_sidebar.dart';
import 'package:delta_team/features/homepage/provider/selectedRoleProvider.dart';
import 'package:delta_team/features/homepage/provider/youtube_link_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../amplifyconfiguration.dart';
import '../auth/login/providers/userLecturesProvider.dart';
import 'account_modal.dart';

class LecturesPage extends StatefulWidget {
  const LecturesPage({super.key});

  @override
  State<LecturesPage> createState() => _LecturesPageState();
}

class _LecturesPageState extends State<LecturesPage> {
  @override
  void initState() {
    super.initState();

    _loadPrefs();
  }

  bool showModal = false;
  Map<String, dynamic> lectures = {};
  String selectedRole = "";

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final lecturesString = prefs.getString('lecturesPrefs');
    final role = prefs.getString("role");
    setState(() {
      lectures = json.decode(lecturesString!);
      selectedRole = role!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedRoleProvider =
        Provider.of<SelectedRoleProvider>(context, listen: false);

    bool removeDescription = false;
    if (MediaQuery.of(context).size.width < 970) {
      removeDescription = true;
    }
    final youtubeProvider =
        Provider.of<YoutubeLinkProvider>(context, listen: false);
    List<Map<String, dynamic>> lecs = [];
    if (lectures.isNotEmpty) {
      List<dynamic> lecturesList = lectures["lectures"];

      for (int i = 0; i < lecturesList.length; i++) {
        Map<String, dynamic> lecture = lecturesList[i];
        dynamic role = lecture['roles'];

        if (role.toString().contains("backend") && selectedRole == "backend") {
          lecs.add(lecture);
        }
        if (role.toString().contains("productManager") &&
            selectedRole == "productManager") {
          lecs.add(lecture);
        }
        if (role.toString().contains("fullstack") &&
            selectedRole == "fullstack") {
          lecs.add(lecture);
        }
        if (role.toString().contains("uiux") && selectedRole == "uiux") {
          lecs.add(lecture);
        }
        if (role.toString().contains("qa") && selectedRole == "qa") {
          lecs.add(lecture);
        }
      }
    }

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
          SizedBox(
            width: smallScreensSidebar
                ? MediaQuery.of(context).size.width
                : sizebarWidthWhite,
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      smallScreensSidebar
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
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            bottom: 30,
                          ),
                          child: !removeDescription
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: lecs.length,
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                    child: Text(
                                                      "${index + 1}. ${lecs[index]['name']}",
                                                      style: GoogleFonts.outfit(
                                                          fontSize: 32),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 27,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.32,
                                                    child: Text(
                                                      lecs[index]
                                                          ['description'],
                                                      style:
                                                          GoogleFonts.notoSans(
                                                              fontSize: 16),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 100,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Total time: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "23:17",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Remaining time: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "12:14",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Status: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "Ongoing",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              key:
                                                  const Key("lectureVideo_key"),
                                              onTap: () async {
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                await prefs.setString('title',
                                                    lecs[index]['name']);
                                                await prefs.setInt(
                                                    'index', index);
                                                await prefs.setString(
                                                    'description',
                                                    lecs[index]['description']);
                                                if (lecs[index]
                                                        ['contentLink'] !=
                                                    null) {
                                                  int milliseconds = DateTime
                                                          .now()
                                                      .millisecondsSinceEpoch;
                                                  print(milliseconds);
                                                  await prefs.setString(
                                                      'ytLink',
                                                      YoutubePlayer
                                                          .convertUrlToId(lecs[
                                                                  index][
                                                              'contentLink'])!);
                                                  youtubeProvider.setLink(
                                                      YoutubePlayer
                                                          .convertUrlToId(lecs[
                                                                  index][
                                                              'contentLink'])!);
                                                }
                                                Navigator.pushNamed(
                                                    context, '/homepagevideo');
                                              },
                                              child: Image.network(
                                                lecs[index]['imageSrc'],
                                                width: 280,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          color:
                                              Color.fromRGBO(202, 196, 208, 1),
                                        ),
                                      ],
                                    );
                                  }),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 60,
                                    );
                                  },
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: lecs.length,
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                    child: Text(
                                                      "${index + 1}. ${lecs[index]['name']}",
                                                      style: GoogleFonts.outfit(
                                                          fontSize: 32),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 27,
                                                  ),
                                                  InkWell(
                                                    key: const Key(
                                                        "lectureVideo_key2"),
                                                    onTap: () async {
                                                      final prefs =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      await prefs.setString(
                                                          'title',
                                                          lecs[index]['name']);
                                                      await prefs.setInt(
                                                          'index', index);
                                                      await prefs.setString(
                                                          'description',
                                                          lecs[index]
                                                              ['description']);
                                                      if (lecs[index]
                                                              ['contentLink'] !=
                                                          null) {
                                                        await prefs.setString(
                                                            'ytLink',
                                                            YoutubePlayer
                                                                .convertUrlToId(
                                                                    lecs[index][
                                                                        'contentLink'])!);
                                                        youtubeProvider.setLink(
                                                            YoutubePlayer
                                                                .convertUrlToId(
                                                                    lecs[index][
                                                                        'contentLink'])!);
                                                      }

                                                      Navigator.pushNamed(
                                                          context,
                                                          '/homepagevideo');
                                                    },
                                                    child: Image.network(
                                                      lecs[index]['imageSrc'],
                                                      width: 280,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 100,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Total time: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "23:17",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Remaining time: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "12:14",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Status: ",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Text(
                                                            "Ongoing",
                                                            style: GoogleFonts
                                                                .notoSans(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          color:
                                              Color.fromRGBO(202, 196, 208, 1),
                                        ),
                                      ],
                                    );
                                  }),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 60,
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                  !showModal ? Container() : const AccountModal(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
