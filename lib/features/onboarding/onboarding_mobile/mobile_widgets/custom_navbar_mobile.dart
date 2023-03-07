import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.10,
      width: mediaQuery.size.width * 0.30,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: SvgPicture.asset('assets/images/pa_logo_white.svg'),
    );
  }
}
