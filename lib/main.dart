import 'package:flutter/material.dart';
import 'package:nekoflixx/models/user_management_service.dart';
import 'package:nekoflixx/nekoflixx.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserManagementService(),
      child: const Nekoflixx(),
    );
  }
}
