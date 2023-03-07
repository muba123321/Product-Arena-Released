import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/auth/login/amplify_auth.dart';
import 'features/auth/login/login_mobile/loginmobile_body.dart';

class HomeScreenMobile extends StatelessWidget {
  static const routeName = '/homemobile';
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          key: const Key('routed_to_LoadingScreen1'),
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                  try {
                    signOutCurrentUser(null, null, context);
                    safePrint('User Signed Out');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreenMobile()),
                    );
                  } on AmplifyException catch (e) {
                    print(e.message);
                  }
                });
              },
              child: Image.asset('assets/images/logotop.png'),
            ),
            Text('HomePage',
                style: GoogleFonts.notoSans(
                  fontSize: 32.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ))
          ],
        ),
      ),
    );
  }
}
