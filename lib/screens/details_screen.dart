import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/widgets/details_app_bar.dart';
import 'package:nekoflixx/widgets/tag.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.mediaEntity});
  final MediaEntity mediaEntity;
  @override
  Widget build(BuildContext context) {
    var description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mediaEntity.name,
          style: GoogleFonts.belleza(
            fontSize: 45,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 26,
        ),
        Text(
          "Overview",
          style: GoogleFonts.openSans(
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          mediaEntity.overview,
          style: GoogleFonts.roboto(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (mediaEntity.mediaType == "movie")
              Tag(txt: "Release date", content: mediaEntity.releaseDate)
            else
              Tag(txt: "First air date", content: mediaEntity.releaseDate),
            Tag(
              txt: "Rating",
              content: "${mediaEntity.voteAverage.toStringAsFixed(1)}/10",
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DetailsAppBar(media: mediaEntity),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: description,
            ),
          ),
        ],
      ),
    );
  }
}
