import 'package:flutter/material.dart';
import 'package:nekoflixx/api/api.dart';
import 'package:nekoflixx/models/genre.dart';

/// A provider class responsible for managing movie and TV genres.
class GenreProvider extends ChangeNotifier {
  /// List of movie genres.
  List<Genre> _movieGenres = [];

  /// List of TV genres.
  List<Genre> _tvGenres = [];

  /// Getter for retrieving movie genres.
  List<Genre> get movieGenres => _movieGenres;

  /// Getter for retrieving TV genres.
  List<Genre> get tvGenres => _tvGenres;

  /// Fetches movie and TV genres from the API.
  Future<void> fetchGenres() async {
    // Fetch movie genres
    _movieGenres = await API().getMovieGenres();
    // Fetch TV genres
    _tvGenres = await API().getTvGenres();

    // Insert 'All' genre at index 0 if not present
    if (_movieGenres[0].genreId != -1) {
      _movieGenres.insert(0, Genre(genreId: -1, genreName: 'All'));
    }
    if (_tvGenres[0].genreId != -1) {
      _tvGenres.insert(0, Genre(genreId: -1, genreName: 'All'));
    }

    // Notify listeners of any changes
    notifyListeners();
  }

  /// Retrieves the genre name from its ID.
  String getGenreFromId(int genreId) {
    String genreName = 'Unknown';

    // Search for genre in movie genres
    for (var genre in _movieGenres) {
      if (genre.genreId == genreId) {
        genreName = genre.genreName;
        break;
      }
    }

    // If genre not found in movie genres, search in TV genres
    if (genreName == 'Unknown') {
      for (var genre in _tvGenres) {
        if (genre.genreId == genreId) {
          genreName = genre.genreName;
          break;
        }
      }
    }

    return genreName;
  }
}
