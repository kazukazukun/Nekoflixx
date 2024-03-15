import 'package:flutter/material.dart';
import 'package:nekoflixx/colors.dart';
import 'package:nekoflixx/models/genre_provider.dart';
import 'package:nekoflixx/screens/home_screen.dart';
import 'package:nekoflixx/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Nekoflixx extends StatefulWidget {
  const Nekoflixx({Key? key}) : super(key: key);

  @override
  State<Nekoflixx> createState() => _NekoflixxState();
}

class _NekoflixxState extends State<Nekoflixx> {
  Widget _initialScreen = const LoginScreen();

  @override
  void initState() {
    super.initState();
    _loadInitialScreen();
  }

  Future<void> _loadInitialScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _initialScreen = isLoggedIn ? const HomeScreen() : const LoginScreen();
    });
    Provider.of<GenreProvider>(context, listen: false).fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nekoflixx",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
      ),
      home: _initialScreen,
    );
  }
}
