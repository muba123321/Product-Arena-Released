// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final Widget action;
  final Widget optionalAction;

  const CustomAppBar(
      {super.key,
      this.title = '',
      required this.leading,
      required this.action,
      this.optionalAction = const SizedBox(width: 0, height: 0)});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double photoWidth = 170;

    if (MediaQuery.of(context).size.width < 1000) {
      photoWidth = 150;
    }
    if (MediaQuery.of(context).size.width < 700) {
      photoWidth = 120;
    }
    return Container(
      width: width,
      height: MediaQuery.of(context).size.height / 11.428,
      padding: EdgeInsets.only(
          left: (50 / 1440) * width, right: (50 / 1440) * width),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading == null
              ? SizedBox(width: (170 / 1440) * width, height: 34.0)
              : SizedBox(
                  width: photoWidth,
                  height: 34.0,
                  child: leading,
                ),
          SizedBox(
            width: (10 / 1440) * width,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: const Color(0xFF000000),
              ),
            ),
          ),
          optionalAction == null
              ? SizedBox(width: (92 / 1440) * width, height: 34.0)
              : SizedBox(
                  width: (92 / 1440) * width,
                  height: 34.0,
                  child: optionalAction,
                ),
          action == null
              ? SizedBox(width: (92 / 1440) * width, height: 34.0)
              : SizedBox(
                  width: 92,
                  height: 34.0,
                  child: action,
                ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;
  final Widget action;
  final Widget optionalAction;

  const HomeAppBar(
      {super.key,
      this.title = '',
      required this.leading,
      required this.action,
      this.optionalAction = const SizedBox(width: 0, height: 0)});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 70.0,
      padding: EdgeInsets.only(
          left: (50 / 1440) * width, right: (50 / 1440) * width),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading == null
              ? SizedBox(width: (170 / 1440) * width, height: 34.0)
              : SizedBox(
                  width: (170 / 1440) * width,
                  height: 34.0,
                  child: leading,
                ),
          Container(
            // height: 22.0,
            // width: (40 / 1440) * width,
            alignment: Alignment.center,
            child: Text(
              title,
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w400,
                fontSize: (16 / 1440) * width,
                color: const Color(0xFF000000),
              ),
            ),
          ),
          Row(children: [
            optionalAction == null
                ? SizedBox(width: (92 / 1440) * width, height: 34.0)
                : SizedBox(
                    width: (92 / 1440) * width,
                    height: 34.0,
                    child: optionalAction,
                  ),
            SizedBox(
              width: (10 / 1440) * width,
            ),
            action == null
                ? SizedBox(width: (92 / 1440) * width, height: 34.0)
                : SizedBox(
                    width: (92 / 1440) * width,
                    height: 34.0,
                    child: action,
                  ),
          ])
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
