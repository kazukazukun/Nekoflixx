import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nekoflixx/firebase/firebase_options.dart';
import 'package:nekoflixx/models/genre_provider.dart';
import 'package:nekoflixx/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  runApp(ChangeNotifierProvider(
    create: (_) => GenreProvider(),
    child: const MyApp(),
  ));
}

// Main Application Widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      home: SplashScreen(), // Initial screen is the SplashScreen
    );
  }
}
