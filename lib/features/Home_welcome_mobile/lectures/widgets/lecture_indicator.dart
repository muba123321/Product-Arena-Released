import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LectureIndicator extends StatelessWidget {
  final int currentPage;
  final int lenght;

  const LectureIndicator(
      {super.key, required this.currentPage, required this.lenght});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        lenght,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: index == currentPage ? 19 : 19,
          height: 3.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == currentPage
                ? const Color(0xFF938F99)
                : const Color(0xFFCAC4D0),
          ),
        ),
      ),
    );
  }
}
