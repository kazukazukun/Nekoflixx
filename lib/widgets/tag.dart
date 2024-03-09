import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.txt,
    required this.content,
  });

  final String txt;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 235, 131, 131)),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Text(
            "$txt: ",
            style:
                GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            content,
            style:
                GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}