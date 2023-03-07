import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/login/login_web/loginweb_body.dart';

class LoadingPageOnboarding extends StatefulWidget {
  const LoadingPageOnboarding({super.key});

  @override
  State<LoadingPageOnboarding> createState() => _LoadingPageOnboardingState();
}

class _LoadingPageOnboardingState extends State<LoadingPageOnboarding> {
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 10);
    return Timer(duration, navigateToLogin);
  }

  navigateToLogin() {
    Navigator.pushNamed(context, LoginScreenWeb.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double ringSize = 150.0;
    double fontSize = 48;

    if (MediaQuery.of(context).size.width < 900) {
      ringSize = 120;
    }

    if (MediaQuery.of(context).size.width < 400) {
      fontSize = 36;
    }

    return Container(
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitRing(
            color: const Color.fromRGBO(34, 233, 116, 1),
            size: ringSize,
            lineWidth: 14,
          ),
          Text(
            "Loading...",
            style: GoogleFonts.notoSans(
                fontSize: fontSize,
                decoration: TextDecoration.none,
                color: Colors.black,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
