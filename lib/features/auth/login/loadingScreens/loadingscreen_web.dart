import 'package:delta_team/home_mobile.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoadingScreenWeb extends StatefulWidget {
  static const routeName = '/loadingweb';
  const LoadingScreenWeb({
    super.key,

    // required this.suffixIcon
  });

  @override
  _LoadingScreenWebState createState() => _LoadingScreenWebState();
}

class _LoadingScreenWebState extends State<LoadingScreenWeb> {
  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  startTimeout() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigateToHomeScreen);
  }

  navigateToHomeScreen() {
    Navigator.pushNamed(context, '/homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(
            //   height: 200,
            //   width: (200 / 1440) * width,
            //   child: Image.asset('assets/your_logo.png'),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            const SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFFFFFFFF),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF22E974)),
                strokeWidth: 15.0,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Loading...",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w400,
                color: const Color(0xFF000000),
                fontSize: 48.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
