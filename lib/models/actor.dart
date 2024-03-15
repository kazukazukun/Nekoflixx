class Actor {
  String biography = "";
  String birthday = "";
  String name = "";
  String placeOfBirth = "";
  int popularity = 0;
  String profilePath = "";

  Actor(
      {required this.biography,
      required this.birthday,
      required this.name,
      required this.placeOfBirth,
      required this.popularity,
      required this.profilePath});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      profilePath: json["profile_path"] ?? "",
      name: json["name"] ?? "",
      birthday: json["birthday"] ?? "",
      biography: json["biography"] ?? "",
      popularity: json["popularity"] ?? 0,
      placeOfBirth: json["place_of_birth"] ?? "",
    );
  }
}
