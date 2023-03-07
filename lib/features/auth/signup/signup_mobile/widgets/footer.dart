import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  key: const Key("privacyKey"),
                  child: Text("Privacy",
                      style: GoogleFonts.notoSans(
                        fontSize: 10,
                        color: const Color.fromRGBO(120, 120, 120, 1),
                      )),
                ),
                GestureDetector(
                  key: const Key("termsKey"),
                  child: Text("Terms",
                      style: GoogleFonts.notoSans(
                        fontSize: 10,
                        color: const Color.fromRGBO(120, 120, 120, 1),
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text("© Credits, 2023, Product Arena",
                  style: GoogleFonts.notoSans(
                    fontSize: 10,
                    color: const Color.fromRGBO(120, 120, 120, 1),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
