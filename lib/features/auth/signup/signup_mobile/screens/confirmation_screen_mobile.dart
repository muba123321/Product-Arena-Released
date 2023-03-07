import 'package:delta_team/features/auth/login/login_mobile/loginmobile_body.dart';
import 'package:delta_team/features/auth/signup/signup_mobile/widgets/confirmationContainers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../onboarding/onboarding_mobile/mobile_widgets/custom_footer_mobile.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset("assets/images/navbar_logo.svg",
            semanticsLabel: 'Confirmation SVG'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFE9E9E9),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Center(
                  child: Text("Just to be sure...",
                      style: GoogleFonts.outfit(fontSize: 32)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Center(
                  child: Text(
                    "We’ve sent a 6-digit code to your e-mail",
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: const Color.fromRGBO(96, 93, 102, 1),
                    ),
                    // style: TextStyle(
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: ConfirmationContainers(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.notoSans(
                          fontSize: 10, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, LoginScreenMobile.routeName);
                      },
                      key: const Key("loginKey"),
                      child: Text(
                        'Log in',
                        style: GoogleFonts.notoSans(
                            fontSize: 10, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 152,
              ),
              SvgPicture.asset("assets/images/footer_logo.svg",
                  semanticsLabel: 'Confirmation SVG'),
              const SizedBox(
                height: 38,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomFooter(),
    );
  }
}
