import 'package:flutter/material.dart';
import 'package:nekoflixx/firebase/firestore_service.dart';
import 'package:nekoflixx/widgets/sliding_media_row.dart';

// Watchlist as a widget
class Watchlist extends StatelessWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();

    return SlidingMediaRow(
      mediaEntityList: firestoreService.getWatchlistMediaEntities(),
      isMoving: false,
    );
  }
}
