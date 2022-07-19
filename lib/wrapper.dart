import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/models.dart/user.dart';
import 'package:spotify_clone/pages/authenticate/authenticate.dart';
import 'package:spotify_clone/pages/home/home_wrapper.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDat?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      print(user.uid);
      return HomeWrapper();
    }
  }
}
