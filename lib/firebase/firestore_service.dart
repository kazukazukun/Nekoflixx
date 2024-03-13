import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to check if a media item is in the user's watchlist
  Future<bool> isInWatchlist(int mediaId) async {
    var user = _auth.currentUser;
    if (user != null) {
      var doc = await _db
          .collection('watchlists')
          .doc(user.uid)
          .collection('mediaItems')
          .doc(mediaId.toString())
          .get();
      return doc.exists;
    }
    return false;
  }

  // Method to add/remove a media item from the watchlist
  Future<void> toggleWatchlistStatus(int mediaId, bool isInWatchlist) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var docRef = FirebaseFirestore.instance
          .collection('watchlists')
          .doc(user.uid)
          .collection('mediaItems')
          .doc(mediaId.toString());
      if (isInWatchlist) {
        // If it's in the watchlist, remove it
        await docRef.delete();
      } else {
        // If it's not in the watchlist, add it
        await docRef
            .set({'id': mediaId, 'addedOn': FieldValue.serverTimestamp()});
      }
    }
  }
}
