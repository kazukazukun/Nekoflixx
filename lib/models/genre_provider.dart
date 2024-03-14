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
    notifyListeners();
  }
}
