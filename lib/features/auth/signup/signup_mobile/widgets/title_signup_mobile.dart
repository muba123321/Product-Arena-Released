import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleSignUpMobile extends StatelessWidget {
  const TitleSignUpMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Column(
        children: [
          Text(
            "Welcome to",
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w400,
              fontSize: 32,
            ),
          ),
          Text(
            "Product Arena",
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}
