class Genre {
  int genreId = 0;
  String genreName = "";

  Genre({required this.genreId, required this.genreName});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      genreId: json["id"] ?? 0,
      genreName: json["name"] ?? "",
    );
  }
}
