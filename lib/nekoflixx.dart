import 'package:flutter/material.dart';
import 'package:nekoflixx/colors.dart';
import 'package:nekoflixx/models/genre_provider.dart';
import 'package:nekoflixx/screens/home_screen.dart';
import 'package:nekoflixx/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Nekoflixx Application Widget
class Nekoflixx extends StatefulWidget {
  const Nekoflixx({Key? key}) : super(key: key);

  @override
  State<Nekoflixx> createState() => _NekoflixxState();
}

// State of Nekoflixx Application Widget
class _NekoflixxState extends State<Nekoflixx> {
  // Initial screen is LoginScreen by default
  Widget _initialScreen = const LoginScreen();

  @override
  void initState() {
    super.initState();
    _loadInitialScreen(); // Load initial screen when the app starts
  }

  // Function to load the initial screen based on user's login status
  Future<void> _loadInitialScreen() async {
    // Retrieve shared preferences
    final prefs = await SharedPreferences.getInstance();
    // Check if the user is logged in or not
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    // Set the initial screen based on login status
    setState(() {
      _initialScreen = isLoggedIn ? const HomeScreen() : const LoginScreen();
    });
    // Fetch genres when the app starts
    Provider.of<GenreProvider>(context, listen: false).fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      title: "Nekoflixx", // App title
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor, // Set scaffold background color
      ),
      home: _initialScreen, // Set the initial screen
    );
  }
}
