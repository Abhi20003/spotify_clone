import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/models.dart/user.dart';
import 'package:spotify_clone/shared/playlist.dart';
import 'package:spotify_clone/services/auth.dart';
import 'package:spotify_clone/wrapper.dart';

double mysW = 384.0;
double mysH = 853.3333333333334;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserDat?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {'playlistPage': (context) => PlaylistPage()},
        home: Wrapper(),
      ),
    );
  }
}
