import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spotify_clone/services/auth.dart';
import 'package:spotify_clone/shared/tiles.dart';
import 'package:spotify_clone/services/spotify.dart';
import 'package:spotify_clone/shared/loading.dart';
import 'package:spotify_clone/main.dart';

List featuredPlaylist = [];
List<int> cnt = [6, 7, 8, 9, 15, 16];
List<int> row = [0, 1, 2, 3, 4];
List topCharts = [];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final spotify = spotifyQuery();
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    spotify.searchCharts().then((play) {
      if (mounted) {
        setState(() {
          topCharts = play;
        });
      } else {}
    });
    spotify.searchPlaylist().then((value) {
      if (mounted) {
        setState(() {
          featuredPlaylist = value;
        });
      } else {}
    });
    return (featuredPlaylist.length < 10 || topCharts.length < 6)
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Explore",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Tooltip(
                          message: "I'm of no use :)",
                          triggerMode: TooltipTriggerMode.tap,
                          child: IconButton(
                            padding: EdgeInsets.only(top: 15 * sH / mysH),
                            onPressed: () => null,
                            icon: Icon(FeatherIcons.bell),
                            color: Colors.white,
                          ),
                        ),
                        Tooltip(
                          message: "I'm of no use :)",
                          triggerMode: TooltipTriggerMode.tap,
                          child: IconButton(
                            padding: EdgeInsets.only(top: 15 * sH / mysH),
                            onPressed: () => null,
                            icon: Icon(FeatherIcons.clock),
                            color: Colors.white,
                          ),
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
                  Container(
                      child: Column(
                    children: List.generate(3, (index) {
                      return Row(
                        children: List.generate(2, (index1) {
                          return smallTile(
                              featuredPlaylist[index1 + index + row[index]],
                              context);
                        }),
                      );
                    }),
                  )),
                  SizedBox(
                    height: 10 * sH / mysH,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Featured Playlists",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10 * sH / mysH,
                  ),
                  Container(
                    height: 160,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: ((context, index) {
                          return playlistTile(
                              featuredPlaylist[cnt[index]], context);
                        })),
                  ),
                  SizedBox(
                    height: 20 * sH / mysH,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Top charts",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10 * sH / mysH,
                  ),
                  Container(
                    height: 160,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: ((context, index) {
                          return playlistTile(topCharts[index], context);
                        })),
                  ),
                ],
              ),
            ));
  }
}
