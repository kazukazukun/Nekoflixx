import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nekoflixx/models/genre_provider.dart';
import 'package:nekoflixx/models/movie.dart';
import 'package:nekoflixx/widgets/details_app_bar.dart';
import 'package:nekoflixx/widgets/tag.dart';
import 'package:provider/provider.dart';

// Shows movie details
class MovieDetails extends StatefulWidget {
  final Movie movie;

  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    // Fetch the GenreProvider at the beginning of the build method
    final genreProvider = Provider.of<GenreProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        leading: null, // Disable default back button
      ),
      body: CustomScrollView(
        slivers: [
          DetailsAppBar(backdropPath: widget.movie.posterPath),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: GoogleFonts.belleza(
                        fontSize: 45, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 26),
                  Text("Overview",
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 16),
                  Text(widget.movie.overview,
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
                      itemCount: widget.movie.genreIds.length,
                      itemBuilder: (context, index) {
                        // Use the genreProvider fetched at the beginning of the build method
                        final genreName = genreProvider
                            .getGenreFromId(widget.movie.genreIds[index]);

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
                      Tag(
                          txt: "Release Date",
                          content: widget.movie.releaseDate),
                      Tag(
                          txt: "Rating",
                          content:
                              "${widget.movie.voteAverage.toStringAsFixed(1)}/10"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
