import 'package:flutter/material.dart';
import "row_footer.dart";

import 'column_footer.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double widthImages = MediaQuery.of(context).size.width / 2.57;
    double widthLocation = MediaQuery.of(context).size.width / 3;

    bool isFooterInColumn = false;
    bool spaceText = false;

    double paddingLeft = 80;
    double paddingRight = 60;
    if (screenWidth < 1310) {
      spaceText = true;
    }

    if (screenWidth < 970) {
      isFooterInColumn = true;
      paddingLeft = 50;
      paddingRight = 50;
    }

    if (screenWidth < 420) {
      paddingLeft = 0;
      paddingRight = 0;
    }

    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Image.asset(
                "assets/images/footer_logo.png",
                width: 51.9,
                height: 39.74,
              ),
              Container(),
            ],
          ),
          const SizedBox(
            height: 44.26,
          ),
          const Divider(color: Color.fromRGBO(0, 0, 0, 0.5)),
          const SizedBox(
            height: 30.41,
          ),
          isFooterInColumn
              ? ColumnFooter(
                  widthLocation: widthLocation,
                  spaceText: spaceText,
                  widthImages: widthImages)
              : RowFooter(
                  widthLocation: widthLocation,
                  spaceText: spaceText,
                  widthImages: widthImages),
          const SizedBox(
            height: 18.22,
          ),
          const Center(
            child: Text(
              "© Credits, 2023, Product Arena",
              style: TextStyle(
                fontSize: 10,
                color: Color.fromRGBO(120, 120, 120, 0.8),
              ),
            ),
          ),
          isFooterInColumn
              ? const SizedBox(
                  height: 25,
                )
              : const SizedBox(
                  height: 51,
                ),
        ],
      ),
    );
  }
}
