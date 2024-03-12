import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nekoflixx/colors.dart';
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/screens/home_screen.dart';
import 'package:nekoflixx/screens/sign_up_screen.dart';
import 'package:nekoflixx/widgets/exit_confirmation.dart';
import 'package:nekoflixx/widgets/nekoflixx_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailErrorText;
  String? _passwordError;

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var credentials = [
      TextField(
        controller: _emailController,
        onChanged: (_) {
          setState(() {
            _emailErrorText = null;
            _passwordError = null;
          });
        },
        decoration: InputDecoration(
          labelText: "Email",
          errorText: _emailErrorText,
        ),
      ),
      const SizedBox(height: Constants.signUpAndInPageSpacing),
      TextField(
        controller: _passwordController,
        onChanged: (_) {
          setState(() {
            _passwordError = null;
          });
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          errorText: _passwordError,
        ),
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        // Close the app when the back button is pressed
        return await showDialog(
          context: context,
          builder: (context) => const ExitConfirmation(),
        );
      },
      child: Scaffold(
        appBar: const NekoflixxAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: credentials,
                ),
              ),
              const SizedBox(height: Constants.signUpAndInPageSpacing),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.signUpAndInButtonColor),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colours.textWhiteColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Constants.signUpAndInPageSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Need an account?",
                    style: TextStyle(
                      color: Colours.textWhiteColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Action for "Sign up now"
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      " Sign up now",
                      style: TextStyle(color: Colours.signUpAndInButtonColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
