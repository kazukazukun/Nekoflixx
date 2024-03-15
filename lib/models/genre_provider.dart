import 'package:flutter/material.dart';
import 'package:nekoflixx/api/api.dart';
import 'package:nekoflixx/models/genre.dart';

class GenreProvider extends ChangeNotifier {
  List<Genre> _movieGenres = [];
  List<Genre> _tvGenres = [];

  List<Genre> get movieGenres => _movieGenres;
  List<Genre> get tvGenres => _tvGenres;

  Future<void> fetchGenres() async {
    _movieGenres = await API().getMovieGenres();
    _tvGenres = await API().getTvGenres();
    if (_movieGenres[0].genreId != -1) {
      _movieGenres.insert(0, Genre(genreId: -1, genreName: 'All'));
    }
    if (_tvGenres[0].genreId != -1) {
      _tvGenres.insert(0, Genre(genreId: -1, genreName: 'All'));
    }
    notifyListeners();
  }

  String getGenreFromId(int genreId) {
    String genreName = 'Unknown';
    for (var genre in _movieGenres) {
      if (genre.genreId == genreId) {
        genreName = genre.genreName;
        break;
      }
    }
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
