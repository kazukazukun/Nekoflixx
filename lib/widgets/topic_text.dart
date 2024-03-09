import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicText extends StatelessWidget {
  final String txt;
  const TopicText({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        txt,
        style: GoogleFonts.aBeeZee(fontSize: 25),
      ),
    );
  }
}
