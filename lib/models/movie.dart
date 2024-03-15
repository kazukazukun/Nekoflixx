/// A class representing a movie.
class Movie {
  /// The backdrop path of the movie.
  String backdropPath = "";

  /// The ID of the movie.
  int id = 0;

  /// The title of the movie.
  String title = "";

  /// The original language of the movie.
  String originalLanguage = "";

  /// The original name of the movie.
  String originalName = "";

  /// An overview of the movie.
  String overview = "";

  /// The popularity of the movie.
  double popularity = 0;

  /// The poster path of the movie.
  String posterPath = "";

  /// The type of media (e.g., movie, TV show).
  String mediaType = "";

  /// The genre IDs associated with the movie.
  List<int> genreIds = [];

  /// The release date of the movie.
  String releaseDate = "";

  /// A flag indicating whether the movie has video content.
  bool video = false;

  /// The average vote rating of the movie.
  double voteAverage = 0;

  /// The total number of votes received by the movie.
  int voteCount = 0;

  /// Constructor for creating a Movie instance.
  Movie({
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  /// Factory method to create a Movie instance from JSON data.
  factory Movie.fromJson(Map<String, dynamic> json) {
    // Extracting genre objects from JSON
    List<dynamic> genresJson = json['genres'] ?? [];
    List<int> genreIds = genresJson.map((genre) => genre['id'] as int).toList();

    return Movie(
      backdropPath: json['backdrop_path'] ?? "",
      id: json['id'] ?? -1,
      title: json['title'] ?? "",
      originalLanguage: json['original_language'] ?? "",
      originalName: json['original_title'] ?? json['original_name'] ?? "",
      overview: json['overview'] ?? "",
      popularity: (json['popularity'] ?? 0).toDouble(),
      posterPath: json['poster_path'] ?? json['profile_path'] ?? "",
      mediaType: json['media_type'] ?? "",
      genreIds: genreIds,
      releaseDate: json['release_date'] ?? json['first_air_date'] ?? "",
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }
}
