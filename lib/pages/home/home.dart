import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spotify_clone/services/auth.dart';
import 'package:spotify_clone/shared/tiles.dart';
import 'package:spotify_clone/services/spotify.dart';
import 'package:spotify_clone/shared/loading.dart';
import 'package:spotify_clone/main.dart';

List featuredPlaylist = [];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final spotify = spotifyQuery();
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    spotify.featuredPlaylist().then((value) {
      if (mounted) {
        setState(() {
          featuredPlaylist = value;
        });
      } else {}
    });
    // featuredPlaylist.forEach((element) {
    //   print(element.name);
    // });

    return featuredPlaylist.isEmpty
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            body: Padding(
              padding: EdgeInsets.fromLTRB(
                  15 * sW / mysW, 60 * sH / mysH, 15 * sW / mysW, 0),
              child: Column(
                children: [
                  Container(
                    height: (50.0 * sH / mysH),
                    color: Colors.white.withOpacity(0.3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Good afternoon",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.only(top: 15 * sH / mysH),
                          onPressed: () => null,
                          icon: Icon(FeatherIcons.bell),
                          color: Colors.white,
                        ),
                        IconButton(
                          padding: EdgeInsets.only(top: 15 * sH / mysH),
                          onPressed: () => null,
                          icon: Icon(FeatherIcons.clock),
                          color: Colors.white,
                        ),
                        IconButton(
                          padding: EdgeInsets.only(top: 15 * sH / mysH),
                          onPressed: () async {
                            await _auth.signOut();
                          },
                          icon: Icon(FeatherIcons.settings),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      smallTile(featuredPlaylist[0], context),
                      SizedBox(width: 5 * sW / mysW),
                      smallTile(featuredPlaylist[1], context)
                    ],
                  ),
                  Row(
                    children: [
                      smallTile(featuredPlaylist[2], context),
                      SizedBox(width: 5 * sW / mysW),
                      smallTile(featuredPlaylist[3], context)
                    ],
                  ),
                  Row(
                    children: [
                      smallTile(featuredPlaylist[4], context),
                      SizedBox(width: 5 * sW / mysW),
                      smallTile(featuredPlaylist[5], context)
                    ],
                  )
                ],
              ),
            ));
  }
}
