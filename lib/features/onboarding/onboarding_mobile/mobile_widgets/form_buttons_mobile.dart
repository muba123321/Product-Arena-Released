import 'package:delta_team/common/colors.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_models/role_mobile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final Color borderColor;
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonHeight;

  const FormButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    required this.borderColor,
    required this.onPressed,
    required this.buttonWidth,
    required this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (text == 'Back') ...[
              const Icon(
                Icons.arrow_back_ios_sharp,
                size: 18.0,
              ),
            ],
            Text(
              text,
              style: GoogleFonts.notoSans(
                  fontSize: 14, fontWeight: FontWeight.w700, color: textColor),
            )
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonHeight;
  const SubmitButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    required this.onPressed,
    required this.buttonWidth,
    required this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.notoSans(
                  fontSize: 14, fontWeight: FontWeight.w700, color: textColor),
            )
          ],
        ),
      ),
    );
  }
}

class ClearSection extends StatelessWidget {
  final TextEditingController controller;
  const ClearSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        controller.clear();
      },
      child: Text(
        "Clear selection",
        style: GoogleFonts.notoSans(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColor2,
        ),
      ),
    );
  }
}
