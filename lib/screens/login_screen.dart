import 'package:flutter/material.dart';
import 'package:nekoflixx/colors.dart';
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/models/user_management_service.dart';
import 'package:nekoflixx/screens/home_screen.dart';
import 'package:nekoflixx/screens/sign_up_screen.dart';
import 'package:nekoflixx/widgets/exit_confirmation.dart';
import 'package:nekoflixx/widgets/nekoflixx_app_bar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailErrorText;
  String? _passwordError;

  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Accessing the UserManagementService from the Provider
    UserManagementService userManagementService =
        Provider.of<UserManagementService>(context, listen: false);
    if (username.isEmpty) {
      setState(() {
        _emailErrorText = "Username cannot be empty";
      });
    } else if (!userManagementService.userExist(username)) {
      setState(() {
        _emailErrorText = "Username does not exist";
      });
    } else if (!userManagementService.validatePassword(username, password)) {
      setState(() {
        _passwordError = "Wrong password";
      });
    } else {
      // Clear the text fields
      _usernameController.clear();
      _passwordController.clear();

      // Clear any previous error message
      setState(() {
        _emailErrorText = null;
        _passwordError = null;
      });

      // Navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var credentials = [
      TextField(
        controller: _usernameController,
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
