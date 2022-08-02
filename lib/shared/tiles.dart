import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spotify_clone/main.dart';
import 'package:spotify_clone/services/spotify.dart';
import 'dart:math' as math;

List? songs;

Widget smallTile(var playlist, context) {
  double sW = MediaQuery.of(context).size.width;
  double sH = MediaQuery.of(context).size.height;
  return Container(
    padding: EdgeInsets.only(right: 5 * sW / mysW),
    height: 70 * sH / mysH,
    width: ((sW - (30 * sW / mysW)) / 2),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.only(top: 15 * sH / mysH),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 2 * sH / mysH, 0),
        leading: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          child: Image.network(
            playlist.images[0].url,
            fit: BoxFit.cover,
          ),
        ),
        textColor: Colors.white,
        title: Text(
          playlist.name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        tileColor: Colors.black87.withOpacity(0.8),
        onTap: () async {
          Navigator.pushNamed(context, 'loading');
          List tracksList = [];
          var track;
          songs = await spotifyQuery().getSongsfromPlaylist(playlist);
          songs!.forEach((trackId) async {
            track = await spotifyQuery().getTrack(trackId);
            tracksList.add(track);
          });
          tracksList.forEach((element) {
            print(element.name);
          });
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'playlistPage', arguments: {
              'tracksList': tracksList,
              'playlist': playlist,
              'url': playlist.images[0].url,
              'description': playlist.description,
              'owner': playlist.owner,
            });
          });
        },
      ),
    ),
  );
}

Widget songTile(
  var track,
  var context,
) {
  spotifyQuery spotify = spotifyQuery();
  double sW = MediaQuery.of(context).size.width;
  double sH = MediaQuery.of(context).size.height;
  String all_names = "";
  int duration = track.duration.inSeconds;
  track.artists.forEach((artist) {
    all_names += artist.name + ", ";
  });
  all_names = all_names.substring(0, (all_names).length - 2);
  return Container(
    padding: EdgeInsets.only(top: 0, left: 5 * sW / mysW, right: 0),
    // color: Colors.white.withOpacity(0.4),
    height: 60 * sH / mysH,
    width: sW,
    child: Card(
      color: Colors.black,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text(
          track.name,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          all_names,
          maxLines: 1,
          style: TextStyle(
            color: Colors.grey,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: Image.network(
          track.album.images[0].url,
          fit: BoxFit.fill,
        ),
        trailing: IconButton(
          splashRadius: 1,
          icon: Icon(
            FeatherIcons.moreVertical,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        onTap: () {
          print("Hey $now_playing");
          Navigator.pushNamed(context, 'playerPage', arguments: {
            'url': track.album.images[0].url,
            'name': track.name,
            'artists': all_names,
            'duration': duration,
            'previewUrl': track.previewUrl ?? "NA",
          });
        },
      ),
    ),
  );
}

Widget playlistTile(var playlist, context) {
  double sW = MediaQuery.of(context).size.width;
  double sH = MediaQuery.of(context).size.height;
  return Container(
    height: 160 * sH / mysH,
    width: 160 * sW / mysW,
    child: Column(
      children: [
        Card(
          color: Colors.black,
          child: GestureDetector(
            child: Image.network(
              playlist.images[0].url,
              // fit: BoxFit.cover,
              height: 130,
            ),
            onTap: () async {
              Navigator.pushNamed(context, 'loading');
              List tracksList = [];
              var track;
              songs = await spotifyQuery().getSongsfromPlaylist(playlist);
              songs!.forEach((trackId) async {
                track = await spotifyQuery().getTrack(trackId);
                tracksList.add(track);
              });
              tracksList.forEach((element) {
                print(element.name);
              });
              Future.delayed(const Duration(seconds: 5), () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'playlistPage', arguments: {
                  'tracksList': tracksList,
                  'playlist': playlist,
                  'url': playlist.images[0].url,
                  'description': playlist.description,
                  'owner': playlist.owner,
                });
              });
            },
          ),
        ),
        Text(
          playlist.name,
          style: TextStyle(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}

Widget albumTile(var album, context) {
  double sW = MediaQuery.of(context).size.width;
  double sH = MediaQuery.of(context).size.height;
  return Container(
    height: 160 * sH / mysH,
    width: 160 * sW / mysW,
    child: Column(
      children: [
        Card(
          color: Colors.black,
          child: GestureDetector(
            child: Image.network(
              album.images[0].url,
              // fit: BoxFit.cover,
              height: 130,
            ),
            onTap: () async {
              Navigator.pushNamed(context, 'loading');
              List tracksList = [];
              var track;
              tracksList = await spotifyQuery().getSongsfromAlbum(album);
              Future.delayed(const Duration(seconds: 5), () {
                print(tracksList);
                Navigator.pop(context);
                Navigator.pushNamed(context, 'albumPage', arguments: {
                  'tracksList': tracksList,
                  'album': album,
                  'url': album.images[0].url,
                  'year': album.releaseDate
                });
              });
            },
          ),
        ),
        Text(
          album.name,
          style: TextStyle(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}

Widget genreCard() {
  return Container(
    height: 100,
    width: 160,
    child: Card(
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0),
      child: ListTile(),
    ),
  );
}
