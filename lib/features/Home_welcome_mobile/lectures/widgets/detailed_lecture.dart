import 'package:delta_team/features/Home_welcome_mobile/lectures/widgets/lecture_video.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailedLecture extends StatefulWidget {
  final String name;
  final String contentLink;
  final String description;
  final int index;
  const DetailedLecture({
    super.key,
    required this.index,
    required this.name,
    required this.contentLink,
    required this.description,
  });

  @override
  State<DetailedLecture> createState() => _DetailedLectureState();
}

class _DetailedLectureState extends State<DetailedLecture> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(top: 22.0),
          child: Text(
            '${widget.index + 1}. ' + widget.name,
            style: GoogleFonts.notoSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF000000),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: LectureVideo(contentLink: widget.contentLink),
        ),
        Container(
          padding: const EdgeInsets.only(top: 18),
          child: Text(
            widget.description,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF000000),
            ),
          ),
        )
      ],
    );
    ;
  }
}
