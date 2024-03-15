import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nekoflixx/models/genre_provider.dart';
import 'package:nekoflixx/models/tv.dart';
import 'package:nekoflixx/widgets/details_app_bar.dart';
import 'package:nekoflixx/widgets/tag.dart';
import 'package:provider/provider.dart';

class TvDetails extends StatefulWidget {
  final TV tv;

  const TvDetails({Key? key, required this.tv}) : super(key: key);

  @override
  State<TvDetails> createState() => _TvDetailsState();
}

class _TvDetailsState extends State<TvDetails> {

  @override
  Widget build(BuildContext context) {
    // Fetch the GenreProvider at the beginning of the build method
    final genreProvider = Provider.of<GenreProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tv.title),
        leading: null, // Disable default back button
        actions: [
          // Placeholder for watchlist button or other actions
        ],
      ),
      body: CustomScrollView(
        slivers: [
          DetailsAppBar(backdropPath: widget.tv.posterPath),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tv.title,
                    style: GoogleFonts.belleza(
                        fontSize: 45, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 26),
                  Text("Overview",
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 16),
                  Text(widget.tv.overview,
                      style: GoogleFonts.roboto(
                          fontSize: 17, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Text("Genres",
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40, // Set the height for the genre tags
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.tv.genreIds.length,
                      itemBuilder: (context, index) {
                        // Use the genreProvider fetched at the beginning of the build method
                        final genreName = genreProvider
                            .getGenreFromId(widget.tv.genreIds[index]);

                        return Tag(
                          txt: genreName,
                          content: "",
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Tag(txt: "Release Date", content: widget.tv.firstAirDate),
                      Tag(
                          txt: "Rating",
                          content:
                              "${widget.tv.voteAverage.toStringAsFixed(1)}/10"),
                      // You can add more tags for other details if needed
                    ],
                  ),
                  // Here you can add more information about the movie using Text widgets
                ],
              ),
            ),
          ),
          // Add more slivers if needed
        ],
      ),
    );
  }
}
