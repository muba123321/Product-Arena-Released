import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LectureCard extends StatelessWidget {
  final String name;
  final String imageSrc;

  const LectureCard({
    super.key,
    required this.name,
    required this.imageSrc,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.black, width: 0.5)),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => const SingleLectureScreen()));
        },
        child: Row(
          children: [
            SizedBox(
              width: mediaQuery.width * 0.3,
              height: mediaQuery.height * 0.1,
              child: Image.network(
                imageSrc,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: mediaQuery.width * 0.4,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 7,
                top: 5,
              ),
              child: Text(
                name,
                maxLines: 2,
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.clip,
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            Container(
              width: mediaQuery.width * 0.1,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(
                left: 7,
                top: 5,
              ),
              child: SvgPicture.asset('assets/images/arrow_lecture.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
