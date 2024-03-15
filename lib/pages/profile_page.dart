import 'package:flutter/material.dart';
import 'package:nekoflixx/firebase/firestore_service.dart';
import 'package:nekoflixx/widgets/watchlist.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: _firestoreService.getUsername(),
        builder: (context, snapshot) {
          // Check if the data is still loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Check if there's an error in fetching the data
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Display the retrieved username and watchlist
          return const Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Watchlist",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    // Your watchlist widget
                    Watchlist(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
