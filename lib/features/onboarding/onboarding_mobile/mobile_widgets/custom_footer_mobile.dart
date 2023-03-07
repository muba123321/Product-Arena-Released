import 'package:delta_team/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      padding: const EdgeInsets.all(2.0),
      width: double.infinity,
      height: 55,
      color: AppColors.secondaryColor3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.topCenter,
              height: mediaQuery.size.height * 0.20,
              width: mediaQuery.size.width * 0.18,
              child: GestureDetector(
                key: const Key('PrivacyTextKey'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(
                        label: 'Arena',
                        onPressed: () {
                          // Code to execute.
                        },
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              // color: Colors.white,
                            ),
                            child: SvgPicture.asset(
                                "assets/images/navbar_logo.svg",
                                semanticsLabel: 'Confirmation SVG'),
                          ),
                          const Text(
                              textAlign: TextAlign.center,
                              'Take it Easy\nAnother Day!'),
                        ],
                      ),
                      duration: const Duration(milliseconds: 1500),
                      width: 280.0, // Width of the SnackBar.
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, // Inner padding for SnackBar content.
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                },
                child: Text(
                  "Privacy",
                  style: GoogleFonts.notoSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.footerColor),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.bottomCenter,
              height: mediaQuery.size.height * 0.13,
              width: mediaQuery.size.width * 0.50,
              child: Text(
                key: const Key('CreditsTextKey'),
                "© Credits, 2023, Product Arena",
                style: GoogleFonts.notoSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.footerColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                alignment: Alignment.topCenter,
                height: mediaQuery.size.height * 0.10,
                width: mediaQuery.size.width * 0.18,
                child: GestureDetector(
                  key: const Key('TermsTextKey'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: 'Arena',
                          onPressed: () {
                            // Code to execute.
                          },
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                // color: Colors.white,
                              ),
                              child: SvgPicture.asset(
                                  "assets/images/navbar_logo.svg",
                                  semanticsLabel: 'Confirmation SVG'),
                            ),
                            const Text('Oops! Too Soon!'),
                          ],
                        ),
                        duration: const Duration(milliseconds: 1500),
                        width: 280.0, // Width of the SnackBar.
                        padding: const EdgeInsets.symmetric(
                          horizontal:
                              8.0, // Inner padding for SnackBar content.
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Terms",
                    style: GoogleFonts.notoSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.footerColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
