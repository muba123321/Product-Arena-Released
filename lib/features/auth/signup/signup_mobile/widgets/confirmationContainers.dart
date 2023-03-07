import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:delta_team/features/auth/signup/provider/auth_provider_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../common/custom_signlog_button.dart';

class ConfirmationContainers extends StatefulWidget {
  const ConfirmationContainers({super.key});

  @override
  State<ConfirmationContainers> createState() => _ConfirmationContainersState();
}

class _ConfirmationContainersState extends State<ConfirmationContainers> {
  final _num1 = TextEditingController();
  final _num2 = TextEditingController();
  final _num3 = TextEditingController();
  final _num4 = TextEditingController();
  final _num5 = TextEditingController();
  final _num6 = TextEditingController();

  final _confirmationKey = GlobalKey<FormState>();

  Color errorColor = const Color.fromRGBO(179, 38, 30, 1);

  bool isNumberCorrect = true;
  bool isPressed = false;
  bool codeErrored = false;
  bool canSendCode = false;
  bool notSendCodeAgainPressed = false;

  String num1Str = "";
  String num2Str = "";
  String num3Str = "";
  String num4Str = "";
  String num5Str = "";
  String num6Str = "";
  String code = "";

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

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<MyEmail>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _confirmationKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 49,
                    width: 39,
                    child: TextFormField(
                      key: const Key("num1Key"),
                      controller: _num1,
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(64, 61, 59, 1),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: codeErrored &&
                                      isPressed &&
                                      notSendCodeAgainPressed
                                  ? errorColor
                                  : const Color.fromARGB(255, 121, 116, 126)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          num1Str = value;
                        });

                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 49,
                    width: 39,
                    child: TextFormField(
                      key: const Key("num2Key"),
                      controller: _num2,
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(64, 61, 59, 1),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: codeErrored &&
                                      isPressed &&
                                      notSendCodeAgainPressed
                                  ? errorColor
                                  : const Color.fromARGB(255, 121, 116, 126)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          num2Str = value;
                        });
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 49,
                    width: 39,
                    child: TextFormField(
                      key: const Key("num3Key"),
                      controller: _num3,
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(64, 61, 59, 1),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: codeErrored &&
                                      isPressed &&
                                      notSendCodeAgainPressed
                                  ? errorColor
                                  : const Color.fromARGB(255, 121, 116, 126)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          num3Str = value;
                        });
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 49,
                    width: 39,
                    child: TextFormField(
                      key: const Key("num4Key"),
                      controller: _num4,
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(64, 61, 59, 1),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: codeErrored &&
                                      isPressed &&
                                      notSendCodeAgainPressed
                                  ? errorColor
                                  : const Color.fromARGB(255, 121, 116, 126)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          num4Str = value;
                        });
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 49,
                    width: 39,
                    child: TextFormField(
                      key: const Key("num5Key"),
                      controller: _num5,
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(64, 61, 59, 1),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: codeErrored &&
                                      isPressed &&
                                      notSendCodeAgainPressed
                                  ? errorColor
                                  : const Color.fromARGB(255, 121, 116, 126)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          num5Str = value;
                        });
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 49,
                    width: 39,
                    child: TextFormField(
                      key: const Key("num6Key"),
                      controller: _num6,
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(64, 61, 59, 1),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: codeErrored &&
                                      isPressed &&
                                      notSendCodeAgainPressed
                                  ? errorColor
                                  : const Color.fromARGB(255, 121, 116, 126)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          num6Str = value;
                        });
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          codeErrored
              ? Text(
                  "Confirmation code does not match",
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: errorColor,
                  ),
                )
              : const SizedBox(
                  height: 16,
                ),
          const SizedBox(
            height: 36,
          ),
          !codeErrored
              ? const SizedBox(
                  height: 16,
                )
              : const SizedBox(
                  height: 26,
                ),
          codeErrored && isPressed
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      key: const Key('sendCodeAgain'),
                      onDoubleTap: () {
                        if (counter == 0 && codeErrored) {
                          setState(() {
                            counter = 20;
                            notSendCodeAgainPressed = false;
                            canSendCode = true;
                          });

                          _startTimer();
                        } else if (counter == 0) {
                          setState(() {
                            canSendCode = true;
                            notSendCodeAgainPressed = false;
                          });
                        } else if (counter != 0) {
                          setState(() {
                            canSendCode = false;
                            notSendCodeAgainPressed = true;
                          });
                        }
                        if (canSendCode) {
                          _num1.clear();
                          _num2.clear();
                          _num3.clear();
                          _num4.clear();
                          _num5.clear();
                          _num6.clear();
                          sendMessage(emailProvider.email);
                        }
                      },
                      onTap: () async {
                        if (counter == 0 && codeErrored) {
                          setState(() {
                            counter = 20;
                            notSendCodeAgainPressed = false;
                            canSendCode = true;
                          });

                          _startTimer();
                        } else if (counter == 0) {
                          setState(() {
                            canSendCode = true;
                            notSendCodeAgainPressed = false;
                          });
                        } else if (counter != 0) {
                          setState(() {
                            canSendCode = false;
                            notSendCodeAgainPressed = true;
                          });
                        }

                        if (canSendCode) {
                          _num1.clear();
                          _num2.clear();
                          _num3.clear();
                          _num4.clear();
                          _num5.clear();
                          _num6.clear();
                          sendMessage(emailProvider.email);
                        }
                      },
                      child: Text(
                        "Send code again",
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(96, 93, 102, 1),
                        ),
                      ),
                    ),
                    counter > 9
                        ? Text(
                            " 00:$counter",
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(96, 93, 102, 1),
                            ),
                          )
                        : Text(
                            " 00:0$counter",
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(96, 93, 102, 1),
                            ),
                          ),
                  ],
                )
              : Container(),
          const SizedBox(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: CustomButton(
              key: const Key("verifyConfirmationKey"),
              content: Text(
                "Verify",
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              buttonFunction: () async {
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
                  code +=
                      num1Str + num2Str + num3Str + num4Str + num5Str + num6Str;
                });

                if (_confirmationKey.currentState!.validate()) {
                  try {
                    final result = await Amplify.Auth.confirmSignUp(
                        username: emailProvider.email, confirmationCode: code);
                    setState(() {
                      codeErrored = !result.isSignUpComplete;
                    });
                    if (!codeErrored) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pushNamed(context, "/confirmationMessage");
                    }
                  } on AuthException catch (e) {
                    if (e.message.toString().contains(
                            "Confirmation code entered is not correct.") ||
                        e.message.toString().contains(
                            "One or more parameters are incorrect.")) {
                      setState(() {
                        codeErrored = true;
                      });
                    } else {
                      setState(() {
                        codeErrored = false;
                      });
                    }
                    safePrint(e.message);
                  }
                }
              },
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
