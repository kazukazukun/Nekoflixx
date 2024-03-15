/// A class representing a TV show.
class TV {
  /// The backdrop path of the TV show.
  String backdropPath = "";

  /// The ID of the TV show.
  int id = 0;

  /// The title of the TV show.
  String title = "";

  /// The original language of the TV show.
  String originalLanguage = "";

  /// The original name of the TV show.
  String originalName = "";

  /// An overview of the TV show.
  String overview = "";

  /// The popularity of the TV show.
  double popularity = 0;

  /// The poster path of the TV show.
  String posterPath = "";

  /// The type of media (e.g., movie, TV show).
  String mediaType = "";

  /// The genre IDs associated with the TV show.
  List<int> genreIds = [];

  /// The first air date of the TV show.
  String firstAirDate = "";

  /// A flag indicating whether the TV show has video content.
  bool video = false;

  /// The average vote rating of the TV show.
  double voteAverage = 0;

  /// The total number of votes received by the TV show.
  int voteCount = 0;

  /// Constructor for creating a TV instance.
  TV({
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
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
  });

  /// Factory method to create a TV instance from JSON data.
  factory TV.fromJson(Map<String, dynamic> json) {
    // Extracting genre objects from JSON
    List<dynamic> genresJson = json['genres'] ?? [];
    List<int> genreIds = genresJson.map((genre) => genre['id'] as int).toList();

    return TV(
      backdropPath: json["backdrop_path"] ?? "",
      id: json["id"] ?? -1,
      title: json["title"] ?? json["name"] ?? "",
      originalLanguage: json["original_language"] ?? "",
      originalName: json["original_title"] ?? json["original_name"] ?? "",
      overview: json["overview"] ?? "",
      posterPath: json["poster_path"] ?? json["profile_path"] ?? "",
      mediaType: json["media_type"] ?? "",
      genreIds: genreIds, // Assigning the converted genre ids list
      popularity: json["popularity"] ?? 0,
      firstAirDate: json["release_date"] ?? json["first_air_date"] ?? "",
      voteAverage: json["vote_average"] ?? 0,
      voteCount: json["vote_count"] ?? 0,
    );
  }
}
