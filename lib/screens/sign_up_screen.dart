import 'package:flutter/material.dart';
import 'package:nekoflixx/colors.dart';
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/models/user.dart';
import 'package:nekoflixx/models/user_management_service.dart';
import 'package:nekoflixx/screens/login_screen.dart';
import 'package:nekoflixx/widgets/nekoflixx_app_bar.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _confirmationPwErrorText;
  String? _passwordError;
  String? _emailErrorText;

  void _signUp() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // Accessing the UserManagementService from the Provider
    UserManagementService userManagementService =
        Provider.of<UserManagementService>(context, listen: false);

    if (password != confirmPassword ||
        email.isEmpty ||
        password.isEmpty ||
        userManagementService.userExist(email)) {
      if (password != confirmPassword) {
        setState(() {
          _confirmationPwErrorText = "Passwords do not match";
        });
      }
      if (userManagementService.userExist(email)) {
        setState(() {
          _emailErrorText = "Username already exists";
        });
      }
      if (password.isEmpty) {
        setState(() {
          _passwordError = "Password is empty";
        });
      }
      if (email.isEmpty) {
        setState(() {
          _emailErrorText = "Email cannot be empty";
        });
      }
    } else {
      // Adding the user to the list
      userManagementService.addUser(User(userName: email, password: password));

      // Clear the text fields
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();

      // Clear any previous error message
      setState(() {
        _confirmationPwErrorText = null;
        _emailErrorText = null;
        _passwordError = null;
      });

      // Navigate to the login screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
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
          });
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Username",
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
      const SizedBox(height: Constants.signUpAndInPageSpacing),
      TextField(
        controller: _confirmPasswordController,
        onChanged: (_) {
          setState(() {
            _confirmationPwErrorText = null;
          });
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Confirm Password",
          errorText: _confirmationPwErrorText,
        ),
      ),
      const SizedBox(height: Constants.signUpAndInPageSpacing),
      ElevatedButton(
        onPressed: _signUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colours.signUpAndInButtonColor,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 24.0,
          ),
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colours.textWhiteColor,
            ),
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
          children: credentials,
        ),
      ),
    );
  }
}
