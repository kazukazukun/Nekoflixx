import 'package:cloud_firestore/cloud_firestore.dart';

class MediaEntity {
  String backdropPath = "";
  int id = 0;
  String mediaType = "";
  MediaEntity({
    required this.backdropPath,
    required this.id,
    required this.mediaType,
  });

  factory MediaEntity.fromJson(Map<String, dynamic> json) {
    return MediaEntity(
      backdropPath: json["poster_path"] ??
          json["profile_path"] ??
          json["backdrop_path"] ??
          "",
      id: json["id"] ?? -1,
      mediaType: json["media_type"] ?? "",
    );
  }
  factory MediaEntity.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return MediaEntity(
        backdropPath: data['backdropPath'],
        id: data['id'],
        mediaType: data['mediaType']);
  }
}
