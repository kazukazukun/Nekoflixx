/// A class representing a genre.
class Genre {
  /// The ID of the genre.
  int genreId = 0;

  /// The name of the genre.
  String genreName = "";

  /// Constructor for creating a Genre instance.
  Genre({required this.genreId, required this.genreName});

  /// Factory method to create a Genre instance from JSON data.
  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      genreId: json["id"] ?? 0,
      genreName: json["name"] ?? "",
    );
  }
}
