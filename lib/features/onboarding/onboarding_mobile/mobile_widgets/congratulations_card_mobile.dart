// import 'dart:async';

// import 'package:flutter/material.dart';

// class CongratsCard extends StatelessWidget {
//   static const routeName = 'congrate';
//   const CongratsCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Timer(const Duration(seconds: 5),
//         () => Navigator.pushNamed(context, "/OnboardingredirectingScreen"));
//     return Card(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset('name'),
//           const Text('Congratulations'),
//           const Text('You’ve successfully created an account'),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/footer/footer.dart';
import '../../../auth/login/loadingScreens/loadingscreen_mobile.dart';
import 'custom_footer_mobile.dart';
import 'loading_Oboading mobile.dart';

class CongratsCard extends StatelessWidget {
  static const routeName = 'congrats-card';
  const CongratsCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const Onboardingredirecting();
            }), ((route) {
              return false;
            })));
    // Navigator.pushNamed(context, "/OnboardingredirectingScreen")

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset("assets/images/navbar_logo.svg",
            semanticsLabel: 'Confirmation SVG'),
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
                child: Container(
                  height: 187,
                  color: const Color(0xFFFFFFFF),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                      child: Column(
                        key: const Key('routed_to_homepage_from_onboarding'),
                        children: [
                          SvgPicture.asset(
                              "assets/images/check_circle_Onboard.svg",
                              semanticsLabel: 'Confirmation SVG'),
                          const SizedBox(
                            height: 21,
                          ),
                          Text(
                            "Congratulations",
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            "You’ve successfully created an account",
                            style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(96, 93, 102, 1)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 251,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomFooter(),
    );
  }
}
