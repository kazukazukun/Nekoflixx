import 'package:flutter/material.dart';
import 'package:nekoflixx/screens/home_screen.dart';

class NetworkFailureScreen extends StatelessWidget {
  const NetworkFailureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Network Failure",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the screen where you want to go after retry
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
