import 'package:delta_team/features/Home_welcome_mobile/menu_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../onboarding/onboarding_mobile/mobile_widgets/custom_footer_mobile.dart';

class WelcomingScreen extends StatefulWidget {
  static const routeName2 = '/welcome_screen';
  const WelcomingScreen({super.key});
  @override
  State<WelcomingScreen> createState() => _WelcomingScreenState();
}

class _WelcomingScreenState extends State<WelcomingScreen> {
  bool _isBurgerIcon = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset("assets/images/appbar_logo.svg"),
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
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Color.fromRGBO(238, 233, 233, 1),
                    child: Center(
                      child: Column(
                        key: const Key('home_welcome_mesagge'),
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          SvgPicture.asset("assets/images/UX.svg"),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "Welcome to",
                            style: TextStyle(fontSize: 32),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Product Arena",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Our goal is to recognise persistence,\nmotivation and adaptability, that’s why we\n encourage you to dive into these materials\n and wish you the best of luck in your\n studies.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Once you have gone through all the lessons\n you'll be able to take a test to show us what\n you have learned!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 108,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const MyDrawer(),
      bottomNavigationBar: const CustomFooter(),
    );
  }
}
