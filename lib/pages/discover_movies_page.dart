import 'package:flutter/material.dart';
import 'package:nekoflixx/api/api.dart';
import 'package:nekoflixx/models/genre.dart';
import 'package:nekoflixx/models/genre_provider.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/widgets/media_grid.dart';
import 'package:provider/provider.dart';

/// A StatefulWidget representing the page for discovering movies.
class DiscoverMoviesPage extends StatefulWidget {
  const DiscoverMoviesPage({Key? key}) : super(key: key);

  @override
  _DiscoverMoviesPageState createState() => _DiscoverMoviesPageState();
}

/// The state of the DiscoverMoviesPage.
class _DiscoverMoviesPageState extends State<DiscoverMoviesPage> {
  int _selectedGenreId = -1; // Default selected genre ID
  late Future<List<MediaEntity>>? movies;

  @override
  void initState() {
    super.initState();
    movies = fetchMoviesByGenre(_selectedGenreId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GenreProvider>(
      builder: (context, genreProvider, _) {
        final movieGenres = genreProvider.movieGenres;

        // Find the selected genre
        final selectedGenre = movieGenres.firstWhere(
          (genre) => genre.genreId == _selectedGenreId,
        );

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              TextButton(
                onPressed: () {
                  showGenreMenu(context, movieGenres);
                },
                child: Text(
                  "Genre: ${selectedGenre.genreName}", // Display the selected genre name
                  style: const TextStyle(
                    color: Color.fromARGB(255, 210, 170, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          body: FutureBuilder<List<MediaEntity>>(
            future: movies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return MediaGrid(
                    mediaEntityList:
                        snapshot.data!); // Pass the data to MediaGrid
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        );
      },
    );
  }

  /// Displays a bottom sheet menu to choose a genre.
  void showGenreMenu(BuildContext context, List<Genre> movieGenres) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: movieGenres.length,
          itemBuilder: (context, index) {
            final genre = movieGenres[index];
            return ListTile(
              title: Text(genre.genreName),
              onTap: () {
                if (_selectedGenreId != genre.genreId) {
                  setState(() {
                    _selectedGenreId =
                        genre.genreId; // Update the selected genre ID
                    movies = fetchMoviesByGenre(_selectedGenreId);
                  });
                }
                Navigator.pop(context, genre.genreId);
              },
            );
          },
        );
      },
    );
  }

  /// Fetches movies by genre from the API.
  Future<List<MediaEntity>> fetchMoviesByGenre(int genreId) async {
    try {
      return await API().getMoviesByGenre(genreId);
    } catch (e) {
      throw Exception('Failed to fetch movies: $e');
    }
  }
}
