import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/amplifyconfiguration.dart';
import 'package:delta_team/features/auth/login/providers/userAttributesProvider.dart';
import 'package:delta_team/features/homepage/contact_me_screen.dart';
import 'package:delta_team/features/homepage/homepage_sidebar.dart';
import 'package:delta_team/features/homepage/homescreen.dart';
import 'package:delta_team/features/homepage/lectures.dart';
import 'package:delta_team/features/homepage/provider/authProvider.dart';
import 'package:delta_team/features/homepage/provider/isNavbarOpenedProvider.dart';
import 'package:delta_team/features/homepage/provider/selectedRoleProvider.dart';
import 'package:delta_team/features/homepage/provider/showModalProvider.dart';
import 'package:delta_team/features/homepage/provider/titleProvider.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_widgets/congratulations_card_mobile.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_widgets/loading_Oboading%20mobile.dart';

import 'package:delta_team/features/onboarding/onboarding_web/onboardingScreen.dart';
import 'package:delta_team/home_mobile.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/Home_welcome_mobile/contact us/auth_provider.dart';
import 'features/Home_welcome_mobile/contact us/contact-us_mobile.dart';
import 'features/Home_welcome_mobile/lectures/lectures_screen.dart';
import 'features/Home_welcome_mobile/lectures/single_lecture_screen.dart';
import 'features/Home_welcome_mobile/welcoming_message_screen.dart';
import 'features/auth/login/loadingScreens/loadingscreen_mobile.dart';
import 'features/auth/login/loadingScreens/loadingscreen_web.dart';
import 'features/auth/login/login_mobile/loginmobile_body.dart';
import 'features/auth/login/login_mobile/providers/userAttributesProviderMobile.dart';
import 'features/auth/login/login_mobile/providers/userLecturesProviderMobile.dart';
import 'features/auth/login/login_web/loginweb_body.dart';
import 'features/auth/login/providers/userLecturesProvider.dart';
import 'features/auth/signup/provider/Web_auth_provider.dart';
import 'features/auth/signup/provider/auth_provider_mobile.dart';
import 'features/auth/signup/signup_mobile/screens/confirmation_message_mobile.dart';
import 'features/auth/signup/signup_mobile/screens/confirmation_screen_mobile.dart';
import 'features/auth/signup/signup_mobile/screens/redirecting_screen_mobile.dart';
import 'features/auth/signup/signup_mobile/screens/signupScreen_mobile.dart';
import 'features/auth/signup/signup_mobile/widgets/confirmationContainers.dart';
import 'features/auth/signup/signup_web/Web_emailVerified_screen.dart';
import 'features/auth/signup/signup_web/Web_loadingPage.dart';
import 'features/auth/signup/signup_web/Web_signupScreen.dart';
import 'features/auth/signup/signup_web/Web_signupVerification_Screen.dart';
import 'features/homepage/homepage.dart';
import 'features/homepage/homepage_video_screen.dart';
import 'features/homepage/provider/youtube_link_provider.dart';
import 'features/homepage/recentLectures.dart';
import 'features/onboarding/onboarding_mobile/mobile_models/role_mobile.dart';
import 'features/onboarding/onboarding_mobile/mobile_providers/answer_mobile.dart';
import 'features/onboarding/onboarding_mobile/mobile_providers/emailpasswordproviders_mobile.dart';
import 'features/onboarding/onboarding_mobile/mobile_providers/error_provider_mobile.dart';
import 'features/onboarding/onboarding_mobile/mobile_providers/provider_mobile.dart';
import 'features/onboarding/onboarding_mobile/mobile_providers/role_provider_mobile.dart';
import 'features/onboarding/onboarding_mobile/onboarding_screen_mobile.dart';
import 'features/onboarding/onboarding_mobile/welcome_page_mobile.dart';
import 'features/onboarding/onboarding_web/congratulation_web.dart';
import 'features/onboarding/onboarding_web/errorMsg-web.dart';
import 'features/onboarding/onboarding_web/loadingpageOnboarding_web.dart';
import 'features/onboarding/onboarding_web/modelRole.dart';
import 'features/onboarding/onboarding_web/modelmyItem.dart';
import 'features/onboarding_web/provider/emailPasswProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    final authPlugin = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([authPlugin, api]);
    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  dynamic token = '';

  Future<void> _loadPrefs() async {
    dynamic tokenStr = await FlutterSession().get("token");

    setState(() {
      token = tokenStr;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyEmailWeb()),
        ChangeNotifierProvider(create: (_) => MyEmail()),
        ChangeNotifierProvider<MyProvider>(
          create: (_) => MyProvider(),
        ),
        ChangeNotifierProvider<AnswerProvider>(
          create: (_) => AnswerProvider(),
        ),
        ChangeNotifierProvider<ErrorMessage>(
          create: (_) => ErrorMessage(),
        ),
        ChangeNotifierProvider<MyItem>(
          create: (_) => MyItem(),
        ),
        ChangeNotifierProvider(create: (_) => ErrorMessageWeb()),
        ChangeNotifierProvider(
          create: (_) => MyItemWeb(),
        ),
        ChangeNotifierProvider(
          create: (_) => YoutubeLinkProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TitleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactWeb(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmailPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShowModal(),
        ),
        ChangeNotifierProvider(
          create: (_) => LecturesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SelectedRoleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserAttributesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavbarOpened(),
        ),
        ChangeNotifierProvider(
          create: (_) => LecturesProviderMobile(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserAttributesProviderMobile(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmailPasswordProviderMobile(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProviderContact(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: InputDecorationTheme(
            errorStyle: GoogleFonts.notoSans(
              fontSize: 10,
              color: const Color.fromRGBO(179, 38, 30, 1),
              fontWeight: FontWeight.w400,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(179, 38, 30, 1),
              ),
            ),
          ),
        ),
        home: defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android
            ? const SignupScreenMobile()
            : const LoginScreenWeb(),

        // LoginScreenWeb(),
        routes: {
          LoginScreenWeb.routeName: (context) => const LoginScreenWeb(),
          LoginScreenMobile.routeName: (context) => const LoginScreenMobile(),
          HomeScreenMobile.routeName: (context) => const HomeScreenMobile(),
          LoadingScreenMobile.routeName: (context) =>
              const LoadingScreenMobile(),
          '/loadingScreenWeb': (context) => const LoadingScreenWeb(),
          '/signup': (context) => const SignupScreenMobile(),
          '/confirmation': (context) => const ConfirmationScreen(),
          '/confirmationMessage': (context) => const ConfirmationMessage(),
          '/redirectingScreen': (context) => const RedirectingScreen(),
          '/OnboardingredirectingScreen': (context) =>
              const Onboardingredirecting(),
          WelcomePage.routeName: (context) => const WelcomePage(),
          OnboardingScreen.routeName: (context) =>
              OnboardingScreen(role: listaRole.first),
          CongratsCard.routeName: (context) => const CongratsCard(),
          CongratsCardWeb.routeName: (context) => const CongratsCardWeb(),
          '/onboardingweb': (context) => OnboardingWeb(
                role: listaRola.first,
              ),
          '/loadingOnboarding': (context) => const LoadingPageOnboarding(),
          '/signupWeb': (context) => const SignUpScreenWeb(),
          '/confirmationWeb': (context) => const SignupVerificationScreen(),
          '/confirmationMessageWeb': (context) => const EmailVerifiedScreen(),
          '/loadingPageSignup': (context) => const LoadingPage(),
          '/homepage': (context) => const HomePage(),
          '/lecturesPage': (context) => const LecturesPage(),
          '/homepagevideo': (context) => const HomePageVideoScreen(),
          '/contactUs': (context) => const ContactMeScreen(),
          '/recentLectures': (context) => const RecentLectures(),
          '/homescreen': (context) => const HomeScreen(),
          '/homepage_sidebar': (context) => const Sidebar(),
          WelcomingScreen.routeName2: (context) => const WelcomingScreen(),
        },
      ),
    );
  }
}
