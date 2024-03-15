/// A class representing an actor in the movie database.
class Actor {
  /// The biography of the actor.
  String biography = "";

  /// The birthday of the actor.
  String birthday = "";

  /// The name of the actor.
  String name = "";

  /// The place of birth of the actor.
  String placeOfBirth = "";

  /// The popularity of the actor.
  int popularity = 0;

  /// The profile path of the actor.
  String profilePath = "";

  /// Constructor for creating an Actor instance.
  Actor({
    required this.biography,
    required this.birthday,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });

  /// Factory method to create an Actor instance from JSON data.
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
