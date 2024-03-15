class TV {
  String backdropPath = "";
  int id = 0;
  String title = "";
  String originalLanguage = "";
  String originalName = "";
  String overview = "";
  double popularity = 0;
  String posterPath = "";
  String mediaType = "";
  List<int> genreIds = [];
  String firstAirDate = "";
  bool video = false;
  double voteAverage = 0;
  int voteCount = 0;

  TV(
      {required this.backdropPath,
      required this.id,
      required this.title,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.mediaType,
      required this.genreIds,
      required this.popularity,
      required this.firstAirDate,
      required this.voteAverage,
      required this.voteCount});

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