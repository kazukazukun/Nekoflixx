import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nekoflixx/models/media_entity.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userPath => 'users/${_auth.currentUser?.uid}/watchlist';

  Future<void> toggleWatchlistStatus(MediaEntity mediaEntity) async {
    DocumentReference docRef =
        _db.collection(userPath).doc(mediaEntity.id.toString());

    var document = await docRef.get();
    if (document.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        'id': mediaEntity.id,
        'backdropPath': mediaEntity.backdropPath,
        'mediaType': mediaEntity.mediaType,
      });
    }
  }

  Future<bool> isInWatchlist(String itemId) async {
    var doc = await _db.collection(userPath).doc(itemId).get();
    return doc.exists;
  }

  Future<QuerySnapshot> getWatchlist() async {
    return await _db.collection(userPath).get();
  }
}
