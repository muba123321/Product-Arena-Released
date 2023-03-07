import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/common/appbar_web.dart';
import 'package:delta_team/common/custom_button.dart';

import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:delta_team/features/auth/signup/provider/Web_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/footer/footer.dart';
import '../../../onboarding_web/provider/emailPasswProvider.dart';

class SignupVerificationScreen extends StatefulWidget {
  static const routeName = '/confirmationWeb';
  const SignupVerificationScreen({super.key});

  @override
  State<SignupVerificationScreen> createState() =>
      _SignupVerificationScreenState();
}

class _SignupVerificationScreenState extends State<SignupVerificationScreen> {
  final _code1 = TextEditingController();
  final _code2 = TextEditingController();
  final _code3 = TextEditingController();
  final _code4 = TextEditingController();
  final _code5 = TextEditingController();
  final _code6 = TextEditingController();
  final _emailVerificationKey = GlobalKey<FormState>();

  Color errorColor = Color.fromARGB(255, 255, 0, 0);

  bool isNumberCorrect = true;
  bool isPressed = true;
  bool codeError = false;
  bool canSendCode = true;
  bool notSendCodeAgainPressed = false;

  bool _loading = false;

  String code1Str = "";
  String code2Str = "";
  String code3Str = "";
  String code4Str = "";
  String code5Str = "";
  String code6Str = "";
  String code = "";

  //////
  Future<void> sendMessage(email) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Confirmation code resent. Check your email",
            style: GoogleFonts.notoSans(fontSize: 15, color: Colors.white),
          ),
        ),
      );
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

//////
  int counter = 20;
  int clickCounter = 0;

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  Future<void> signInUser(String email, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: email, // email of user
        password: password,
      );
      print('LOGGED IN');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  double? screenWidth;
  double? screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context).size.width;
    screenHeight ??= MediaQuery.of(context).size.height;
    final emailProvider = Provider.of<MyEmailWeb>(context, listen: false);

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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 31.0),
                child: Center(
                  child: Container(
                    width: 740,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: MediaQuery.of(context).size.width > 600
                          ? const EdgeInsets.symmetric(
                              horizontal: 80.0, vertical: 80.0)
                          : const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          SvgPicture.asset("assets/images/pA_logo_white.svg"),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              'Just to be sure...',
                              style: MediaQuery.of(context).size.width > 630
                                  ? const TextStyle(
                                      fontSize: 60, fontWeight: FontWeight.bold)
                                  : const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              'We’ve sent a 6-digit code to your e-mail',
                              style: MediaQuery.of(context).size.width > 630
                                  ? const TextStyle(
                                      fontSize: 32,
                                    )
                                  : const TextStyle(
                                      fontSize: 16,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _emailVerificationKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 40, left: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          key: const Key("code1Key"),
                                          onChanged: (value) {
                                            setState(() {
                                              code1Str = value;
                                            });

                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          controller: _code1,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 25),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    64, 61, 59, 1),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: codeError &&
                                                        isPressed &&
                                                        notSendCodeAgainPressed
                                                    ? errorColor
                                                    : Color.fromARGB(
                                                        255, 126, 116, 116),
                                              ),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                )
                                              : TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                ),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          key: const Key("code2Key"),
                                          onChanged: (value) {
                                            setState(() {
                                              code2Str = value;
                                            });

                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          controller: _code2,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 25),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    64, 61, 59, 1),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: codeError &&
                                                        isPressed &&
                                                        notSendCodeAgainPressed
                                                    ? errorColor
                                                    : const Color.fromARGB(
                                                        255, 121, 116, 126),
                                              ),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                )
                                              : TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                ),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          key: const Key("code3Key"),
                                          onChanged: (value) {
                                            setState(() {
                                              code3Str = value;
                                            });

                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          controller: _code3,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 25),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    64, 61, 59, 1),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: codeError &&
                                                        isPressed &&
                                                        notSendCodeAgainPressed
                                                    ? errorColor
                                                    : const Color.fromARGB(
                                                        255, 121, 116, 126),
                                              ),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                )
                                              : TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                ),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          key: const Key("code4Key"),
                                          onChanged: (value) {
                                            setState(() {
                                              code4Str = value;
                                            });

                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          controller: _code4,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 25),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    64, 61, 59, 1),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: codeError &&
                                                        isPressed &&
                                                        notSendCodeAgainPressed
                                                    ? errorColor
                                                    : const Color.fromARGB(
                                                        255, 121, 116, 126),
                                              ),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                )
                                              : TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                ),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          key: const Key("code5Key"),
                                          controller: _code5,
                                          onChanged: (value) {
                                            setState(() {
                                              code5Str = value;
                                            });

                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 25),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    64, 61, 59, 1),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: codeError &&
                                                        isPressed &&
                                                        notSendCodeAgainPressed
                                                    ? errorColor
                                                    : const Color.fromARGB(
                                                        255, 121, 116, 126),
                                              ),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                )
                                              : TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                ),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          key: const Key("code6Key"),
                                          onChanged: (value) {
                                            setState(() {
                                              code6Str = value;
                                            });

                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          controller: _code6,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 25),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    64, 61, 59, 1),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                color: codeError &&
                                                        isPressed &&
                                                        notSendCodeAgainPressed
                                                    ? errorColor
                                                    : const Color.fromARGB(
                                                        255, 121, 116, 126),
                                              ),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                )
                                              : TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: codeError &&
                                                          isPressed &&
                                                          notSendCodeAgainPressed
                                                      ? errorColor
                                                      : const Color.fromARGB(
                                                          255, 121, 116, 126),
                                                ),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 1),
                                  codeError
                                      ? const Padding(
                                          padding: EdgeInsets.only(top: 25),
                                          child: Text(
                                            "Conformation code does not match",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.red),
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 1,
                                        ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  _loading
                                      ? const Center(
                                          child: SpinKitRing(
                                            color: Colors.black,
                                            size: 36,
                                            lineWidth: 6,
                                          ),
                                        )
                                      : ElevatedButton(
                                          key: const Key(
                                              "verifyConfirmationKey"),
                                          onPressed: () async {
                                            if (clickCounter == 0) {
                                              _startTimer();
                                            }
                                            setState(() {
                                              notSendCodeAgainPressed = true;
                                            });
                                            setState(() {
                                              clickCounter++;
                                              isPressed = true;
                                              code = "";
                                              code += code1Str +
                                                  code2Str +
                                                  code3Str +
                                                  code4Str +
                                                  code5Str +
                                                  code6Str;
                                            });
                                            if (code.length < 6) {
                                              setState(() {
                                                codeError = true;
                                              });
                                            }

                                            if (_emailVerificationKey
                                                .currentState!
                                                .validate()) {
                                              try {
                                                setState(() {
                                                  _loading = true;
                                                });
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                final String? password = prefs
                                                    .getString("password_pref");
                                                final String? email = prefs
                                                    .getString("email_pref");

                                                final result = await Amplify
                                                        .Auth
                                                    .confirmSignUp(
                                                        username: email!,
                                                        confirmationCode: code);

                                                setState(() {
                                                  codeError =
                                                      !result.isSignUpComplete;
                                                  _loading = false;
                                                });

                                                if (!codeError) {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();

                                                  await signInUser(
                                                      email, password!);

                                                  Navigator.pushReplacementNamed(
                                                      context,
                                                      '/confirmationMessageWeb');
                                                }
                                              } on AuthException catch (e) {
                                                setState(() {
                                                  codeError = true;
                                                  _loading = false;
                                                });
                                                // if (e.message.toString().contains(
                                                //         "Confirmation code entered is not correct.") ||
                                                //     e.message.toString().contains(
                                                //         "One or more parameters are incorrect.")) {
                                                //   setState(() {
                                                //     codeError = true;
                                                //   });
                                                // } else {
                                                //   setState(() {
                                                //     codeError = false;
                                                //   });
                                                // }
                                              }
                                              setState(() {
                                                _loading = false;
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            minimumSize:
                                                const Size(double.infinity, 56),
                                          ),
                                          child: Text(
                                            "Verify",
                                            style: GoogleFonts.notoSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  codeError && isPressed
                                      ? Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            InkWell(
                                              key: const Key('sendCodeAgain'),
                                              onDoubleTap: () async {
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                final String? email = prefs
                                                    .getString("email_pref");
                                                if (counter == 0 && codeError) {
                                                  setState(() {
                                                    counter = 20;
                                                    notSendCodeAgainPressed =
                                                        false;
                                                    canSendCode = true;
                                                  });

                                                  _startTimer();
                                                } else if (counter == 0) {
                                                  setState(() {
                                                    canSendCode = true;
                                                    notSendCodeAgainPressed =
                                                        false;
                                                  });
                                                } else if (counter != 0) {
                                                  setState(() {
                                                    canSendCode = false;
                                                    notSendCodeAgainPressed =
                                                        true;
                                                  });
                                                }
                                                if (canSendCode) {
                                                  _code1.clear();
                                                  _code2.clear();
                                                  _code3.clear();
                                                  _code4.clear();
                                                  _code5.clear();
                                                  _code6.clear();
                                                  sendMessage(email);
                                                  // sendMessage(
                                                  //     emailProvider.email);
                                                }
                                              },
                                              onTap: () async {
                                                if (counter == 0 && codeError) {
                                                  setState(() {
                                                    counter = 20;
                                                    notSendCodeAgainPressed =
                                                        false;
                                                    canSendCode = true;
                                                  });

                                                  _startTimer();
                                                } else if (counter == 0) {
                                                  setState(() {
                                                    canSendCode = true;
                                                    notSendCodeAgainPressed =
                                                        false;
                                                  });
                                                } else if (counter != 0) {
                                                  setState(() {
                                                    canSendCode = false;
                                                    notSendCodeAgainPressed =
                                                        true;
                                                  });
                                                }
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                final String? email = prefs
                                                    .getString("email_pref");

                                                if (canSendCode) {
                                                  _code1.clear();
                                                  _code2.clear();
                                                  _code3.clear();
                                                  _code4.clear();
                                                  _code5.clear();
                                                  _code6.clear();

                                                  // sendMessage(
                                                  //     emailProvider.email);
                                                  sendMessage(email);
                                                }
                                              },
                                              child: Text(
                                                "Send code again",
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w700,
                                                  color: const Color.fromRGBO(
                                                      96, 93, 102, 1),
                                                ),
                                              ),
                                            ),
                                            counter > 9
                                                ? Text(
                                                    " 00:$counter",
                                                    style: GoogleFonts.notoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          const Color.fromRGBO(
                                                              96, 93, 102, 1),
                                                    ),
                                                  )
                                                : Text(
                                                    " 00:0$counter",
                                                    style: GoogleFonts.notoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          const Color.fromRGBO(
                                                              96, 93, 102, 1),
                                                    ),
                                                  ),
                                          ],
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
