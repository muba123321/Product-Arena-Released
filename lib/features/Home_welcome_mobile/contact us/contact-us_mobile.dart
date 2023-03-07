import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:auth/auth.dart';

import 'package:delta_team/common/custom_button.dart';
import 'package:delta_team/features/Home_welcome_mobile/menu_navigation_screen.dart';
import 'package:delta_team/features/Home_welcome_mobile/welcoming_message_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../auth/login/loadingScreens/loadingscreen_mobile.dart';

import '../../onboarding/onboarding_mobile/mobile_widgets/custom_footer_mobile.dart';
import 'auth_provider.dart';

class ContactMobile extends StatefulWidget {
  static const routeName = '/contactmobile';
  const ContactMobile({super.key});

  @override
  State<ContactMobile> createState() => _ContactMobileState();
}

bool isMessageSent = false;

bool _isBurgerIcon = true;

class _ContactMobileState extends State<ContactMobile> {
  final messageKey = GlobalKey<FormState>();
  final messageController = TextEditingController();

  Future<void> fetchCurrentUserAttributes(
      AuthProviderContact authProvider) async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      for (final element in result) {
        print('key: ${element.userAttributeKey}; value: ${element.value}');
        final attributeName = element.userAttributeKey
            .toString()
            .split(' ')
            .last
            .replaceAll('"', '');
        if (attributeName == "given_name") {
          authProvider.setName(element.value);
        } else if (attributeName == "email") {
          authProvider.setEmail(element.value);
        }
      }
      print("_----------------------------_");
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  void _submitForm(BuildContext context) async {
    final message = messageController.text;

    if (message.trim().isEmpty) {
      return;
    }

    try {
      final authProvider =
          Provider.of<AuthProviderContact>(context, listen: false);

      await fetchCurrentUserAttributes(authProvider);

      final name = authProvider.name;
      final email = authProvider.email;

      final restOperation = Amplify.API.post(
        'api/user/contact',
        body: HttpPayload.json({
          'name': name, // Add the name here
          'email': email,
          'question': messageController.text.toString(),
        }),
        apiName: 'contactEmailDelta',
      );
      final response = await restOperation.response;
      print(response.decodeBody());
      print(response);
    } on SuccessState {
      print(SuccessState);
    } on ApiException catch (e) {
      print(e.message);
      print('Error sending email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<AuthProviderContact>(
      create: (_) => AuthProviderContact(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
                onTap: () async {
                  Navigator.pushNamed(context, WelcomingScreen.routeName2);
                },
                child: SvgPicture.asset("assets/images/appbar_logo.svg")),
          ),
          actions: [
            Padding(
              key: const Key('open_menu_burger_icon'),
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                icon: _isBurgerIcon
                    ? const Icon(Icons.menu)
                    : const Icon(Icons.close),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    _isBurgerIcon = !_isBurgerIcon;
                  });
                },
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        backgroundColor: const Color(0xFF000000),
        body: _isBurgerIcon
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 42, top: 27, bottom: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/contact-icon.svg",
                              semanticsLabel: 'Confirmation SVG'),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Contact Us',
                            style: GoogleFonts.notoSans(
                                color: const Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                        key: messageKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                                key: const Key("message"),
                                controller: messageController,
                                style: GoogleFonts.notoSans(
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Leave us a message!',
                                  hintStyle: GoogleFonts.notoSans(
                                      color: const Color(0xFFF3F3F9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFFFFFFF))),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFF3F3F9)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFF3F3F9)),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFF3F3F9))),
                                ),
                                maxLines: 11, //
                                validator: (value) {
                                  if (value == "" || value == null) {
                                    setState(() {
                                      isMessageSent = false;
                                    });
                                    return "Please input your message";
                                  } else if (value.length < 10) {
                                    setState(() {
                                      isMessageSent = false;
                                    });
                                    return "Your message must contain atleast 10 characters";
                                  }
                                  safePrint('Message Sent');
                                  setState(() {
                                    isMessageSent = true;
                                  });
                                  return null;
                                }),
                            Visibility(
                                visible: isMessageSent,
                                child: Column(
                                  children: const [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Your Message has been Sent',
                                      style:
                                          TextStyle(color: Color(0xFFFFFFFF)),
                                    )
                                  ],
                                )),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: (90 / 360) * width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: const Color(0xFF000000),
                                    side: BorderSide(
                                      color: const Color(0xFFFFFFFF),
                                      width: (2 / 360) * width,
                                    ),
                                  ),
                                  key: const Key('Submit_Button'),
                                  onPressed: () async {
                                    if (messageKey.currentState!.validate()) {
                                      _submitForm(context);
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: (7.5 / 360) * width),
                                    child: Center(
                                        child: Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: const Color(0xFFFFFFFF),
                                          fontSize: (14 / 360) * width,
                                          fontWeight: FontWeight.w700),
                                    )),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/contactmail.svg",
                              semanticsLabel: 'Confirmation SVG'),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'hello@tech387.com',
                            style: GoogleFonts.notoSans(
                                color: const Color(0xFFFFFFFF),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.72, right: 19.28),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/images/contactpin.svg",
                              semanticsLabel: 'Confirmation SVG'),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Put Mladih Muslimana 2, City Gardens Residence,  71 000 Sarajevo, Bosnia and Herzegovina',
                                  style: GoogleFonts.notoSans(
                                      color: const Color(0xFFFFFFFF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  '14425 Falconhead Blvd, Bee Cave, TX 78738, United States',
                                  style: GoogleFonts.notoSans(
                                      color: const Color(0xFFFFFFFF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 98,
                    ),
                  ],
                ),
              )
            : const MyDrawer(),
        bottomNavigationBar: const CustomFooter(),
      ),
    );
  }
}
