import 'package:delta_team/common/colors.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/widgets/detailed_lecture.dart';
import 'package:delta_team/features/Home_welcome_mobile/lectures/widgets/lecture_indicator.dart';

import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_widgets/form_buttons_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/login/loadingScreens/loadingscreen_mobile.dart';
import '../../onboarding/onboarding_mobile/mobile_widgets/custom_footer_mobile.dart';
import '../menu_navigation_screen.dart';
import '../welcoming_message_screen.dart';

class SingleLectureScreen extends StatefulWidget {
  final List<Map<String, dynamic>> lectures;
  final int index;

  const SingleLectureScreen({
    super.key,
    required this.lectures,
    required this.index,
  });

  @override
  State<SingleLectureScreen> createState() => _SingleLectureScreenState();
}

class _SingleLectureScreenState extends State<SingleLectureScreen> {
  bool _isBurgerIcon = true;
  final PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    // getUserLectures();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final mediaQuery = MediaQuery.of(context).size;

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
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      LectureIndicator(
                        currentPage: currentIndex,
                        lenght: widget.lectures.length,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: widget.lectures.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                height: mediaQuery.height * 0.90,
                                child: PageView.builder(
                                  controller: pageController,
                                  itemCount: widget.lectures.length,
                                  onPageChanged: (index) {
                                    setState(
                                      () {
                                        currentIndex = index;
                                      },
                                    );
                                  },
                                  //     itemBuilder: (BuildContext context, int index) {
                                  //   return pages[index % pages.length];
                                  // },
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return DetailedLecture(
                                      name: widget.lectures[index]['name'],
                                      contentLink: widget.lectures[index]
                                          ['contentLink'],
                                      description: widget.lectures[index]
                                          ['description'],
                                      index: currentIndex,
                                    );
                                  },
                                ),
                              ),
                      ),
                      Container(
                        alignment: const Alignment(0, 0.90),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            currentIndex == 0
                                ? const SizedBox(height: 0, width: 0)
                                : FormButton(
                                    key: const Key('lecturesBackButton'),
                                    backgroundColor: AppColors.secondaryColor3,
                                    textColor: AppColors.primaryColor,
                                    text: 'Back',
                                    borderColor: AppColors.primaryColor,
                                    onPressed: () {
                                      pageController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 400),
                                          curve: Curves.easeIn);
                                    },
                                    buttonWidth: 100,
                                    buttonHeight: 42,
                                  ),
                            // currentIndex == widget.lectures
                            // ? const SizedBox(height: 0, width: 0)
                            // :
                            FormButton(
                              key: const Key('lecturesNextButton'),
                              backgroundColor: AppColors.primaryColor,
                              textColor: AppColors.secondaryColor3,
                              text: 'Next',
                              borderColor: AppColors.primaryColor,
                              onPressed: () {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeIn);
                              },
                              buttonWidth: 100,
                              buttonHeight: 42,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const MyDrawer(),
        bottomNavigationBar: _isBurgerIcon ? const CustomFooter() : null);
  }
}
