import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/common/appbar_web.dart';
import 'package:delta_team/common/custom_button.dart';

import 'package:delta_team/features/auth/login/login_web/loginform_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_extension/riverpod_extension.dart';

import '../../../../common/footer/footer.dart';
import '../loadingScreens/loadingscreen_web.dart';

class LoginScreenWeb extends StatefulWidget {
  static const routeName = '/loginmobileWeb';
  const LoginScreenWeb({Key? key}) : super(key: key);

  @override
  LoginScreenWebState createState() => LoginScreenWebState();
}

class LoginScreenWebState extends State<LoginScreenWeb> {
  final ScrollController _controller = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _controller.offset; //Getting current position
    if (event.logicalKey.debugName == "Arrow Down") {
      setState(() {
        if (kReleaseMode) {
          //This block only runs when the application was compiled in release mode.
          _controller.animateTo(offset + 50,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        } else {
          // This will only print useful information in debug mode.
          // print(_controller.position); to get information..
          _controller.animateTo(offset + 50,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey.debugName == "Arrow Up") {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset - 50,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        } else {
          _controller.animateTo(offset - 50,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        }
      });
    }
  }

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

  FutureOr<bool> usersignIn(
      BuildContext context, String email, String password) async {
    try {
      final result =
          await Amplify.Auth.signIn(username: email, password: password);
      if (result.isSignedIn) {
        safePrint('User Logged In');
        Navigator.pushNamed(context, LoadingScreenWeb.routeName);
        return true;
      }
    } on AuthException catch (error) {
      setState(() {
        errorMessage = error.message;
      });
      safePrint(errorMessage);

      return false;
    } on HttpException catch (e) {
      final response = e.response;
      if (response.statusCode == 400) {
        setState(() {
          errorMessage = 'Please enter a valid email or password';
        });
        return false;
      } else {
        setState(() {
          errorMessage = 'Sign in failed';
        });
        return false;
      }
    }
    setState(() {
      errorMessage = 'Sign in failed';
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Tech387',
          leading: SvgPicture.asset('assets/images/logo.svg'),
          action: RoundedButton(
            key: const Key('SignUpPage_homepage'),
            text: 'Sign Up',
            press: () async {
              Navigator.pushNamed(context, '/signupWeb');
            },
            color: const Color(0xFF000000),
            textColor: Colors.white,
            borderColor: Colors.black,
            borderSide: const BorderSide(width: 1, color: Color(0xFF000000)),
          )),
      backgroundColor: const Color(0xFFE9E9E9),
      body: RawKeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              SizedBox(
                  height: 965,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 185,
                      ),
                      SvgPicture.asset(
                        'assets/images/logotop.svg',
                        width: ((99.7 / 1440) * width).clamp(50, 100),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Welcome to',
                                style: GoogleFonts.notoSans(
                                  fontSize: ((48 / 1440) * width).clamp(38, 48),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Product Arena',
                                style: GoogleFonts.notoSans(
                                  fontSize: ((48 / 1440) * width).clamp(38, 48),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                )),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'All great things take time to accomplish',
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF605D66),
                            fontSize: ((48 / 1440) * width).clamp(16, 32),
                          ),
                        ),
                      ),
                      const SizedBox(height: 75.0),
                      Form(
                        key: _formKey,
                        child: SizedBox(
                          // height: 228,
                          width: (452 / 1440) * width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                LoginField(),
                              ]),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 38,
              ),
              const Footer()
            ],
          ),
        ),
      ),
    );
  }
}
