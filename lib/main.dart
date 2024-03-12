import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nekoflixx/firebase_options.dart';
import 'package:nekoflixx/nekoflixx.dart'; // Your main app widget

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Nekoflixx();
  }
}
