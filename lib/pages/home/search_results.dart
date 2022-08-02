import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spotify_clone/main.dart';
import 'package:spotify_clone/shared/tiles.dart';

class Results extends StatefulWidget {
  Results();

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Search Results',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 10.0 * sW / mysW, vertical: 20 * sH / mysH),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Tracks",
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
              height: 180,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: data['searchResult'][2].length,
                  itemBuilder: ((context, index) {
                    return songTile(data['searchResult'][2][index], context);
                  })),
            ),
            SizedBox(
              height: 10 * sH / mysH,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Playlists",
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
                  itemCount: data['searchResult'][0].isEmpty
                      ? 1
                      : data['searchResult'][0].length,
                  itemBuilder: ((context, index) {
                    return data['searchResult'][0].isEmpty
                        ? Text(
                            "No Playlist Found",
                            style: TextStyle(color: Colors.white),
                          )
                        : playlistTile(data['searchResult'][0][index], context);
                  })),
            ),
            SizedBox(
              height: 10 * sH / mysH,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Albums",
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
                  itemCount: data['searchResult'][1].isEmpty
                      ? 1
                      : data['searchResult'][1].length,
                  itemBuilder: ((context, index) {
                    return data['searchResult'][1].isEmpty
                        ? Text(
                            "No Album Found",
                            style: TextStyle(color: Colors.white),
                          )
                        : albumTile(data['searchResult'][1][index], context);
                  })),
            ),
            SizedBox(
              height: 10 * sH / mysH,
            ),
          ],
        ),
      ),
    );
  }
}
