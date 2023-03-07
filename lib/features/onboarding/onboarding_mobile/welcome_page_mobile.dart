import 'package:delta_team/common/colors.dart';
import 'package:delta_team/features/auth/login/login_mobile/loginmobile_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mobile_widgets/custom_footer_mobile.dart';
import 'onboarding_screen_mobile.dart';

class WelcomePage extends StatefulWidget {
  static const routeName = 'welcome-screen';

  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset("assets/images/navbar_logo.svg",
            semanticsLabel: 'Confirmation SVG'),
      ),
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            // height: mediaQuery.size.height * 0.82,
            width: double.infinity,
            color: AppColors.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 200,
                  // height: mediaQuery.size.height * 0.16,
                ),
                RichText(
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Dobrodošli!\n',
                    style: GoogleFonts.notoSans(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.backgroundColor),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'Pred Vama je mali upitnik, koji je\nneophodno popuniti kako bi\n nastavili dalje.',
                        style: GoogleFonts.notoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.backgroundColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 240,
                  // height: mediaQuery.size.height * 0.16,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ne zaboravite da odvojite vrijeme i pažljivo\npročitajte svako pitanje. Sretno!',
                        style: GoogleFonts.notoSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.backgroundColor),
                        textAlign: TextAlign.center,
                      ),
                      MaterialButton(
                        key: const Key('NavigateToLoginButtonKey'),
                        child: SvgPicture.asset(
                            'assets/images/arrow_forward_24px.svg'),
                        // Image.asset('assets/images/arrow_forward_24px.svg'),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, OnboardingScreen.routeName);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomFooter(),
    );
  }
}
