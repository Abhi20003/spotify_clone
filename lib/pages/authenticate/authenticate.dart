import 'package:flutter/material.dart';
import 'package:spotify_clone/pages/authenticate/login.dart';
import 'package:spotify_clone/pages/authenticate/signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogIn = true;

  void toggleView() {
    setState(() {
      showLogIn = !showLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogIn) {
      return LogIn(value: toggleView);
    } else {
      return SignUp(value: toggleView);
    }
  }
}
