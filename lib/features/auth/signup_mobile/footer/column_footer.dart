import 'package:flutter/material.dart';

class ColumnFooter extends StatelessWidget {
  final double widthLocation;
  final bool spaceText;
  final double widthImages;
  const ColumnFooter(
      {super.key,
      required this.widthLocation,
      required this.spaceText,
      required this.widthImages});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_pin,
              size: 20,
            ),
            const SizedBox(
              width: 11.25,
            ),
            spaceText
                ? const Text(
                    "Put Mladih Muslimana 2,\nCity Gardens Residence,\n71 000 Sarajevo, Bosnia and Herzegovina14425 Falconhead Blvd, Bee Cave,\nTX 78738, United States",
                    style: TextStyle(fontSize: 10))
                : const Text(
                    "Put Mladih Muslimana 2, City Gardens Residence, 71 000 Sarajevo, Bosnia and Herzegovina14425 Falconhead Blvd, Bee Cave, TX 78738, United States",
                    style: TextStyle(fontSize: 10),
                  ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.mail,
              size: 20,
            ),
            SizedBox(
              width: 11.25,
            ),
            Text(
              "hello@tech387.com                                      ",
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/facebook.png",
                  width: 37.5,
                  height: 37.37,
                ),
                const SizedBox(
                  width: 18.5,
                ),
                Image.asset(
                  "assets/images/instagram.png",
                  width: 37.5,
                  height: 37.37,
                ),
                const SizedBox(
                  width: 18.5,
                ),
                Image.asset(
                  "assets/images/linkedin.png",
                  width: 37.5,
                  height: 37.37,
                ),
                const SizedBox(
                  width: 18.5,
                ),
                Image.asset(
                  "assets/images/tech387.png",
                  width: 37.5,
                  height: 37.37,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Privacy",
                style: TextStyle(
                    fontSize: 10, color: Color.fromRGBO(120, 120, 120, 1))),
            SizedBox(
              width: 45,
            ),
            Text(
              "Terms",
              style: TextStyle(
                  fontSize: 10, color: Color.fromRGBO(120, 120, 120, 1)),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
