import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/footer/footer.dart';

class CongratsCardWeb extends StatelessWidget {
  static const routeName = 'congrats-cardWeb';
  const CongratsCardWeb({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Timer(const Duration(seconds: 7),
        () => Navigator.pushNamed(context, '/loadingOnboarding'));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: SvgPicture.asset('assets/images/logo.svg')),
        leadingWidth: (170 / 1440) * width,
        title: const Text(
          'Tech387',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 252,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/images/check_circle_Onboard.svg",
                          semanticsLabel: 'Confirmation SVG',
                          height: 120,
                          width: (120 / 1440) * width,
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        Text(
                          "Congratulations",
                          style: GoogleFonts.outfit(
                            fontSize: (60 / 1440) * width,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "You’ve successfully created an account",
                          style: GoogleFonts.outfit(
                              fontSize: (32 / 1440) * width,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(96, 93, 102, 1)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 251,
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
