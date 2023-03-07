import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/signup/provider/auth_provider_mobile.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../../../amplifyconfiguration.dart';
import '../../../../../common/custom_signlog_button.dart';
import '../../../../onboarding/onboarding_mobile/mobile_providers/emailpasswordproviders_mobile.dart';

class TextFieldSignUp extends StatefulWidget {
  const TextFieldSignUp({super.key});

  @override
  State<TextFieldSignUp> createState() => _TextFieldSignUpState();
}

class _TextFieldSignUpState extends State<TextFieldSignUp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException catch (e) {
      safePrint('Amplify was already configured: $e');
    } catch (e) {
      safePrint('An error occurred while configuring Amplify: $e');
    }
  }

  bool viewPassword = false;
  bool isButtonPressed = false;
  bool isPasswordEmpty = true;

  Future<bool> userExist(String email) async {
    try {
      final user =
          await Amplify.Auth.signIn(username: email, password: "dummypass");
    } catch (error) {
      if (!error.toString().contains("UserNotFoundException")) {
        setState(() {
          isEmailTaken = true;
        });
      } else {
        setState(() {
          isEmailTaken = false;
        });
      }
    }
    return false;
  }

  Color errorColor = const Color.fromRGBO(179, 38, 30, 1);

  Color _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
  Color passwordeyelid = const Color(0xFF000000);

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? _statusValue;

  List<String> statusList = [
    'Student',
    'Employed',
    'Unemployed',
  ];

  final _signUpKey = GlobalKey<FormState>();

  bool nameErrored = false;
  bool surnameErrored = false;
  bool birthDateErrored = false;
  bool statusErrored = false;
  bool cityErrored = false;
  bool phoneErrored = false;
  bool emailErrored = false;
  bool passwordErrored = false;

  bool isSignUpCompleted = false;
  bool isEmailTaken = false;

  void changeScreen() {
    Navigator.pushNamed(context, '/confirmation');
    // if (isSignUpCompleted) {
    //   // FocusManager.instance.primaryFocus?.unfocus();
    //   // safePrint('navigated');

    // }
  }

  final phoneMaskFormatter = MaskTextInputFormatter(mask: "+############");
  final dateMaskFormatter = MaskTextInputFormatter(mask: "##/##/####");
  @override
  Widget build(BuildContext context) {
    bool isPasswordEmpty = passwordController.text.isEmpty;

    final emailProvider = Provider.of<MyEmail>(context, listen: false);
    final emailPasswordProvider =
        Provider.of<EmailPasswordProviderMobile>(context, listen: false);
    return Form(
      key: _signUpKey,
      child: Column(
        children: [
          TextFormField(
            key: const Key("nameKey"),
            controller: nameController,
            onChanged: (value) {
              if (value.isNotEmpty && !nameErrored) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: nameErrored ? errorColor : Colors.black),
            onTap: () {
              setState(() {
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _nameLabelColor = const Color.fromRGBO(34, 233, 116, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
              });
            },
            validator: (value) {
              String pattern = r'^[a-zA-Z]+$';
              RegExp regExp = RegExp(pattern);
              if (value!.isEmpty) {
                setState(() {
                  nameErrored = true;
                });
                return 'Please fill the required field.';
              } else if (!regExp.hasMatch(value)) {
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
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: nameErrored,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "Name",
                style: GoogleFonts.notoSans(
                    color: nameErrored && isButtonPressed
                        ? errorColor
                        : _nameLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: nameErrored && isButtonPressed
                      ? errorColor
                      : _nameLabelColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            key: const Key("surnameKey"),
            controller: surnameController,
            onChanged: (value) {
              if (value.isNotEmpty && !surnameErrored) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: surnameErrored ? errorColor : Colors.black),
            onTap: () {
              setState(() {
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(34, 233, 116, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
              });
            },
            validator: (value) {
              String pattern = r'^[a-zA-Z]+$';
              RegExp regExp = RegExp(pattern);
              if (value!.isEmpty) {
                setState(() {
                  surnameErrored = true;
                });
                return 'Please fill the required field.';
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  surnameErrored = true;
                });
                return 'Please enter valid surname';
              } else {
                setState(() {
                  surnameErrored = false;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: surnameErrored && isButtonPressed,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "Surname",
                style: GoogleFonts.notoSans(
                    color: surnameErrored && isButtonPressed
                        ? errorColor
                        : _isSurnameLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: surnameErrored && isButtonPressed
                      ? errorColor
                      : _isSurnameLabelColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            inputFormatters: [dateMaskFormatter],
            key: const Key("birthDateKey"),
            controller: birthDateController,
            onChanged: (value) {
              if (value.isNotEmpty && !birthDateErrored) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: birthDateErrored ? errorColor : Colors.black),
            onTap: () {
              setState(() {
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isBirthDateLabelColor = const Color.fromRGBO(34, 233, 116, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
              });
            },
            validator: (value) {
              RegExp exp = RegExp(
                  r'^(0[1-9]|[1-2][0-9]|3[0-1])/(0[1-9]|1[0-2])/(19[0-9]{2}|200[0-9]|201[0-2])$');
              if (value!.isEmpty) {
                setState(() {
                  birthDateErrored = true;
                });
                return 'Please fill the required field.';
              } else if (!exp.hasMatch(value)) {
                setState(() {
                  birthDateErrored = true;
                });
                return 'Please enter valid birth date (dd/mm/yy)';
              }
              if (exp.hasMatch(value)) {
                setState(() {
                  birthDateErrored = false;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: birthDateErrored,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "Birth Date",
                style: GoogleFonts.notoSans(
                    color:
                        birthDateErrored ? errorColor : _isBirthDateLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: birthDateErrored
                      ? errorColor
                      : const Color.fromRGBO(34, 233, 116, 1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            key: const Key("cityKey"),
            controller: cityController,
            onChanged: (value) {
              if (value.isNotEmpty && !cityErrored) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: cityErrored ? errorColor : Colors.black),
            onTap: () {
              setState(() {
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _cityLabelColor = const Color.fromRGBO(34, 233, 116, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
              });
            },
            validator: (value) {
              String pattern = r'^[^\W\d_]+(?:[-\s][^\W\d_]+)*[.]?$';
              RegExp regExp = RegExp(pattern);
              if (value!.isEmpty) {
                setState(() {
                  cityErrored = true;
                });
                return 'Please fill the required field.';
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  cityErrored = true;
                });
                return 'Please enter valid city';
              } else {
                setState(() {
                  cityErrored = false;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: cityErrored,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "City",
                style: GoogleFonts.notoSans(
                    color: cityErrored ? errorColor : _cityLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: cityErrored ? errorColor : _cityLabelColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: double.infinity,
            child: DropdownButtonFormField<String>(
              key: const Key("statusKey"),
              hint: Text(
                'Status',
                style: GoogleFonts.notoSans(
                    color: statusErrored && isButtonPressed
                        ? errorColor
                        : const Color.fromRGBO(96, 93, 102, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(96, 93, 102, 1),
                    )),
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
                    (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.notoSans(
                          color: statusErrored
                              ? errorColor
                              : Color.fromRGBO(96, 93, 102, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onTap: () {
                setState(() {
                  _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                  _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                });
              },
              onChanged: (String? value) {
                if (value is String) {
                  setState(() {
                    _statusValue = value;
                  });
                }
              },
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            inputFormatters: [phoneMaskFormatter],
            key: const Key("phoneNumberKey"),
            controller: phoneNumberController,
            onChanged: (value) {
              if (value.isNotEmpty && !phoneErrored) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: phoneErrored ? errorColor : Colors.black),
            onTap: () {
              setState(() {
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(34, 233, 116, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
              });
            },
            validator: (value) {
              String patttern =
                  r'^[\+]?((?:9[679]|8[035789]|6[789]|5[90]|42|3[578]|2[1-689])|9[0-58]|8[1246]|6[0-6]|5[1-8]|4[013-9]|3[0-469]|2[70]|7|1)(?:\W*\d){0,13}\d$';
              RegExp regExp = RegExp(patttern);

              if (value!.isEmpty) {
                setState(() {
                  phoneErrored = true;
                });
                return 'Please fill the required field.';
              } else if (phoneNumberController.text[0] != "+") {
                setState(() {
                  phoneErrored = true;
                });
                return 'Please enter valid phone number (+387 format)';
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  phoneErrored = true;
                });
                return 'Please enter valid phone number (+387 format)';
              } else {
                setState(() {
                  phoneErrored = false;
                });
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: phoneErrored,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "Phone",
                style: GoogleFonts.notoSans(
                    color: phoneErrored ? errorColor : _isPhoneLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: phoneErrored
                      ? errorColor
                      : const Color.fromRGBO(34, 233, 116, 1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            key: const Key("emailKey"),
            controller: emailController,
            onChanged: (value) {
              if (value.isNotEmpty && !emailErrored) {
                setState(() {
                  isButtonPressed = false;
                });
              }
            },
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: emailErrored ? errorColor : Colors.black),
            onTap: () {
              setState(() {
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(34, 233, 116, 1);
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                emailErrored = true;
                return 'Please fill the required field.';
              } else if (!EmailValidator.validate(value)) {
                setState(() {
                  emailErrored = true;
                });
                return "Enter the valid email";
              } else if (isEmailTaken) {
                setState(() {
                  emailErrored = true;
                });
                return "Email already exists";
              }

              setState(() {
                emailErrored = false;
              });
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: emailErrored,
                child: Icon(
                  Icons.error,
                  color: errorColor,
                  size: 24,
                ),
              ),
              label: Text(
                "Email",
                style: GoogleFonts.notoSans(
                    color: emailErrored && isButtonPressed
                        ? errorColor
                        : _isEmailLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: emailErrored && isButtonPressed
                        ? errorColor
                        : const Color.fromRGBO(34, 233, 116, 1)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            key: const Key("passwordKey"),
            controller: passwordController,
            onChanged: (value) {
              if (value.isNotEmpty && !passwordErrored) {
                setState(() {
                  isButtonPressed = false;
                });
              }
              setState(() {
                isPasswordEmpty = value.isEmpty;
              });
            },
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: passwordErrored ? errorColor : Colors.black),
            obscureText: !viewPassword ? true : false,
            onTap: () {
              setState(() {
                _nameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isSurnameLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isBirthDateLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPhoneLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _cityLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isEmailLabelColor = const Color.fromRGBO(96, 93, 102, 1);
                _isPasswordLabelColor = const Color.fromRGBO(34, 233, 116, 1);
              });
            },
            validator: (value) {
              String regex =
                  r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
              RegExp regExp = RegExp(regex);

              if (value!.isEmpty) {
                setState(() {
                  passwordErrored = true;
                  passwordeyelid = const Color(0xFFB3261E);
                });
                return 'Please fill the required field.';
              } else if (!regExp.hasMatch(value)) {
                setState(() {
                  passwordErrored = true;
                  passwordeyelid = const Color(0xFFB3261E);
                });
                return 'Password must contain a minimum of 8 characters, \nuppercase, lower case, number and special character.';
              } else {
                setState(() {
                  passwordErrored = false;
                  passwordeyelid = const Color(0xFF000000);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: !isPasswordEmpty,
                child: InkWell(
                    key: const Key("passwordVisible"),
                    child: Icon(
                        viewPassword ? Icons.visibility : Icons.visibility_off,
                        color: passwordeyelid
                        // ? Colors.black
                        // : const Color.fromRGBO(96, 93, 102, 1),
                        ),
                    onTap: () {
                      setState(() {
                        viewPassword = !viewPassword;
                      });
                    }),
              ),
              label: Text(
                "Password",
                style: GoogleFonts.notoSans(
                    color: passwordErrored ? errorColor : _isPasswordLabelColor,
                    fontSize: 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: passwordErrored
                        ? errorColor
                        : const Color.fromRGBO(34, 233, 116, 1)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          passwordErrored
              ? const SizedBox(
                  height: 72,
                )
              : const SizedBox(
                  height: 16,
                ),
          Text(
              "By creating an account, you agree to our Terms and have read and acknowledge the Global Privacy Statement.",
              style: GoogleFonts.notoSans(
                  fontSize: 10, color: const Color.fromRGBO(96, 93, 102, 1))),
          const SizedBox(
            height: 33,
          ),
          CustomButton(
            key: const Key("createAccountKey"),
            content: Text(
              "Create Your account",
              style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            buttonFunction: () async {
              setState(() {
                isButtonPressed = true;
              });

              // await userExist(emailController.text);
              if (_signUpKey.currentState!.validate()) {
                try {
                  final userAttributes = <CognitoUserAttributeKey, String>{
                    CognitoUserAttributeKey.email: emailController.text,
                    CognitoUserAttributeKey.phoneNumber:
                        phoneNumberController.text,
                    CognitoUserAttributeKey.givenName: nameController.text,
                    CognitoUserAttributeKey.address: cityController.text,
                    CognitoUserAttributeKey.familyName: surnameController.text,
                    CognitoUserAttributeKey.birthdate: birthDateController.text,
                    // const CognitoUserAttributeKey.custom("Status"):
                    //     _statusValue!,
                  };
                  final result = await Amplify.Auth.signUp(
                    username: emailController.text,
                    password: passwordController.text,
                    options:
                        CognitoSignUpOptions(userAttributes: userAttributes),
                  );
                  emailProvider.email = emailController.text;
                  emailPasswordProvider.setEmail(emailController.text);
                  emailPasswordProvider.setPassword(passwordController.text);
                  isSignUpCompleted = true;
                } catch (e) {
                  safePrint(e.toString());
                }
              }
              if (isSignUpCompleted) {
                changeScreen();
              }
            },
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
