import 'package:flutter/material.dart';
import 'package:spotify_clone/main.dart';

Widget smallTile(var playlist, context) {
  double sW = MediaQuery.of(context).size.width;
  double sH = MediaQuery.of(context).size.height;
  return Container(
    height: 70 * sH / mysH,
    width: ((sW - (30 * sW / mysW)) / 2) - 5,
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
        ),
        tileColor: Colors.black87.withOpacity(0.8),
        onTap: () {
          Navigator.pushNamed(context, 'playlistPage', arguments: {
            'url': playlist.images[0].url,
            'description': playlist.description,
            'owner': playlist.owner,
          });
        },
      ),
    ),
  );
}
