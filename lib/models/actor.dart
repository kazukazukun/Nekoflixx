class Actor {
  String biography = "";
  String birthday = "";
  String name = "";
  String place_of_birth = "";
  int popularity = 0;
  String profile_path = "";

  Actor(
      {required this.biography,
      required this.birthday,
      required this.name,
      required this.place_of_birth,
      required this.popularity,
      required this.profile_path});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      profile_path: json["profile_path"] ?? "",
      name: json["name"] ?? "",
      birthday: json["birthday"] ?? "",
      biography: json["biography"] ?? "",
      popularity: json["popularity"] ?? 0,
      place_of_birth: json["place_of_birth"] ?? "",
    );
  }
}
