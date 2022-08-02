import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/models.dart/user.dart';
import 'package:spotify_clone/pages/home/search_results.dart';
import 'package:spotify_clone/shared/album.dart';
import 'package:spotify_clone/shared/loading.dart';
import 'package:spotify_clone/shared/player.dart';
import 'package:spotify_clone/shared/playlist.dart';
import 'package:spotify_clone/services/auth.dart';
import 'package:spotify_clone/wrapper.dart';

double mysW = 384.0;
double mysH = 853.3333333333334;
dynamic now_playing;

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
        routes: {
          'playlistPage': (context) =>
              PlaylistPage(ModalRoute.of(context)!.settings.arguments as Map),
          'albumPage': (context) =>
              AlbumPage(ModalRoute.of(context)!.settings.arguments as Map),
          'playerPage': (context) => Player(ModalRoute.of(context)!
              .settings
              .arguments as Map<String, dynamic>),
          'loading': (context) => Loading(),
          'results': (context) => Results(),
        },
        home: Wrapper(),
      ),
    );
  }
}
