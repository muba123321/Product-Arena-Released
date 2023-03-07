import 'dart:async';

import 'package:delta_team/common/appbar_web.dart';
import 'package:delta_team/common/custom_button.dart';

import 'package:delta_team/features/auth/login/loadingScreens/loadingscreen_web.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:delta_team/features/onboarding/onboarding_web/onboardingScreen.dart';

import '../../../../common/footer/footer.dart';
import 'Web_loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailVerifiedScreen extends StatefulWidget {
  const EmailVerifiedScreen({super.key});

  @override
  State<EmailVerifiedScreen> createState() => _EmailVerifiedScreenState();
}

class _EmailVerifiedScreenState extends State<EmailVerifiedScreen> {
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigateToloading);
  }

  navigateToloading() {
    Navigator.pushNamed(context, '/loadingPageSignup');
  }

  double? screenWidth;
  double? screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context).size.width;
    screenHeight ??= MediaQuery.of(context).size.height;
    // Timer(
    //   const Duration(seconds: 5),
    //   () => //Navigator.pushNamed(context, HomeScreenWeb.routeName));
    //       Navigator.pushNamed(context, '/loadingPageSignup'),
    // );

    return Scaffold(
      appBar: CustomAppBar(
          title: 'Tech387',
          leading: SvgPicture.asset('assets/images/logo.svg'),
          action: RoundedButton(
            key: const Key('LoginPage'),
            text: 'Login',
            press: () async {
              Navigator.pushNamed(context, LoginScreenWeb.routeName);
            },
            color: const Color(0xFF000000),
            textColor: Colors.white,
            borderColor: Colors.black,
            borderSide: const BorderSide(width: 1, color: Color(0xFF000000)),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/paBackground.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  height: 464,
                  width: 740,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Padding(
                    padding: MediaQuery.of(context).size.width > 630
                        ? const EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 80.0)
                        : const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        SvgPicture.asset("assets/images/check_circle.svg"),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Email verified',
                            style: MediaQuery.of(context).size.width > 630
                                ? const TextStyle(
                                    fontSize: 60, fontWeight: FontWeight.bold)
                                : const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Your email is successfully verified',
                            style: MediaQuery.of(context).size.width > 630
                                ? const TextStyle(
                                    fontSize: 32,
                                  )
                                : const TextStyle(
                                    fontSize: 16,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
