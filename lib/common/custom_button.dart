import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color;
  final Color textColor;
  final Color borderColor;

  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final BorderSide borderSide;

  const RoundedButton({
    super.key,
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
    required this.borderColor,
    this.borderRadius = 3,
    this.padding = const EdgeInsets.fromLTRB(20.0, 7.5, 20.0, 7.5),
    this.textStyle = const TextStyle(fontFamily: 'Noto Sans'),
    required this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              backgroundColor: color,
              side: borderSide,
            ),
            onPressed: press,
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.w700),
            ))),
      ),
    );
  }
}

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
