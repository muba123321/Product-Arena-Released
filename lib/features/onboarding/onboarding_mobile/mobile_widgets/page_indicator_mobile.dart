import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "$currentPage/$totalPages",
              style: GoogleFonts.notoSans(
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalPages, (index) {
              return Container(
                width: 30.0,
                height: 5.0,
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                    color: index < currentPage
                        ? const Color(0xFF938F99)
                        : const Color(0xFFCAC4D0),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(14.0))),
              );
            }),
          ),
        ],
      ),
    );
  }
}
