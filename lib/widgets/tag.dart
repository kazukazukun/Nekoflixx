import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Tagg to show details in details screen
class Tag extends StatelessWidget {
  const Tag({
    Key? key,
    required this.txt,
    required this.content,
  }) : super(key: key);

  final String txt;
  final String content;

  @override
  Widget build(BuildContext context) {
    String contentValue = content.isNotEmpty ? ": $content" : "";
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 235, 131, 131)),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Text(
            txt,
            style:
                GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Text(
            contentValue,
            style:
                GoogleFonts.roboto(fontSize: 17, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
