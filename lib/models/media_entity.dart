import 'package:cloud_firestore/cloud_firestore.dart';

/// A class representing a media entity.
class MediaEntity {
  /// The backdrop path of the media entity.
  String backdropPath = "";

  /// The ID of the media entity.
  int id = 0;

  /// The type of media (e.g., movie, tv).
  String mediaType = "";

  /// The name of the media entity.
  String name = "";

  /// The popularity of the media entity.
  double popularity = 0;

  /// Constructor for creating a MediaEntity instance.
  MediaEntity({
    required this.backdropPath,
    required this.id,
    required this.mediaType,
    required this.name,
    required this.popularity,
  });

  /// Factory method to create a MediaEntity instance from JSON data.
  factory MediaEntity.fromJson(Map<String, dynamic> json) {
    return MediaEntity(
      backdropPath: json["poster_path"] ??
          json["profile_path"] ??
          json["backdrop_path"] ??
          "",
      id: json["id"] ?? -1,
      mediaType: json["media_type"] ?? "",
      name: json["name"] ?? json["title"] ?? "",
      popularity: json["popularity"] ?? 0,
    );
  }

  /// Factory method to create a MediaEntity instance from Firestore data.
  factory MediaEntity.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return MediaEntity(
      backdropPath: data['backdropPath'],
      id: data['id'],
      mediaType: data['mediaType'],
      name: "",
      popularity: 0,
    );
  }
}
