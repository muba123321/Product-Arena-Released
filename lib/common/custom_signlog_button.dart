import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Function buttonFunction;
  final Widget content;

  const CustomButton({
    Key? key,
    required this.content,
    required this.buttonFunction,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color, minimumSize: const Size(double.infinity, 40)),
      onPressed: () {
        buttonFunction();
      },
      child: content,
    );
  }
}
