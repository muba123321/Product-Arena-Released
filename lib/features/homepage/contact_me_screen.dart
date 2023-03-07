// ignore_for_file: deprecated_member_use

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/login/providers/userAttributesProvider.dart';
import 'package:delta_team/features/homepage/homepage_sidebar.dart';
import 'package:delta_team/features/homepage/provider/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../amplifyconfiguration.dart';
import 'account_modal.dart';
// ignore: unused_import

class ContactMeScreen extends StatefulWidget {
  const ContactMeScreen({super.key});

  @override
  State<ContactMeScreen> createState() => _ContactMeScreenState();
}

// Future<void> signInUser() async {
//   try {
//     await Amplify.Auth.signIn(
//       username: 'bhitoshdrgb@eurokool.com',
//       password: 'Pass123!',
//     );
//     safePrint('Loginovan');
//   } on AuthException catch (e) {
//     safePrint(e.message);
//   }
// }

bool isMessageSent = false;
bool showModal = false;

class _ContactMeScreenState extends State<ContactMeScreen> {
  @override
  void initState() {
    super.initState();
    showModal = false;
    _loadPrefs();
  }

  String email = '';
  String surname = '';
  String name = '';

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final nameUser = prefs.getString('nameUser');
    final emailUser = prefs.getString('email');
    final surnameUser = prefs.getString('surname');
    setState(() {
      email = emailUser!;
      surname = surnameUser!;
      name = nameUser!;
    });
  }

  final _contactFormKey = GlobalKey<FormState>();
  final _contactFormKey1 = GlobalKey<FormState>();
  final _contactFormKey2 = GlobalKey<FormState>();
  final contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double sizebarWidthBlack = MediaQuery.of(context).size.width * 0.25;
    double sizebarWidthWhite = MediaQuery.of(context).size.width * 0.75;

    bool smallScreensSidebar = false;
    bool removeContent = false;

    if (MediaQuery.of(context).size.width < 650) {
      setState(() {
        smallScreensSidebar = true;
      });
    }

    if (MediaQuery.of(context).size.width < 970) {
      sizebarWidthBlack = MediaQuery.of(context).size.width * 0.35;
      sizebarWidthWhite = MediaQuery.of(context).size.width * 0.65;
      removeContent = true;
    }

    String contactUsMessage = '';

    void setMessage() {
      setState(() {
        contactUsMessage = 'Your email is sent!';
      });

      Future.delayed(Duration(seconds: 10), () {
        setState(() {
          contactUsMessage = '';
        });
      });
    }

    return Scaffold(
      body: Row(
        children: [
          !smallScreensSidebar
              ? Container(
                  color: Colors.black,
                  width: sizebarWidthBlack,
                  child: const Sidebar())
              : Container(),
          SizedBox(
            width: smallScreensSidebar
                ? MediaQuery.of(context).size.width
                : sizebarWidthWhite,
            child: MediaQuery.of(context).size.height > 690
                ? Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: Stack(children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          smallScreensSidebar
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      key: const Key("user_menu_key"),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/homepage_sidebar');
                                      },
                                      child: const Icon(
                                        Icons.menu,
                                        size: 50,
                                        color: Colors.black,
                                      ),
                                    ),
                                    GestureDetector(
                                      key: const Key("user_icon_key"),
                                      onTap: () {
                                        setState(() {
                                          showModal = !showModal;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.account_circle_rounded,
                                        color: Colors.green,
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      key: const Key("user_icon_key1"),
                                      onTap: () {
                                        setState(() {
                                          showModal = !showModal;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.account_circle_rounded,
                                        color: Colors.green,
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                ),
                          Stack(
                            children: [
                              removeContent
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                          const SizedBox(height: 130),
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: 'CONTACT US\n',
                                              style: GoogleFonts.notoSans(
                                                fontSize: 32,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'You are more than welcome to leave your\nmessage and we will be in touch shortly.\n\n\n',
                                                  style: GoogleFonts.notoSans(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: maxwidth * (30 / 1440),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            child: Form(
                                              key: _contactFormKey,
                                              child: TextFormField(
                                                key: const Key('contactField'),
                                                controller: contactController,
                                                validator: (value) {
                                                  if (value == "" ||
                                                      value == null) {
                                                    setState(() {
                                                      isMessageSent = false;
                                                    });
                                                    return "Please type your message before sending";
                                                  } else if (value.length <
                                                      10) {
                                                    setState(() {
                                                      isMessageSent = false;
                                                    });
                                                    return "Your message has to contain at least 10 characters";
                                                  }
                                                  safePrint('MessageSent');
                                                  setState(() {
                                                    isMessageSent = true;
                                                  });
                                                  return null;
                                                },
                                                maxLines: 8,
                                                decoration: InputDecoration(
                                                  hintText: 'Your Message',
                                                  hintStyle:
                                                      GoogleFonts.notoSans(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFF22E974),
                                                    ),
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                style: GoogleFonts.notoSans(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Visibility(
                                          //   visible: isMessageSent,
                                          //   child: Column(
                                          //     children: const [
                                          //       SizedBox(
                                          //         height: 10,
                                          //       ),
                                          //       Text(
                                          //         "Message sent",
                                          //         style: TextStyle(
                                          //           color: Color(0xFF22E974),
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          const SizedBox(height: 10),
                                          ElevatedButton(
                                            key: const Key("submit_key"),
                                            onPressed: () async {
                                              if (_contactFormKey.currentState!
                                                  .validate()) {
                                                try {
                                                  final restOperation =
                                                      Amplify.API.post(
                                                    'api/user/contact',
                                                    apiName:
                                                        'contactEmailDelta',
                                                    body: HttpPayload.json(
                                                      {
                                                        'name': name,
                                                        'email': email,
                                                        'question':
                                                            contactController
                                                                .text
                                                                .toString(),
                                                      },
                                                    ),
                                                    // headers: {
                                                    //   "Access-control-allow-headers":
                                                    //       "Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token"
                                                    // },
                                                  );
                                                  final response =
                                                      await restOperation
                                                          .response;
                                                  contactController.text = '';
                                                } on ApiException catch (e) {
                                                  safePrint(
                                                      'POST call failed: ${e.message}');
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black,
                                                foregroundColor: Colors.white,
                                                minimumSize:
                                                    const Size(141, 55)),
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ])
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const SizedBox(
                                                height: 80,
                                              ),
                                              RichText(
                                                textAlign: TextAlign.right,
                                                text: TextSpan(
                                                  text: 'CONTACT US\n',
                                                  style: GoogleFonts.notoSans(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'You are more than welcome to leave your\nmessage and we will be in touch shortly.\n\n\n',
                                                      style:
                                                          GoogleFonts.notoSans(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 160,
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    key: const Key(
                                                        "facebook_icon"),
                                                    child: Image.asset(
                                                      'assets/images/facebook.png',
                                                    ),
                                                    onTap: () => launch(
                                                        'https://www.facebook.com/tech387'),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    key: const Key(
                                                        "instagram_icon"),
                                                    child: Image.asset(
                                                      'assets/images/instagram.png',
                                                    ),
                                                    onTap: () => launch(
                                                        'https://www.instagram.com/tech387/?hl=en'),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    key: const Key(
                                                        "linkedin_icon"),
                                                    child: Image.asset(
                                                      'assets/images/linkedin.png',
                                                    ),
                                                    onTap: () => launch(
                                                        'https://www.linkedin.com/company/tech-387/mycompany/'),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    key: const Key("tech_icon"),
                                                    child: Image.asset(
                                                      'assets/images/tech387.png',
                                                    ),
                                                    onTap: () => launch(
                                                        'https://www.tech387.com/'),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 150,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.20,
                                              child: Form(
                                                key: _contactFormKey1,
                                                child: TextFormField(
                                                  key: const Key(
                                                      'contactField1'),
                                                  controller: contactController,
                                                  validator: (value) {
                                                    if (value == "" ||
                                                        value == null) {
                                                      setState(() {
                                                        isMessageSent = false;
                                                      });
                                                      return "Please type your message before sending";
                                                    } else if (value.length <
                                                        10) {
                                                      setState(() {
                                                        isMessageSent = false;
                                                      });
                                                      return "Your message has to contain at least 10 characters";
                                                    }
                                                    safePrint('MessageSent');
                                                    setState(() {
                                                      isMessageSent = true;
                                                    });
                                                    return null;
                                                  },
                                                  maxLines: 8,
                                                  decoration: InputDecoration(
                                                    hintText: 'Your Message',
                                                    hintStyle:
                                                        GoogleFonts.notoSans(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFF22E974),
                                                      ),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  style: GoogleFonts.notoSans(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                              key: const Key("submit_key1"),
                                              onPressed: () async {
                                                if (_contactFormKey
                                                    .currentState!
                                                    .validate()) {
                                                  try {
                                                    final restOperation =
                                                        Amplify.API.post(
                                                      'api/user/contact',
                                                      apiName:
                                                          'contactEmailDelta',
                                                      body: HttpPayload.json(
                                                        {
                                                          'name': name,
                                                          'email': email,
                                                          'question':
                                                              contactController
                                                                  .text
                                                                  .toString(),
                                                        },
                                                      ),
                                                      // headers: {
                                                      //   "Access-control-allow-headers":
                                                      //       "Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token"
                                                      // },
                                                    );
                                                    final response =
                                                        await restOperation
                                                            .response;
                                                    contactController.text = '';
                                                  } on ApiException catch (e) {
                                                    safePrint(
                                                        'POST call failed: ${e.message}');
                                                  }
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  foregroundColor: Colors.white,
                                                  minimumSize:
                                                      const Size(141, 55)),
                                              child: const Text(
                                                'Submit',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 90,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  'assets/images/pin.png',
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.20,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      await launchUrl(Uri.parse(
                                                          'https://www.google.ba/maps/place/Tech387/@43.8538483,18.4205947,17z/data=!3m1!4b1!4m6!3m5!1s0x4758c903ae6b4fe1:0xa4116c0159094813!8m2!3d43.8538483!4d18.4227834!16s%2Fg%2F11h_6q3_47'));
                                                    },
                                                    child: Text(
                                                      "Put Mladih Muslimana 2, City Gardens Residence, 71 000 Sarajevo, Bosnia and Herzegovina 14425 Falconhead Blvd, Bee Cave, TX 78738, United States",
                                                      style:
                                                          GoogleFonts.notoSans(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/mail.png',
                                                ),
                                                SizedBox(
                                                  width: maxwidth * (10 / 1440),
                                                ),
                                                Text(
                                                  'hello@tech387.com',
                                                  style: GoogleFonts.notoSans(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                              !showModal ? Container() : const AccountModal(),
                            ],
                          ),
                        ],
                      ),
                    ]),
                  )
                : SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              key: const Key("user_icon_key2"),
                              onTap: () {
                                setState(() {
                                  showModal = !showModal;
                                });
                              },
                              child: const Icon(
                                Icons.account_circle_rounded,
                                color: Colors.green,
                                size: 50,
                              ),
                            ),
                            MediaQuery.of(context).size.height > 670
                                ? const SizedBox(height: 100)
                                : const SizedBox(),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        RichText(
                                          textAlign: TextAlign.right,
                                          text: TextSpan(
                                            text: 'CONTACT US\n',
                                            style: GoogleFonts.notoSans(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    'You are more than welcome to leave your\nmessage and we will be in touch shortly.\n\n\n',
                                                style: GoogleFonts.notoSans(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: maxwidth * (30 / 1440),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: maxwidth * (350 / 1440),
                                          child: Form(
                                            key: _contactFormKey2,
                                            child: TextFormField(
                                              key: const Key('contactField2'),
                                              controller: contactController,
                                              validator: (value) {
                                                if (value == "" ||
                                                    value == null) {
                                                  setState(() {
                                                    isMessageSent = false;
                                                  });
                                                  return "Please type your message before sending";
                                                } else if (value.length < 10) {
                                                  setState(() {
                                                    isMessageSent = false;
                                                  });
                                                  return "Your message has to contain at least 10 characters";
                                                }
                                                safePrint('MessageSent');
                                                setState(() {
                                                  isMessageSent = true;
                                                });
                                                return null;
                                              },
                                              maxLines: 8,
                                              decoration: InputDecoration(
                                                hintText: 'Your Message',
                                                hintStyle: GoogleFonts.notoSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF22E974),
                                                  ),
                                                ),
                                                border:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              style: GoogleFonts.notoSans(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Visibility(
                                        //   visible: isMessageSent,
                                        //   child: Column(
                                        //     children: const [
                                        //       SizedBox(
                                        //         height: 10,
                                        //       ),
                                        //       Text(
                                        //         "Message sent",
                                        //         style: TextStyle(
                                        //           color: Color(0xFF22E974),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  key: const Key("submit_key2"),
                                  onPressed: () async {
                                    if (_contactFormKey.currentState!
                                        .validate()) {
                                      try {
                                        final restOperation = Amplify.API.post(
                                          'api/user/form',
                                          apiName: 'contactEmailDelta',
                                          body: HttpPayload.json(
                                            {
                                              'question': contactController.text
                                                  .toString(),
                                              'name': name,
                                              'email': email
                                            },
                                          ),
                                        );
                                        final response =
                                            await restOperation.response;
                                        safePrint('POST call succeeded');
                                        safePrint(response.decodeBody());
                                      } on ApiException catch (e) {
                                        safePrint(
                                            'POST call failed: ${e.message}');
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(141, 55)),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ],
                        ),
                        !showModal ? Container() : const AccountModal(),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
