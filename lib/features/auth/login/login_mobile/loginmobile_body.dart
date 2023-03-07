import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/login/loadingScreens/loadingscreen_mobile.dart';
import 'package:delta_team/features/auth/login/amplify_auth.dart';
import 'package:delta_team/features/auth/login/login_web/loginform_web.dart';
import 'package:delta_team/features/auth/login/login_mobile/loginform_mobile.dart';

import 'package:delta_team/home_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:riverpod_extension/riverpod_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../onboarding/onboarding_mobile/mobile_widgets/custom_footer_mobile.dart';

class LoginScreenMobile extends StatefulWidget {
  static const routeName = '/loginmobile';
  const LoginScreenMobile({super.key});

  @override
  _LoginScreenMobileState createState() => _LoginScreenMobileState();
}

class _LoginScreenMobileState extends State<LoginScreenMobile> {
  // TextEditingController username = TextEditingController();
  // TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // bool passwordObscured = true;
  String errorMessage = '';

  // void togglePasswordObscure() {
  //   setState(() {
  //     passwordObscured = !passwordObscured;
  //   });
  // }

  //   setState(() {
  // }

  Future<void> usersignIn(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Incorrect email or password';
      });
    } else {
      try {
        final result =
            await Amplify.Auth.signIn(username: email, password: password);
        if (result.isSignedIn) {
          // Navigator.pushNamed(context, LoadingScreenMobile.routeName);
        }
      } on AuthException catch (error) {
        setState(() {
          errorMessage = error.message;
        });
      } on HttpException catch (e) {
        final response = e.response;
        if (response.statusCode == 400) {
          setState(() {
            errorMessage = 'Please enter a valid email or password';
          });
        } else {
          setState(() {
            errorMessage = 'Sign in failed';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset("assets/images/navbar_logo.svg",
            semanticsLabel: 'Confirmation SVG'),
      ),
      backgroundColor: const Color(0xFFE9E9E9),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Welcome to',
                                style: GoogleFonts.notoSans(
                                  fontSize: 32.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Product Arena',
                          style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 32.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 128.0),
                  Form(
                      key: _formKey,
                      child: SizedBox(
                        width: (296 / 360) * width,
                        child: Column(
                          children: [
                            const LoginFieldMobile(),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(children: [
                                    Text(
                                      'Don’t you have an account?',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF000000),
                                        fontSize: 10.0,
                                      ),
                                    )
                                  ]),
                                  GestureDetector(
                                    key: const Key('SignUp'),
                                    onTap: () async {
                                      Navigator.pushNamed(context, "/signup");
                                    },
                                    child: Text(
                                      ' Sign up',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF000000),
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 185,
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [SvgPicture.asset("assets/images/tech387.svg")],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomFooter(),
    );
  }
}
