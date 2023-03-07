import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:delta_team/features/onboarding_web/provider/emailPasswProvider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../common/footer/footer.dart';

import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:delta_team/amplifyconfiguration.dart';

import 'errorMsg-web.dart';
import 'modelRole.dart';
import 'modelRoleWhite.dart';
import 'modelmyItem.dart';

class OnboardingWeb extends StatefulWidget {
  static const routeName = '/onboardingweb';
  final Role role;

  const OnboardingWeb({super.key, required this.role});

  @override
  State<OnboardingWeb> createState() => _OnboardingWebState(this.role);
}

class _OnboardingWebState extends State<OnboardingWeb> {
  String? _character;

  final TextEditingController _motivacija = TextEditingController();
  final TextEditingController _hobi = TextEditingController();
  final TextEditingController _interesovanja = TextEditingController();
  final TextEditingController _kucniLjubimac = TextEditingController();
  final TextEditingController _kapetan = TextEditingController();
  final TextEditingController _UnesiYtUrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _controller = YoutubePlayerController.fromVideoId(
    videoId: '2_uX7GxPzDI',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  final Role role;

  _OnboardingWebState(this.role);

  @override
  void initState() {
    super.initState();
    // _loadPrefs();
    // final emailPasswordProvider =
    //     Provider.of<EmailPasswordProvider>(context, listen: false);

    // signInUser(emailOnboarding, passwordOnboarding);
  }

  String emailOnboarding = '';
  String passwordOnboarding = '';

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final String? email = prefs.getString("email_pref");
    final String? password = prefs.getString("password_pref");
    print(email);
    print(password);
    setState(() {
      emailOnboarding = email!;
      passwordOnboarding = password!;
    });
  }

  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
    final authPlugin = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([authPlugin, api]);
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  Future<void> signInUser(String email, String password) async {
    await _configureAmplify();
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

  Future<void> signOutUser() async {
    try {
      final res = await Amplify.Auth.signOut();

      print(res);
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Widget build(BuildContext context) {
    var myItem = Provider.of<MyItemWeb>(context);
    var nizSaRolama = Provider.of<MyItemWeb>(context).myItems;
    var isSelected = myItem.hasRole(role);
    bool inColumn = false;
    bool videoWithoutTitle = false;

    if (MediaQuery.of(context).size.width < 910) {
      inColumn = true;
    } else {
      inColumn = false;
    }

    if (MediaQuery.of(context).size.width < 300) {
      videoWithoutTitle = true;
    } else {
      videoWithoutTitle = false;
    }

    Future<void> submitOnboarding() async {
      try {
        final restOperation = Amplify.API.post("/api/onboarding/submit",
            body: HttpPayload.json({
              "date": "Jan2023",
              "roles": nizSaRolama,
              "answers": {
                // answers are in the same order as questions, null if not answered
                "0": _character,
                "1": _motivacija.text,
                "2": _hobi.text,
                "3": _interesovanja.text,
                "4": _kucniLjubimac.text,
                "5": _kapetan.text,
                "6": _UnesiYtUrl.text,
              },
            }),
            apiName: "UserObjectInitialization");
        final response = await restOperation.response;
        Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
        print('POST call succeeded');
        print(responseMap['lectures']);
      } on ApiException catch (e) {
        print('POST call failed: $e');
      }
    }

    void clearFields() {
      setState(() {
        // _character = null;

        _motivacija.clear();
        _hobi.clear();
        _interesovanja.clear();
        _kucniLjubimac.clear();
        _kapetan.clear();
        nizSaRolama.clear();
        _UnesiYtUrl.clear();
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        leadingWidth: 240,
        title: const Text(
          'Tech387',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //dobrodosli container
            Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      width: MediaQuery.of(context).size.width * 0.69,
                      child: Text(
                        'Dobrodošli!',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                ],
              ),
            ),

            // tekst ispod dobrodosli containera
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    // color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.59,
                    // margin: EdgeInsets.fromLTRB(0, 0, 390, 0),
                    child: Text(
                      'Ne zaboravite da odvojite vrijeme i pažljivo pročitajte svako pitanje. Sretno!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: MediaQuery.of(context).size.width * 0.59,
                      child: const Text(
                        'Molimo vas da popunite dole potrebne podatke: ',
                        style: TextStyle(fontSize: 18),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 24, top: 17, right: 24, left: 24),
                      child: Column(
                        children: [
                          //pocetak pitanja forme
                          Container(
                            width: MediaQuery.of(context).size.width * 0.58,
                            child: Text(
                                'Product Arena je full-time tromjesečna praksa, da li spreman/a učenju i radu posvetiti 8 sati svakog radnog dana?'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Column(
                            children: [
                              ListTile(
                                title: const Text('Da'),
                                leading: Radio<String>(
                                  key: const Key('KeyDa'),
                                  value: "False",
                                  groupValue: _character,
                                  onChanged: (value) {
                                    setState(() {
                                      _character = value;
                                      print(value);
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Ne'),
                                leading: Radio<String>(
                                  key: const Key('KeyNe'),
                                  value: "True",
                                  groupValue: _character,
                                  onChanged: (value) {
                                    setState(() {
                                      _character = value;
                                      print(value);
                                    });
                                  },
                                ),
                              ),
                              Consumer<ErrorMessageWeb>(
                                builder: (context, error, child) {
                                  return Container(
                                    key: const Key('erorrMsgNEZNAMJELOVOTREBA'),
                                    padding:
                                        EdgeInsets.only(left: 20.0, top: 5.0),
                                    height: error.errorHeight,
                                    child: Row(
                                      children: <Widget>[
                                        // Icon(error.errorIcon,
                                        //     size: 20.0, color: Colors.red[700]),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            error.errorText,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.red[700],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),

                          // Column

                          // FormField
                        ],
                      ),
                    ),
                  ),
                  //drugi container
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7))),
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 17, right: 24, left: 24, bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Šta te motiviše?"),
                          TextFormField(
                            key: const Key('TextFieldKey2'),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              label: Text(
                                'Vaš odgovor',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            // controller: _controllers[2],
                            controller: _motivacija,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ovo polje je obavezno ! ';
                              } else {
                                print(value);
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 0,
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                key: const Key('clearsection2'),
                                onTap: () {
                                  _motivacija.clear();
                                },
                                child: const Text(
                                  'Clear Section',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7))),
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 17, right: 24, left: 24, bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              "Da li imaš ili si imao/la neki hobi ili se baviš nekim sportom?"),
                          TextFormField(
                            key: const Key('TextFieldKey3'),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              label: Text(
                                'Vaš odgovor',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            // controller: _controllers[2],
                            controller: _hobi,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ovo polje je obavezno ! ';
                              } else {
                                print(value);
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 0,
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                key: const Key('clearsection3'),
                                onTap: () {
                                  _hobi.clear();
                                },
                                child: const Text(
                                  'Clear Section',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //OVDJE treci
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7))),
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 17, right: 24, left: 24, bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              "Postoji li neko interesovanje koje imaš, ali ga trenutno ne možeš ostvariti?"),
                          TextFormField(
                            key: const Key('TextFieldKey4'),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              label: Text(
                                'Vaš odgovor',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            // controller: _controllers[2],
                            controller: _interesovanja,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ovo polje je obavezno ! ';
                              } else {
                                print(value);
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 0,
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                key: const Key('clearsection4'),
                                onTap: () {
                                  _interesovanja.clear();
                                },
                                child: const Text(
                                  'Clear Section',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7))),
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 17, right: 24, left: 24, bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              "Da li bi vodio/la brigu o kucnom ljubimcu svojih komsija dok su oni na godisnjem odmoru?"),
                          TextFormField(
                            key: const Key('TextFieldKey5'),

                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              label: Text(
                                'Unesi text',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            // controller: _controllers[2],
                            controller: _kucniLjubimac,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ovo polje je obavezno ! ';
                              } else {
                                print(value);
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 0,
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                key: const Key('clearsection5'),
                                onTap: () {
                                  _kucniLjubimac.clear();
                                },
                                child: const Text(
                                  'Clear Section',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7))),
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 17, right: 24, left: 24, bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              "Kapetan si piratskog broda, tvoja posada može da glasa kako se dijeli zlato. Ako se manje od polovine pirata složi sa tobom, umrijet ćeš. Kakvu podjelu zlata bi predložio/la tako da dobiješ dobar dio plijena, a ipak preživiš?"),
                          TextFormField(
                            key: const Key('TextFieldKey6'),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 20),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              label: Text(
                                'Vaš odgovor',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            // controller: _controllers[2],
                            controller: _kapetan,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ovo polje je obavezno ! ';
                              } else {
                                print(value);
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 0,
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                key: const Key('clearsection6'),
                                onTap: () {
                                  _kapetan.clear();
                                },
                                child: const Text(
                                  'Clear Section',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  inColumn
                      ? Column(
                          children: [
                            videoWithoutTitle
                                ? Padding(
                                    padding: const EdgeInsets.all(70),
                                    // child: YoutubePlayer(
                                    //   key: const Key('ytplayer'),
                                    //   controller: _controller,
                                    //   aspectRatio: 16 / 9,
                                    // ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(7))),
                                    margin:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 17,
                                          right: 24,
                                          left: 24,
                                          bottom: 24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                              "Pogledajte video snimak Amera i poslušajte njegovu poruku.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 6),
                                          YoutubePlayer(
                                            key: const Key('ytPlayerManji'),
                                            controller: _controller,
                                            aspectRatio: 50 / 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))),
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 17, right: 24, left: 24, bottom: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        "Snimi video i predstavi se!\nRecite nam nešto zanimljivo o sebi ili nečemu što vas zanima.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 29),
                                    const Text(
                                        "Molimo te da link staviš u box!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    TextFormField(
                                      key: const Key('urlKey1'),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                      decoration: const InputDecoration(
                                        labelStyle: TextStyle(fontSize: 20),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        label: Text(
                                          'https://',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      controller: _UnesiYtUrl,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      "Za učitavanje slika koristiti: file.io",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))),
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 17, right: 24, left: 24, bottom: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        "Pogledajte video snimak Amera i poslušajte njegovu poruku.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 6),
                                    // probaj staviti width i height za video NADJI EROR STO IZBACUJE

                                    YoutubePlayer(
                                      key: const Key('ytKiDrugaVelicina'),
                                      controller: _controller,
                                      aspectRatio: 16 / 9,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))),
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 17, right: 24, left: 24, bottom: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        "Snimi video i predstavi se!\nRecite nam nešto zanimljivo o sebi ili nečemu što vas zanima.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 29),
                                    const Text(
                                        "Molimo te da link staviš u box!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    TextFormField(
                                      key: const Key('urlKey2'),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                      decoration: const InputDecoration(
                                        labelStyle: TextStyle(fontSize: 20),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        label: Text(
                                          'https://',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      controller: _UnesiYtUrl,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      "Za učitavanje slika koristiti: file.io",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),

            // ElevatedButton(onPressed: signOutUser, child: Text('sign out')),
            SizedBox(
              height: 20,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.green,
                  height: inColumn ? 750 : 160,
                  width: 930,
                  child: ListView(
                      scrollDirection:
                          inColumn ? Axis.vertical : Axis.horizontal,
                      children: List.generate(
                        listaRola.length,
                        (index) => Item(
                          role: listaRola[index],
                          roleWhite: listaRolaWhite[index],
                        ),
                      )),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            //BUTTONS

            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      key: const Key('posaljikey'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            _character != null &&
                            (isSelected ||
                                myItem.length <= 2 && myItem.length >= 1)) {
                          if (nizSaRolama.first == null) {
                            myItem.add(widget.role);
                          }
                          // myItem.add(widget.role);

                          submitOnboarding();

                          signOutUser();

                          Navigator.pushNamed(
                              context, LoginScreenWeb.routeName);
                        } else if (_character == null) {
                          context.read<ErrorMessageWeb>().change();
                          // ignore: unnecessary_null_comparison
                        } else if (nizSaRolama.first != null) {
                          myItem.remove(widget.role);
                          // ignore: unnecessary_null_comparison
                        } else {
                          myItem.add(widget.role);
                          print(myItem.length);
                        }

                        // clearFields();
                      },
                      // clearFields();
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: Text(
                        'Posalji',
                      )),

                  // GestureDetector(

                  GestureDetector(
                      key: const Key('ocistiKey'),
                      onTap: clearFields,
                      child: Text('Ocisti odabir'))
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),

            const Footer(),

            //OVDJE
          ],
        ),
      ),
    );
  }
}

class Item extends StatefulWidget {
  // dodaj model klasu za itejme
  final Role role;
  final RoleWhite roleWhite;

  const Item({super.key, required this.role, required this.roleWhite});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    // use Provider
    var myItem = Provider.of<MyItemWeb>(context);
    var nizSaRolama = Provider.of<MyItemWeb>(context).myItems;
    var isSelected = myItem.hasRole(widget.role);

    fja() {
      if (isSelected || nizSaRolama.length >= 2) {
        myItem.remove(widget.role);
      } else {
        myItem.add(widget.role);
      }
    }

    return GestureDetector(
      key: const Key('rolekey'),
      onTap: () {
        fja();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            key: const Key('colorkey'),
            margin: const EdgeInsets.fromLTRB(40.0, 16.0, 16.0, 16.0),
            padding: const EdgeInsets.all(16.0),
            width: 124,
            height: 110,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Color.fromRGBO(50, 47, 55, 1),
              border: isSelected
                  ? Border.all(
                      width: 2,
                    )
                  : Border.all(width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(children: [
              Container(
                  key: const Key('slikakey'),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: isSelected
                      ? Image.asset(widget.role.image)
                      : Image.asset(
                          widget.roleWhite.imageWhite,
                        )),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: 135,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      key: const Key('textkey'),
                      widget.role.id,
                      style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                  )),
            ]),
          ),
          SizedBox(
            height: 12.0,
          ),
          // Text(widget.role.id),
        ],
      ),
    );
  }
}
