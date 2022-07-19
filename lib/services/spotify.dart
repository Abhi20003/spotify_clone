import 'dart:convert';
import 'package:spotify_clone/apikeys.dart';
import 'package:spotify/spotify.dart';
import 'dart:io';

// void main() async {
//   var a = await File("lib\\apikeys.json").readAsString();
//   var b = json.decode(a);
//   print(b['clientId']);

//   var credentials = SpotifyApiCredentials(
//       'd0674729984a4633802d91f57377c2d5', 'b99fffadbb8e4f2a93166e6abb0c7f38');
//   var spotify = SpotifyApi(credentials);

// List list = [];
// String? playlistId;
// String? trackId;
// final featured = await spotify.playlists.featured.all();
// featured.forEach((play) async {
//   list.add(play);
//   // print(playlist.name);
//   playlistId = play.id;
//   var p = await spotify.playlists.get(playlistId!);
//   p.tracks!.itemsNative!.forEach((element) async {
//     print('hi');
//     trackId = element['track']['id'];
//     var t = await spotify.tracks.get(trackId!);
//     print(t.name);
//   });
// });
// }

class spotifyQuery {
  var spotify = SpotifyApi(SpotifyApiCredentials(clientId, clientSecret));

  Future<Artist> searchArtist() async {
    Artist? artist;
    final search = await spotify.search.get('Ariana Grande').first(1);
    search.forEach((pages) {
      for (final item in pages.items!) {
        if (item.runtimeType == Artist) {
          artist = item;
          break;
        }
      }
    });
    return artist!;
  }

  Future<List> featuredPlaylist() async {
    List list = [];
    final featured = await spotify.playlists.featured.all();
    featured.forEach((playlist) {
      list.add(playlist);
      // print(playlist.name);
    });
    return list;
  }
}
