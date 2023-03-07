import 'package:delta_team/home_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/footer/footer.dart';
import '../../../auth/login/loadingScreens/loadingscreen_mobile.dart';
import '../../../auth/login/login_mobile/loginmobile_body.dart';
import '../../../onboarding/onboarding_mobile/welcome_page_mobile.dart';
import 'custom_footer_mobile.dart';

class Onboardingredirecting extends StatefulWidget {
  const Onboardingredirecting({super.key});

  @override
  State<Onboardingredirecting> createState() => _OnboardingredirectingState();
}

class _OnboardingredirectingState extends State<Onboardingredirecting> {
  @override
  void initState() {
    super.initState();
    navigateToWelcomePage(context);
  }

  navigateToWelcomePage(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const LoginScreenMobile();
      }), ((route) {
        return false;
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              const SizedBox(
                height: 74.9,
              ),
              SizedBox(
                height: 61.26,
                width: 80,
                child: SvgPicture.asset('assets/images/footer_logo.svg'),
              ),
              const SizedBox(height: 138.74),
              Stack(alignment: Alignment.center, children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            text: "We're",
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF000000),
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "brewing up",
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF000000),
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: SpinKitRing(
                    color: const Color(0xFF22E974),
                    size: (150.0 / 360) * width,
                    lineWidth: (12.0 / 360) * width,
                  ),
                )
              ]),
              const SizedBox(
                height: 245,
              ),
            ])),
      ),
      bottomNavigationBar: const CustomFooter(),
    );
  }
}
