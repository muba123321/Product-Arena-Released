import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/login/login_mobile/providers/userAttributesProviderMobile.dart';
import 'package:delta_team/features/auth/login/login_mobile/providers/userLecturesProviderMobile.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../loadingScreens/loadingscreen_mobile.dart';

class LoginFieldMobile extends StatefulWidget {
  // final IconData suffixIcon;

  const LoginFieldMobile({
    super.key,

    // required this.suffixIcon
  });

  @override
  State<LoginFieldMobile> createState() => _LoginFieldMobileState();
}

class _LoginFieldMobileState extends State<LoginFieldMobile> {
  bool _showPasswordSuffixIcon = false;
  bool viewPassword = false;
  bool showErrorIcon = false;
  String errorMessage = '';
  bool emailNotExist = true;
  bool canLogIn = false;
  bool _isFocusedPassword = false;
  bool _isFocusedEmail = false;
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _signInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color labelEmailColor = const Color(0xFF605D66);
  Color labelPasswordColor = const Color(0xFF605D66);
  Color eyelid = const Color(0xFF000000);
  Color labelEmailFocusColor = const Color(0xFF22E974);
  Color labelPasswordFocusColor = const Color(0xFF22E974);

  @override
  void dispose() {
    // Dispose the focus node when the widget is removed from the widget tree
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // Add a listener to the focus node to update the _isFocused variable
    _passwordFocusNode.addListener(() {
      setState(() {
        _isFocusedPassword = _passwordFocusNode.hasFocus;
      });
    });

    _emailFocusNode.addListener(() {
      setState(() {
        _isFocusedEmail = _emailFocusNode.hasFocus;
      });
    });
    super.initState();
  }

  Map<String, dynamic> lectures = {};
  bool _loading = false;

  Future<Map<String, dynamic>> getUserLectures() async {
    try {
      final restOperation = Amplify.API.get('/api/user/lectures',
          apiName: 'getUserLectures',
          queryParameters: {
            'paDate': 'Jan2023'
            // , 'name': 'Flutter widgets'
          });
      final response = await restOperation.response;

      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      setState(() {
        lectures = responseMap;
      });
      return responseMap;
    } on ApiException catch (e) {
      print(e.message);
      throw Exception('Failed to load lectures: $e');
    }
  }

  String nameUser = '';
  String email = '';

  String surname = '';

  Future<bool> logUserIn(String email, String password) async {
    try {
      setState(() {
        _loading = true;
      });
      final user =
          await Amplify.Auth.signIn(username: email, password: password);
      safePrint('successful');
      setState(() {
        _loading = false;
      });
      setState(() {
        canLogIn = user.isSignedIn;
      });
    } catch (error) {
      if (!error.toString().contains("UserNotFoundException") &&
          !error.toString().contains("underlyingException")) {
        setState(() {
          emailNotExist = true;
        });
      } else {
        setState(() {
          emailNotExist = false;
        });
      }
      setState(() {
        _loading = false;
      });
    }
    return false;
  }

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        // print('key: ${element.userAttributeKey}; value: ${element.value}');
        if (element.userAttributeKey.key == "email") {
          setState(() {
            email = element.value;
          });
        }
        if (element.userAttributeKey.key == "given_name") {
          setState(() {
            nameUser = element.value;
          });
        }
        if (element.userAttributeKey.key == "family_name") {
          setState(() {
            surname = element.value;
          });
        }
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAttributesProvider =
        Provider.of<UserAttributesProviderMobile>(context, listen: false);
    final userLecturesProvider =
        Provider.of<LecturesProviderMobile>(context, listen: false);
    bool emailErrored = false;
    bool passwordErrored = false;

    double width = MediaQuery.of(context).size.width;
    return Form(
      key: _signInKey,
      child: Column(
        children: [
          TextFormField(
            key: const Key("emailKey"),
            focusNode: _emailFocusNode,
            controller: emailController,
            style: GoogleFonts.notoSans(
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w700,
            ),
            // focusNode: _emailFocusNode,
            validator: (value) {
              if (value!.isEmpty) {
                setState(() {
                  showErrorIcon = true;
                  emailErrored = true;
                  labelEmailColor = const Color(0xFFB3261E);
                  labelEmailFocusColor = const Color(0xFFB3261E);
                });

                return 'Please fill the required field.';
              } else if ((!EmailValidator.validate(value) && !canLogIn) &&
                  passwordController.text.isNotEmpty) {
                setState(() {
                  labelEmailFocusColor = const Color(0xFFB3261E);
                  labelEmailColor = const Color(0xFFB3261E);
                  passwordErrored = true;
                  emailErrored = true;
                  showErrorIcon = true;
                  emailNotExist = false;
                });
                return '';
              } else if (!emailNotExist) {
                setState(() {
                  emailErrored = true;
                  showErrorIcon = true;
                  passwordErrored = true;
                  labelEmailColor = const Color(0xFFB3261E);
                  labelEmailFocusColor = const Color(0xFFB3261E);
                });
              }
              if (passwordController.text.isEmpty &&
                  emailController.text.isNotEmpty) {
                setState(() {
                  labelEmailColor = const Color(0xFF000000);
                });
              }

              if (canLogIn) {
                setState(() {
                  labelEmailColor = const Color(0xFF000000);
                  passwordErrored = false;
                  emailErrored = false;
                  showErrorIcon = false;
                });
                return null;
              }

              setState(() {
                emailErrored = false;
                showErrorIcon = false;
              });
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              filled: true,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF22E974)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: labelEmailColor),
              ),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF605D66))),
              label: Text(
                "Email",
                style: GoogleFonts.notoSans(
                    color: _isFocusedEmail
                        ? labelEmailFocusColor
                        : labelEmailColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              suffixIcon: showErrorIcon
                  ? const Icon(
                      Icons.error,
                      color: Color(0xFFB3261E),
                      size: 24,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            key: const Key("passwordKey"),
            focusNode: _passwordFocusNode,
            controller: passwordController,
            obscureText: !viewPassword,
            style: GoogleFonts.notoSans(
              color: const Color(0xFF000000),
              fontWeight: FontWeight.w700,
            ),
            onChanged: (value) {
              setState(() {
                _showPasswordSuffixIcon = value.isNotEmpty;
              });
            },
            validator: (value) {
              String regex =
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
              RegExp regExp = RegExp(regex);

              if (value!.isEmpty) {
                setState(() {
                  passwordErrored = true;
                  labelPasswordFocusColor = const Color(0xFFB3261E);
                  labelPasswordColor = const Color(0xFFB3261E);
                  eyelid = const Color(0xFFB3261E);
                });
                return 'Please fill the required field.';
              } else if ((!regExp.hasMatch(value) ||
                      emailErrored ||
                      !canLogIn) &&
                  emailController.text.isNotEmpty) {
                setState(() {
                  labelPasswordColor = const Color(0xFFB3261E);
                  eyelid = const Color(0xFFB3261E);
                  labelPasswordFocusColor = const Color(0xFFB3261E);
                  labelEmailColor = const Color(0xFFB3261E);
                  emailErrored = true;
                  passwordErrored = true;
                  showErrorIcon = true;
                });
                return "Incorrect email or password";
              } else {
                setState(() {
                  passwordErrored = false;
                });
              }
              if (emailController.text.isEmpty &&
                  passwordController.text.isNotEmpty) {
                setState(() {
                  labelPasswordColor = const Color(0xFF000000);
                  eyelid = const Color(0xFF000000);
                });
              }
              if (canLogIn || emailController.text.isNotEmpty) {
                safePrint("LOGIN");
                setState(() {
                  passwordErrored = false;
                  emailErrored = false;
                  showErrorIcon = false;
                });
                return null;
              }

              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF22E974)),
                ),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: labelEmailColor),
                ),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF605D66))),
                label: Text(
                  "Password",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: _isFocusedPassword
                        ? labelPasswordFocusColor
                        : labelPasswordColor,
                  ),
                ),
                suffixIcon: _showPasswordSuffixIcon
                    ? InkWell(
                        key: const Key("passwordVisible"),
                        child: Icon(
                            viewPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: eyelid),
                        onTap: () {
                          setState(() {
                            viewPassword = !viewPassword;
                          });
                        })
                    : null),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 40,
            width: (296 / 360) * width,
            child: _loading
                ? Center(
                    child: SpinKitRing(
                      color: Colors.black,
                      size: (36.0 / 360) * width,
                      lineWidth: (6.0 / 360) * width,
                    ),
                  )
                : ElevatedButton(
                    key: const Key('Login_Button'),
                    onPressed: () async {
                      await logUserIn(
                          emailController.text, passwordController.text);
                      if (_signInKey.currentState!.validate()) {
                        if (canLogIn) {
                          await getUserLectures();
                          await fetchCurrentUserAttributes();
                          userLecturesProvider.setLectures(lectures);
                          userAttributesProvider.setEmail(email);
                          userAttributesProvider.setName(nameUser);
                          userAttributesProvider.setSurname(surname);
                          safePrint('successful');
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return const LoadingScreenMobile();
                          }), ((route) {
                            return false;
                          }));

                          // Navigator.pushNamed(
                          //     context, LoadingScreenMobile.routeName);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF000000)),
                    child: Text(
                      "Login",
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: (14 / 360) * width,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
