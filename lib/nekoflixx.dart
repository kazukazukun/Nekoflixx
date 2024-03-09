import 'package:flutter/material.dart';
import 'package:nekoflixx/colors.dart';
import 'package:nekoflixx/models/user_management_service.dart';
import 'package:nekoflixx/screens/login_screen.dart';
import 'package:provider/provider.dart';

class Nekoflixx extends StatelessWidget {
  const Nekoflixx({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Load users from storage when the app starts
    Provider.of<UserManagementService>(context, listen: false)
        .loadUsersFromStorage();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nekoflixx",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
      ),
      home: const LoginScreen(),
    );
  }
}
