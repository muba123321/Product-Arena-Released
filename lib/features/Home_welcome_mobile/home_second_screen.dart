import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:delta_team/features/Home_welcome_mobile/menu_navigation_screen.dart';
import 'package:delta_team/features/Home_welcome_mobile/welcoming_message_screen.dart';
import '../auth/login/amplify_auth.dart';
import '../auth/login/login_mobile/loginmobile_body.dart';

class HomeSecondScreen extends StatefulWidget {
  static const routeName = '/home_welcome';
  const HomeSecondScreen({super.key});
  @override
  State<HomeSecondScreen> createState() => _HomeScreenState();
}

bool _isMenuOpen = false;
bool _isBurgerIcon = true;

class _HomeScreenState extends State<HomeSecondScreen> {
  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;
    if (_isMenuOpen) {
      bodyWidget = const MyDrawer();
    } else {
      bodyWidget = const WelcomingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset("assets/images/appbar_logo.svg"),
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
                  _isMenuOpen = !_isMenuOpen;
                });
              },
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: bodyWidget,
    );
  }
}
