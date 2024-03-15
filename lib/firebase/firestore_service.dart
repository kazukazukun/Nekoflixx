import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nekoflixx/models/media_entity.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Path to the user's watchlist in Firestore
  String get userPath => 'users/${_auth.currentUser?.uid}/watchlist';

  // Toggle watchlist status of a media entity
  Future<void> toggleWatchlistStatus(MediaEntity mediaEntity) async {
    // Reference to the document in Firestore
    DocumentReference docRef =
        _db.collection(userPath).doc(mediaEntity.id.toString());

    // Check if the document exists
    var document = await docRef.get();
    if (document.exists) {
      // If document exists, delete it (removing from watchlist)
      await docRef.delete();
    } else {
      // If document does not exist, add it (adding to watchlist)
      await docRef.set({
        'id': mediaEntity.id,
        'backdropPath': mediaEntity.backdropPath,
        'mediaType': mediaEntity.mediaType,
      });
    }
  }

  // Get username of the currently logged-in user
  Future<String> getUsername() async {
    // Get the user ID
    var uid = _auth.currentUser?.uid;
    // Get document snapshot from Firestore
    var docSnapshot = await _db.collection('users').doc(uid).get();
    if (docSnapshot.exists) {
      // If document exists, extract username from data
      Map<String, dynamic>? data = docSnapshot.data();
      return data?['username'] ?? 'No Username';
    }
    // If document does not exist, return default username
    return 'No Username';
  }

  // Get list of media entities in the user's watchlist
  Future<List<MediaEntity>> getWatchlistMediaEntities() async {
    // Get watchlist snapshot from Firestore
    var snapshot = await getWatchlist();
    // Map each document to a MediaEntity object and return as a list
    return snapshot.docs.map((doc) => MediaEntity.fromFirestore(doc)).toList();
  }

  // Check if an item is in the user's watchlist
  Future<bool> isInWatchlist(String itemId) async {
    // Get document from Firestore
    var doc = await _db.collection(userPath).doc(itemId).get();
    // Return true if document exists, indicating item is in watchlist
    return doc.exists;
  }

  // Get snapshot of the user's watchlist from Firestore
  Future<QuerySnapshot> getWatchlist() async {
    return await _db.collection(userPath).get();
  }
}
