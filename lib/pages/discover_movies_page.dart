import 'package:flutter/material.dart';
import 'package:nekoflixx/models/genre_provider.dart';
import 'package:provider/provider.dart';

class DiscoverMoviesPage extends StatelessWidget {
  const DiscoverMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GenreProvider>(
      builder: (context, genreProvider, _) {
        final movieGenres = genreProvider.movieGenres;
        // Use movieGenres list here
        return Container(); // Replace with your actual UI
      },
    );
  }
}
