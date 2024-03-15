import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/models/actor.dart';
import 'package:nekoflixx/models/genre.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/models/movie.dart';
import 'package:nekoflixx/models/tv.dart';

class API {
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _apiKey = Constants.apiKey;

  Future<List<MediaEntity>> _fetchMedia(
      String endPoint, String ending, String mediaType) async {
    final response = await http
        .get(Uri.parse("$_baseUrl/$endPoint?api_key=$_apiKey$ending"));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body)["results"] as List;
      List<MediaEntity> mediaList = decodedData
          .map((mediaEntity) => MediaEntity.fromJson(mediaEntity))
          .toList();
      if (mediaType.isNotEmpty) {
        for (var media in mediaList) {
          media.mediaType = mediaType;
        }
      }
      return mediaList;
    } else {
      return [];
    }
  }

  Future<List<MediaEntity>> _fetchCastMedia(
      String endPoint, String ending, String mediaType) async {
    final response = await http
        .get(Uri.parse("$_baseUrl/$endPoint?api_key=$_apiKey$ending"));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body)["cast"] as List;
      List<MediaEntity> mediaList = decodedData
          .map((mediaEntity) => MediaEntity.fromJson(mediaEntity))
          .toList();
      if (mediaType.isNotEmpty) {
        for (var media in mediaList) {
          media.mediaType = mediaType;
        }
      }
      return mediaList;
    } else {
      return [];
    }
  }

  Future<List<Genre>> _fetchGenres(String endPoint, String ending) async {
    final response = await http
        .get(Uri.parse("$_baseUrl/$endPoint?api_key=$_apiKey$ending"));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body)["genres"] as List;
      return decodedData.map((genres) => Genre.fromJson(genres)).toList();
    } else {
      return [];
    }
  }

  Future<Actor> _fetchActorDetails(String endPoint, String ending) async {
    final response = await http
        .get(Uri.parse("$_baseUrl/$endPoint?api_key=$_apiKey$ending"));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      return Actor.fromJson(decodedData);
    } else {
      throw Exception("Failed to load actor details");
    }
  }

  Future<Movie> _fetchMovieDetails(String endPoint, String ending) async {
    final response = await http
        .get(Uri.parse("$_baseUrl/$endPoint?api_key=$_apiKey$ending"));

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      return Movie.fromJson(decodedData);
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  Future<TV> _fetchTvDetails(String endPoint, String ending) async {
    final response = await http
        .get(Uri.parse("$_baseUrl/$endPoint?api_key=$_apiKey$ending"));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      return TV.fromJson(decodedData);
    } else {
      throw Exception("Failed to load TV details");
    }
  }

  Future<List<MediaEntity>> getNowPlayingMovies() async {
    return _fetchMedia("movie/now_playing", "", "movie");
  }

  Future<List<MediaEntity>> getTvTonights() async {
    return _fetchMedia("tv/airing_today", "", "tv");
  }

  Future<List<MediaEntity>> getBestMoviesThisYear() async {
    return _fetchMedia(
        "discover/movie",
        "&primary_release_year=${DateTime.now().year.toString()}&sort_by=popularity.desc",
        "movie");
  }

  Future<List<MediaEntity>> getTopGrossingMovies() async {
    return _fetchMedia("discover/movie", "&sort_by=revenue.desc", "movie");
  }

  Future<List<MediaEntity>> getSearchedList(String query) async {
    return _fetchMedia("search/multi", "&query=$query", "");
  }

  Future<List<MediaEntity>> getSimilarMovies(int movieID) async {
    return _fetchMedia("movie/$movieID/similar", "", "movie");
  }

  Future<List<MediaEntity>> getSimilarTvs(int tvID) async {
    return _fetchMedia("tv/$tvID/similar", "", "tv");
  }

  Future<List<MediaEntity>> getMovieByID(int movieID) async {
    return _fetchMedia("movie/$movieID", "", "movie");
  }

  Future<List<MediaEntity>> getTvByID(int tvID) async {
    return _fetchMedia("tv/$tvID", "", "tv");
  }

  Future<List<Genre>> getMovieGenres() async {
    return _fetchGenres("genre/movie/list", "");
  }

  Future<List<Genre>> getTvGenres() async {
    return _fetchGenres("genre/tv/list", "");
  }

  Future<List<MediaEntity>> getMoviesByGenre(int genreID) async {
    if (genreID == -1) {
      return _getMoviesWithAllGenres();
    }
    return _fetchMedia("/discover/movie",
        "&with_genres=$genreID&sort_by=popularity.desc", "movie");
  }

  Future<List<MediaEntity>> getTvsByGenre(int genreID) async {
    if (genreID == -1) {
      return _getTvsWithAllGenres();
    }
    return _fetchMedia(
        "/discover/tv", "&with_genres=$genreID&sort_by=popularity.desc", "tv");
  }

  Future<List<MediaEntity>> _getMoviesWithAllGenres() async {
    return _fetchMedia("/discover/movie", "&sort_by=popularity.desc", "movie");
  }

  Future<List<MediaEntity>> _getTvsWithAllGenres() async {
    return _fetchMedia("/discover/tv", "&sort_by=popularity.desc", "tv");
  }

  Future<Actor> getActorDetails(int id) async {
    return _fetchActorDetails("person/$id", "");
  }

  Future<Movie> getMovieDetails(int id) async {
    return _fetchMovieDetails("movie/$id", "");
  }

  Future<TV> getTvDetails(int id) async {
    return _fetchTvDetails("tv/$id", "");
  }

  Future<List<MediaEntity>> getMoviesByActor(String query) async {
    String? actorId = await _fetchActorIdByName(query);
    return _fetchCastMedia("/person/$actorId/movie_credits", "", "movie");
  }

  Future<List<MediaEntity>> geTvByActor(String query) async {
    String? actorId = await _fetchActorIdByName(query);
    return _fetchCastMedia("/person/$actorId/tv_credits", "", "tv");
  }

  Future<String?> _fetchActorIdByName(String query) async {
    final response = await http.get(
        Uri.parse('$_baseUrl/search/person?api_key=$_apiKey&query=$query'));
    if (response.statusCode == 200) {
      final results = json.decode(response.body)['results'];
      if (results.isNotEmpty) {
        // Return the ID as a String
        return results[0]['id'].toString();
      }
    }
    // Return null if there are no results or if the response is not successful
    return null;
  }
}
