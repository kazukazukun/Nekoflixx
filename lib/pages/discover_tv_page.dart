import 'package:flutter/material.dart';
import 'package:nekoflixx/api/api.dart';
import 'package:nekoflixx/models/genre.dart';
import 'package:nekoflixx/models/genre_provider.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/widgets/media_grid.dart';
import 'package:provider/provider.dart';

/// A page to discover TV shows.
class DiscoverTvPage extends StatefulWidget {
  const DiscoverTvPage({Key? key}) : super(key: key);

  @override
  _DiscoverTvPage createState() => _DiscoverTvPage();
}

class _DiscoverTvPage extends State<DiscoverTvPage> {
  int _selectedGenreId = -1; // Default selected genre ID
  late Future<List<MediaEntity>>? tvs;

  @override
  void initState() {
    super.initState();
    // Fetch TV shows by the default selected genre ID
    tvs = fetchTvsByGenre(_selectedGenreId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GenreProvider>(
      builder: (context, genreProvider, _) {
        final tvGenres = genreProvider.tvGenres;

        // Find the selected genre
        final selectedGenre = tvGenres.firstWhere(
          (genre) => genre.genreId == _selectedGenreId,
        );

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              TextButton(
                onPressed: () {
                  showGenreMenu(context, tvGenres);
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
            future: tvs,
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

  /// Displays a bottom sheet with TV genres to choose from.
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
                    tvs = fetchTvsByGenre(_selectedGenreId);
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

  /// Fetches TV shows by the provided genre ID.
  Future<List<MediaEntity>> fetchTvsByGenre(int genreId) async {
    try {
      return await API().getTvsByGenre(genreId);
    } catch (e) {
      throw Exception('Failed to fetch TV shows: $e');
    }
  }
}
