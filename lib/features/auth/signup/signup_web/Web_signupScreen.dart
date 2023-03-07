// ignore: file_names
import 'package:delta_team/common/appbar_web.dart';
import 'package:delta_team/common/custom_button.dart';

import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:delta_team/features/onboarding_web/provider/emailPasswProvider.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'dart:math';
// ignore: unused_import
import 'package:amplify_authenticator/amplify_authenticator.dart';

import 'package:delta_team/features/auth/signup/provider/Web_auth_provider.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';

import '../../../../common/footer/footer.dart';

// import 'package:amplify_api/amplify_api.dart';
// import 'package:masked_text_input_formatter/masked_text_input_formatter.dart';

class SignUpScreenWeb extends StatefulWidget {
  const SignUpScreenWeb({super.key});

  @override
  State<SignUpScreenWeb> createState() => _SignUpScreenWebState();
}

class _SignUpScreenWebState extends State<SignUpScreenWeb> {
  double fontSize = 48;
  bool isButtonPressed = false;
  bool _loading = false;

  // Future<bool> userExist(String email) async {
  //   try {
  //     await Amplify.Auth.signIn(
  //       username: email,
  //       password: "12345678",
  //     );
  //   } catch (error) {
  //     if (!error.toString().contains("NotAuthorizedException")) {
  //       setState(() {
  //         isEmailTaken = true;
  //       });
  //     } else {
  //       setState(() {
  //         isEmailTaken = false;
  //       });
  //     }
  //     return true;
  //   }
  //   return false;
  // }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _statusValue;
  List<String> statusList = [
    'Student',
    'Employed',
    'Unemployed',
  ];

  final _signupFormKey = GlobalKey<FormState>();
  bool nameErrored = false;
  bool _passwordVisible = false;
  bool statusErrored = false;

  bool _isEmailCorrect = true;

  bool isSignUpCompleted = false;
  bool isEmailTaken = false;

  void changeScreen() {
    if (isSignUpCompleted) {
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.pushNamed(context, "/confirmation");
    }
  }

  initState() {
    _passwordVisible = false;
  }

  RegExp pass_valid = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$');

  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  final phoneMaskFormatter = MaskTextInputFormatter(mask: "+############");
  final dateMaskFormatter = MaskTextInputFormatter(mask: "##/##/####");

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 310) {
      fontSize = 26;
    }
    final emailProvider = Provider.of<MyEmailWeb>(context, listen: false);
    final emailPasswordProvider =
        Provider.of<EmailPasswordProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            // SvgPicture.asset(
            //   "assets/images/paBackground.svg",
            //   semanticsLabel: 'Background image',
            // ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/paBackground.png'),
                  fit: BoxFit.fill,
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
                              horizontal: 110.0, vertical: 20.0)
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
                              'Welcome to',
                              style: MediaQuery.of(context).size.width > 600
                                  ? const TextStyle(
                                      fontSize: 48,
                                    )
                                  : const TextStyle(
                                      fontSize: 32,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              'Product Arena',
                              style: MediaQuery.of(context).size.width > 600
                                  ? const TextStyle(
                                      fontSize: 48, fontWeight: FontWeight.bold)
                                  : const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _signupFormKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 40, left: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          key: const Key("nameKey"),
                                          controller: nameController,
                                          validator: (value) {
                                            String pattern = r'^[a-zA-Z]+$';
                                            RegExp regExp = RegExp(pattern);
                                            if (value!.isEmpty) {
                                              setState(() {
                                                nameErrored = true;
                                              });
                                              return 'Please fill the required field.';
                                            } else if (!regExp
                                                .hasMatch(value)) {
                                              setState(() {
                                                nameErrored = true;
                                              });
                                              return 'Please enter valid name';
                                            }
                                            setState(() {
                                              nameErrored = false;
                                            });
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            label: Text("Name"),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Flexible(
                                        child: TextFormField(
                                          key: const Key("surnameKey"),
                                          controller: surnameController,
                                          validator: (value) {
                                            String pattern = r'^[a-zA-Z]+$';
                                            RegExp regExp = RegExp(pattern);
                                            if (value!.isEmpty) {
                                              setState(() {
                                                nameErrored = true;
                                              });
                                              return 'Please fill the required field.';
                                            } else if (!regExp
                                                .hasMatch(value)) {
                                              setState(() {
                                                nameErrored = true;
                                              });
                                              return 'Please enter valid surname';
                                            }
                                            setState(() {
                                              nameErrored = false;
                                            });
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            label: Text("Surname"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: birthDateController,
                                    keyboardType: TextInputType.datetime,
                                    key: const Key("birthDateKey"),
                                    inputFormatters: [
                                      dateMaskFormatter,
                                    ],
                                    onChanged: (value) {
                                      var year =
                                          int.tryParse(value.substring(6));
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please fill the required field.";
                                      }
                                      var day =
                                          int.tryParse(value.substring(0, 2));
                                      var month =
                                          int.tryParse(value.substring(3, 5));
                                      var year =
                                          int.tryParse(value.substring(6));
                                      if (day != null &&
                                          (day < 1 || day > 31)) {
                                        return "Please enter a valid day (1-31).";
                                      }
                                      if (month != null &&
                                          (month < 1 || month > 12)) {
                                        return "Please enter a valid month (1-12).";
                                      }
                                      if (year != null &&
                                          (year < 1900 || year > 2022)) {
                                        return "Please enter a valid year.";
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text("Birth date"),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  ////
                                  TextFormField(
                                    key: const Key("cityKey"),
                                    controller: cityController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please fill the required field.";
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text("City"),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
                                    key: const Key("statusKey"),
                                    hint: const Text('Status',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    value: _statusValue,
                                    validator: (value) {
                                      if (_statusValue == null) {
                                        setState(() {
                                          statusErrored = true;
                                        });
                                        return "Select your status";
                                      } else {
                                        setState(() {
                                          statusErrored = false;
                                        });
                                      }
                                      return null;
                                    },
                                    items: statusList
                                        .map(
                                          (String item) =>
                                              DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (String? value) {
                                      if (value is String) {
                                        setState(() {
                                          _statusValue = value;
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    key: const Key("phoneNumberKey"),
                                    controller: phoneNumberController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please fill the required field.";
                                      }
                                      return null;
                                    },
                                    inputFormatters: [phoneMaskFormatter],
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text("Phone"),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    key: const Key("emailKey"),
                                    controller: emailController,
                                    onChanged: (value) {
                                      setState(() {
                                        _isEmailCorrect = isEmail(value);
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please fill the required field.';
                                      } else if (!isEmail(value)) {
                                        return "Email not valid";
                                      }
                                      if (isEmailTaken) {
                                        return "Email already exists";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: _isEmailCorrect == true
                                              ? Colors.blue
                                              : Colors.red,
                                        ),
                                      ),
                                      suffixIcon: Icon(
                                        _isEmailCorrect == false
                                            ? Icons.error
                                            : null,
                                        color: Colors.red,
                                      ),
                                      label: const Text("Email"),
                                      errorText: _isEmailCorrect == false
                                          ? "Invalid email format"
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    key: const Key("passwordKey"),
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please fill the required field.";
                                      } else {
                                        bool result = validatePassword(value);
                                        if (result) {
                                          return null;
                                        } else {
                                          return "Password must contain a minimum of 8 characters, upperase, lower case, number and special character";
                                        }
                                      }
                                    },
                                    obscureText: !_passwordVisible,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      label: const Text("Password"),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          key: const Key("PasswordVisibility"),
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "By creating an account, you agree to our  Terms and have read and acknowledge the Global Privacy Statement",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  const SizedBox(height: 32),
                                  _loading
                                      ? const Center(
                                          child: SpinKitRing(
                                            color: Colors.black,
                                            size: 36,
                                            lineWidth: 6,
                                          ),
                                        )
                                      : ElevatedButton(
                                          key: const Key("createAccountKey"),
                                          onPressed: () async {
                                            setState(() {
                                              isButtonPressed = true;
                                            });

                                            try {
                                              setState(() {
                                                _loading = true;
                                              });
                                              await Amplify.Auth.signIn(
                                                username: emailController.text,
                                                password: "12345678",
                                              );
                                              setState(() {
                                                _loading = false;
                                              });
                                            } catch (error) {
                                              setState(() {
                                                _loading = false;
                                              });
                                              if (error.toString().contains(
                                                  "NotAuthorizedException")) {
                                                setState(() {
                                                  isEmailTaken = true;
                                                });
                                              } else {
                                                setState(() {
                                                  isEmailTaken = false;
                                                });
                                              }
                                            }
                                            if (_signupFormKey.currentState!
                                                .validate()) {
                                              try {
                                                setState(() {
                                                  _loading = true;
                                                });
                                                final userAttributes = <
                                                    CognitoUserAttributeKey,
                                                    String>{
                                                  CognitoUserAttributeKey.email:
                                                      emailController.text,
                                                  CognitoUserAttributeKey
                                                          .phoneNumber:
                                                      phoneNumberController
                                                          .text,
                                                  CognitoUserAttributeKey
                                                          .givenName:
                                                      nameController.text,
                                                  CognitoUserAttributeKey
                                                          .address:
                                                      cityController.text,
                                                  CognitoUserAttributeKey
                                                          .familyName:
                                                      surnameController.text,
                                                  CognitoUserAttributeKey
                                                          .birthdate:
                                                      birthDateController.text,
                                                  // const CognitoUserAttributeKey.custom(
                                                  //     "Student"): _statusValue!,
                                                };

                                                final result =
                                                    await Amplify.Auth.signUp(
                                                  username:
                                                      emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  options: CognitoSignUpOptions(
                                                      userAttributes:
                                                          userAttributes),
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.pushNamed(context,
                                                    "/confirmationWeb");
                                                setState(() {
                                                  _loading = false;
                                                });
                                                final prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                await prefs.setString(
                                                    "email_pref",
                                                    emailController.text);
                                                await prefs.setString(
                                                    "password_pref",
                                                    passwordController.text);

                                                setState(() {
                                                  emailProvider.email =
                                                      emailController.text;
                                                  emailPasswordProvider
                                                      .setEmail(
                                                          emailController.text);
                                                  emailPasswordProvider
                                                      .setPassword(
                                                          passwordController
                                                              .text);
                                                });
                                              } on AuthException catch (e) {
                                                setState(() {
                                                  _loading = false;
                                                });
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            minimumSize:
                                                const Size(double.infinity, 56),
                                          ),
                                          child: const Text(
                                            "Create your account",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
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
            const SizedBox(
              height: 30,
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
