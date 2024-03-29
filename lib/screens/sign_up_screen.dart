import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nekoflixx/colors.dart';
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/screens/login_screen.dart';
import 'package:nekoflixx/widgets/nekoflixx_app_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _confirmationPwErrorText;
  String? _passwordError;
  String? _emailErrorText;

  // Method to handle the sign-up process
  Future<void> _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // Validate email, password, and confirmation password
    if (email.isEmpty ||
        password.isEmpty ||
        password != confirmPassword ||
        password.length < 6) {
      if (email.isEmpty) {
        setState(() {
          _emailErrorText = "Email cannot be empty";
        });
      }
      if (password.isEmpty) {
        setState(() {
          _passwordError = "Password cannot be empty";
        });
      } else if (password.length < 6) {
        setState(() {
          _passwordError = "Password has to be at least 6 characters long";
        });
      }
      if (password != confirmPassword) {
        setState(() {
          _confirmationPwErrorText = "Passwords do not match";
        });
      }
      return;
    }

    try {
      // Create user with email and password
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Navigate to the login screen after successful sign-up
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (error) {
      setState(() {
        _emailErrorText = error.toString(); // Parse error message for better UI
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var credentials = [
      // Email input field
      TextField(
        controller: _emailController,
        onChanged: (_) => setState(() => _emailErrorText = null),
        decoration: InputDecoration(
          labelText: "Email",
          errorText: _emailErrorText,
        ),
      ),
      const SizedBox(height: Constants.signUpAndInPageSpacing),
      // Password input field
      TextField(
        controller: _passwordController,
        onChanged: (_) => setState(() => _passwordError = null),
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          errorText: _passwordError,
        ),
      ),
      const SizedBox(height: Constants.signUpAndInPageSpacing),
      // Confirm password input field
      TextField(
        controller: _confirmPasswordController,
        onChanged: (_) => setState(() => _confirmationPwErrorText = null),
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Confirm Password",
          errorText: _confirmationPwErrorText,
        ),
      ),
      const SizedBox(height: Constants.signUpAndInPageSpacing),
      // Sign-up button
      ElevatedButton(
        onPressed: _signUp,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colours.signUpAndInButtonColor),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colours.textWhiteColor),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: const NekoflixxAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...credentials,
            const SizedBox(
              height: Constants.signUpAndInPageSpacing,
            ),
            // Link to login screen
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(color: Colours.textWhiteColor),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the login screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    " Login",
                    style: TextStyle(color: Colours.signUpAndInButtonColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
