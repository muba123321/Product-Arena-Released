import 'dart:convert';

import 'package:amplify_core/amplify_core.dart';
import 'package:auth/auth.dart';
import 'package:delta_team/features/homepage/Navbar_homepage.dart';
import 'package:delta_team/features/homepage/account_modal.dart';
import 'package:delta_team/features/homepage/homepage_sidebar.dart';
import 'package:delta_team/features/homepage/provider/youtube_link_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HomePageVideoScreen extends StatefulWidget {
  const HomePageVideoScreen({super.key});

  @override
  State<HomePageVideoScreen> createState() => _HomePageVideoScreenState();
}

class _HomePageVideoScreenState extends State<HomePageVideoScreen> {
  String videoURL = "";
  String title = '';
  int numeration = -1;
  String description = '';
  bool showMore = false;
  bool showModal = false;

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

      // print(responseMap.values);
      return responseMap;
    } on ApiException catch (e) {
      throw Exception('Failed to load lectures: $e');
    }
  }

  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    final youtubeProvider =
        Provider.of<YoutubeLinkProvider>(context, listen: false);
    controller = YoutubePlayerController.fromVideoId(
      videoId: youtubeProvider.link,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      title = prefs.getString('title') ?? "";
      numeration = prefs.getInt('index') ?? -1;
      description = prefs.getString('description') ?? "";

      videoURL = prefs.getString('ytLink') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    bool increaseSidebar = false;
    double titleFont = 60;

    bool isShowMoreVisible = false;

    if (MediaQuery.of(context).size.width < 970) {
      increaseSidebar = true;
      titleFont = 36;
    }

    if (MediaQuery.of(context).size.width > 870) {
      isShowMoreVisible = true;
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
          SingleChildScrollView(
            child: SizedBox(
                width: smallScreensSidebar
                    ? MediaQuery.of(context).size.width
                    : sizebarWidthWhite,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Stack(
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            smallScreensSidebar
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 70, right: 70),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${numeration + 1}. $title",
                                        style: GoogleFonts.notoSans(
                                            fontSize: titleFont,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        height: showMore
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.65
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.555,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF3F3F9),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                            color: const Color(0xFFF3F3F9),
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    200, 180, 180, 180),
                                                blurRadius: 1,
                                                spreadRadius: 1.5,
                                                offset: Offset(0, 2)),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: YoutubePlayer(
                                                  key: const Key(
                                                      'ytPlayerManji'),
                                                  controller: controller,
                                                  aspectRatio: 16 / 9,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              isShowMoreVisible
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            text: 'Status: ',
                                                            style: GoogleFonts
                                                                .notoSans(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: 'Ongoing',
                                                                style: GoogleFonts
                                                                    .notoSans(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          key: const Key(
                                                              "show_more-less_key"),
                                                          onTap: () {
                                                            setState(() {
                                                              showMore =
                                                                  !showMore;
                                                            });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                !showMore
                                                                    ? 'Show More'
                                                                    : 'Show Less',
                                                                style: GoogleFonts
                                                                    .notoSans(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Icon(
                                                                showMore
                                                                    ? Icons
                                                                        .keyboard_arrow_up
                                                                    : Icons
                                                                        .keyboard_arrow_down,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Visibility(
                                                visible: showMore,
                                                child: Text(
                                                  description,
                                                  style: GoogleFonts.notoSans(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                      !showModal ? Container() : const AccountModal(),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
