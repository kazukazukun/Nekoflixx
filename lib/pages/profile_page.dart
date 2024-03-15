import 'package:flutter/material.dart';
import 'package:nekoflixx/firebase/firestore_service.dart';
import 'package:nekoflixx/widgets/watchlist.dart'; // Adjust the import path as needed

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: _firestoreService.getUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Username: ${snapshot.data}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Expanded(
                child: Watchlist(), // Your watchlist widget
              ),
            ],
          );
        },
      ),
    );
  }
}
