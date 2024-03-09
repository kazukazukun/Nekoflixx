import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/models/media_entity.dart';

class API {
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _apiKey = Constants.apiKey;

  Future<List<MediaEntity>> _fetchMedia(String endPoint, String ending) async {
    final response = await http
        .get(Uri.parse("$_baseUrl/$endPoint?api_key=$_apiKey$ending"));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body)["results"] as List;
      return decodedData
          .map((mediaEntity) => MediaEntity.fromJson(mediaEntity))
          .toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }

  Future<List<MediaEntity>> getNowPlayingMovies() async {
    return _fetchMedia("movie/now_playing", "");
  }

  Future<List<MediaEntity>> getTvTonights() async {
    return _fetchMedia("tv/airing_today", "");
  }

  Future<List<MediaEntity>> getBestMoviesThisYear() async {
    return _fetchMedia("discover/movie",
        "&primary_release_year=${DateTime.now().year.toString()}&sort_by=popularity.desc");
  }

  Future<List<MediaEntity>> getTopGrossingMovies() async {
    return _fetchMedia("discover/movie", "&sort_by=revenue.desc");
  }

  Future<List<MediaEntity>> getSearchedList(String query) async {
    return _fetchMedia("search/multi", "&query=$query");
  }
}
