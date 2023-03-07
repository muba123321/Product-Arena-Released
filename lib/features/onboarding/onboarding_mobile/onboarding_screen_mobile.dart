import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_widgets/onboarding_widget_mobile.dart';
import 'package:delta_team/amplifyconfiguration.dart';
import 'package:delta_team/common/colors.dart';

import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_providers/answer_mobile.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_widgets/custom_footer_mobile.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_widgets/page_indicator_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import 'mobile_models/role_mobile.dart';
import 'mobile_providers/emailpasswordproviders_mobile.dart';
import 'mobile_providers/role_provider_mobile.dart';
import 'mobile_widgets/congratulations_card_mobile.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = 'onboarding-screen';
  final Role role;
  const OnboardingScreen({super.key, required this.role});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  bool isFormValid = true;

  final _globalKey = List<GlobalKey<FormState>>.generate(
    5,
    (index) => GlobalKey<FormState>(),
  );

  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    final emailPasswordProvider =
        Provider.of<EmailPasswordProviderMobile>(context, listen: false);

    signInUser(emailPasswordProvider.email, emailPasswordProvider.password);
    // _configureAmplify();
  }

  // Future<void> _configureAmplify() async {
  //   // Add any Amplify plugins you want to use
  //   final authPlugin = AmplifyAuthCognito();
  //   final api = AmplifyAPI();
  //   await Amplify.addPlugins([authPlugin, api]);
  //   try {
  //     await Amplify.configure(amplifyconfig);
  //   } on AmplifyAlreadyConfiguredException {
  //     safePrint(
  //         'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
  //   }
  // }

  Future<void> signInUser(String email, String password) async {
    // await _configureAmplify();
    try {
      final result = await Amplify.Auth.signIn(
        username: email, // email of user,
        password: password,
      );
      print('Logged In');
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

  Future<void> submitOnboarding() async {
    try {
      final restOperation = Amplify.API.post("/api/onboarding/submit",
          body: HttpPayload.json({
            "date": "Jan2023",
            "roles": Provider.of<MyItem>(context, listen: false).myItems,
            "answers": {
              // answers are in the same order as questions, null if not answered
              "0": Provider.of<AnswerProvider>(context, listen: false).answ[0],
              "1": controllers[0].text,
              "2": controllers[1].text,
              "3": controllers[2].text,
              "4": controllers[3].text,
              "5": controllers[4].text,
              "6": controllers[5].text,
            },
            "introductionVideoUrl": "https://www.youtube.com"
          }),
          apiName: "UserObjectInitialization");
      final response = await restOperation.response;

      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      print('POST call succeeded');
      print(responseMap['lectures']);
    } on ApiException catch (e) {
      print(e.message);
      print('POST call failed: $e');
    }
  }

  @override
  void dispose() {
    // disposing the controllers
    for (TextEditingController controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  final List<String> questions = [
    'Product Arena je full-time tromjesečna praksa, da li spreman/a učenju i radu posvetiti 8 sati svakog radnog dana?',
    'Šta te motiviše?',
    'Da li imaš ili si imao/la neki hobi ili se baviš nekim sportom?',
    'Postoji li neko interesovanje koje imaš, ali ga trenutno ne možeš ostvariti?',
    'Da li bi vodio/la brigu o kućnom ljubimcu svojih komšija dok su oni na godišnjem odmoru?',
    'Kapetan si piratskog broda, tvoja posada može da glasa kako se dijeli zlato. Ako se manje od polovine pirata složi sa tobom, umrijet ćeš. \n \nKakvu podjelu zlata bi predložio/la tako da dobiješ dobar dio plijena, a ipak preživiš?',
    'Pogledajte video snimak Amera i poslušajte njegovu poruku.',
    'Za koju poziciju se prijavljuješ?'
  ];

  @override
  Widget build(BuildContext context) {
    final emailPasswordProvider =
        Provider.of<EmailPasswordProviderMobile>(context, listen: false);
    final provider = Provider.of<AnswerProvider>(context, listen: false);

    final List<Widget> pages = [
      FormWithRadioButtons(
        questionText: questions[0],
        pageController: _pageController,
        onNext: () {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
      ),
      OnboardingForm(
        questionText: questions[1],
        controller: controllers[0],
        pageController: _pageController,
        globalKey: _globalKey[0],
        answer: controllers[1].text,
      ),
      OnboardingForm(
        questionText: questions[2],
        controller: controllers[1],
        pageController: _pageController,
        globalKey: _globalKey[1],
        answer: controllers[2].text,
      ),
      OnboardingForm(
        questionText: questions[3],
        controller: controllers[2],
        pageController: _pageController,
        globalKey: _globalKey[2],
        answer: controllers[3].text,
      ),
      OnboardingForm(
        questionText: questions[4],
        controller: controllers[3],
        pageController: _pageController,
        globalKey: _globalKey[3],
        answer: controllers[4].text,
      ),
      OnboardingForm(
        questionText: questions[5],
        controller: controllers[4],
        pageController: _pageController,
        globalKey: _globalKey[4],
        answer: controllers[5].text,
      ),
      VideoPageForm(
        questionText: questions[6],
        pageController: _pageController,
        // videoController: videoController),
      ),
      PositionPageForm(
        questionText: questions[7],
        pageController: _pageController,
        role: widget.role,
        submitButton: () {
          final provider = Provider.of<MyItem>(context, listen: false);

          if (provider.hasRole(widget.role) ||
              provider.length <= 2 && provider.length >= 1) {
            if (provider.myItems.first == null) {
              provider.add(widget.role);
            }
            submitOnboarding();
            Navigator.pushNamed(context, CongratsCard.routeName);
            print('Onboarding submitted');
          } else if (provider.myItems.first != null) {
            provider.remove(widget.role);
            // ignore: unnecessary_null_comparison
          } else {
            provider.add(widget.role);
            print(provider.length);
          }

          Navigator.pushNamed(context, CongratsCard.routeName);
          print('Onboarding submitted');
        },
      )
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset("assets/images/navbar_logo.svg",
            semanticsLabel: 'Confirmation SVG'),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Container(
              color: AppColors.backgroundColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Onboarding Form',
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 31, right: 31),
                    child: PageIndicator(
                        currentPage: currentPage + 1, totalPages: 8),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 31, right: 31, top: 20),
                    child: SizedBox(
                      height: 550,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(
                            () {
                              currentPage = index;
                            },
                          );
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: pages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return pages[index % pages.length];
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomFooter(),
    );
  }
}
