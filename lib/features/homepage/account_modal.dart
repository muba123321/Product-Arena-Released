import 'package:amplify_core/amplify_core.dart';
import 'package:delta_team/features/auth/login/login_web/loginweb_body.dart';
import 'package:delta_team/features/homepage/contact_me_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login/providers/userAttributesProvider.dart';
import 'homepage_sidebar.dart';

class AccountModal extends StatefulWidget {
  const AccountModal({super.key});

  @override
  State<AccountModal> createState() => _AccountModalState();
}

class _AccountModalState extends State<AccountModal> {
  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

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

  String name = '';
  String surname = '';
  String email = '';

  Future<void> signOutUser() async {
    try {
      final res = await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthPositioned = MediaQuery.of(context).size.width * 0.15;
    if (MediaQuery.of(context).size.width < 1301) {
      widthPositioned = MediaQuery.of(context).size.width * 0.20;
    }
    if (MediaQuery.of(context).size.width < 1000) {
      widthPositioned = MediaQuery.of(context).size.width * 0.25;
    }
    if (MediaQuery.of(context).size.width < 800) {
      widthPositioned = MediaQuery.of(context).size.width * 0.30;
    }
    if (MediaQuery.of(context).size.width < 660) {
      widthPositioned = MediaQuery.of(context).size.width * 0.40;
    }
    if (MediaQuery.of(context).size.width < 500) {
      widthPositioned = MediaQuery.of(context).size.width * 0.50;
    }

    return Positioned(
      top: 64,
      right: 106,
      child: Container(
        width: widthPositioned,
        height: MediaQuery.of(context).size.height * 0.46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/product_arena_modal.png",
                  width: double.infinity,
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/images/profile_icon.png",
                  height: 10,
                  width: 10,
                ),
              ),
              Center(
                child: Text(
                  "$name $surname",
                  style: GoogleFonts.outfit(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  email,
                  style: GoogleFonts.notoSans(fontSize: 16),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              const SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 17, left: 17),
                child: Text(
                  "My interests:",
                  style: GoogleFonts.notoSans(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: varijablaRola.length,
                  itemBuilder: (context, index) {
                    var res = varijablaRola[index];
                    String image = "assets/images/backendBijela.png";

                    String str = "";

                    if (res == "backend") {
                      str = "Backend Development";
                      image = "assets/images/backendBijela.png";
                    }
                    if (res == "fullstack") {
                      str = "Fullstack Development";
                      image = "assets/images/fullstackBijela.png";
                    }
                    if (res == "productManager") {
                      str = "Project Manager";
                      image = "assets/images/homepage_manager.png";
                    }
                    if (res == "uiux") {
                      str = "UI/UX Design";
                      image = "assets/images/homepageui.png";
                    }
                    if (res == "qa") {
                      str = "QA";
                      image = "assets/images/homepageqa.png";
                    }
                    return Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 17, left: 17),
                            child: Text(
                              str,
                              style: GoogleFonts.notoSans(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 14,
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Center(
                child: ElevatedButton(
                  key: const Key("signout_key"),
                  onPressed: () async {
                    setState(() {
                      showModal = false;
                      varijablaRola = [];
                    });
                    await FlutterSession().set("token", "");
                    signOutUser();
                    Navigator.pushNamed(context, LoginScreenWeb.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  child: const Text(
                    "Log out",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
