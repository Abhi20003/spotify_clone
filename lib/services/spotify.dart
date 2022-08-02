import 'package:flutter/material.dart';
import 'package:spotify_clone/apikeys.dart';
import 'package:spotify/spotify.dart';

void main() async {
  // var credentials = SpotifyApiCredentials(
  //     'd0674729984a4633802d91f57377c2d5', 'b99fffadbb8e4f2a93166e6abb0c7f38');
  // var spotify = SpotifyApi(credentials);
  // List list = [];
  // print("hi there");
  // var featured = await spotify.playlists.featured.all();
  // featured.forEach((playlist) {
  //   list.add(playlist);
  // });
  // print(list);
}

class spotifyQuery {
  var spotify = SpotifyApi(SpotifyApiCredentials(clientId, clientSecret));

  Future<dynamic> search(String query) async {
    bool flag = false;
    List list = [];
    List playlists = [];
    List tracks = [];
    List albums = [];
    try {
      final search = await spotify.search.get(query).first();
      for (final pages in search) {
        for (final item in pages.items!) {
          print(item);
          if (item.runtimeType == PlaylistSimple) {
            playlists.add(item);
          }
          if (item.runtimeType == AlbumSimple) {
            albums.add(item);
          }
          if (item.runtimeType == Track) {
            tracks.add(item);
          }
          if (playlists.length > 14 && tracks.length > 19) {
            flag = true;
            break;
          }
        }
        if (flag) {
          break;
        }
      }
      list.add(playlists);
      list.add(albums);
      list.add(tracks);
      return list;
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<dynamic> searchCharts() async {
    bool flag = false;
    List list = [];
    try {
      final search = await spotify.search.get('all out').first();
      for (final pages in search) {
        for (final item in pages.items!) {
          print(item);
          if (item.runtimeType == PlaylistSimple) {
            list.add(item);
          }
          if (list.length > 5) {
            flag = true;
            break;
          }
        }
        if (flag) {
          break;
        }
      }
      return list;
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<dynamic> searchPlaylist() async {
    List list = [];
    try {
      final search = await spotify.search.get('Charts').first();
      for (final pages in search) {
        for (final item in pages.items!) {
          print(item);
          if (item.runtimeType == PlaylistSimple) {
            list.add(item);
          }
        }
        if (list.length > 11) {
          break;
        }
      }
      return list;
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Future<List> featuredPlaylist() async {
  //   List list = [];
  //   var featured = await spotify.playlists.featured.all();
  //   featured.forEach((playlist) {
  //     list.add(playlist);
  //   });
  //   return list;
  // }

  Future<Track> getTrack(String trackId) async {
    var track = null;
    try {
      track = await spotify.tracks.get(trackId);
      return track;
    } on Exception catch (e) {
      print(e.toString());
      return track;
    }
  }

  Future<List> getSongsfromPlaylist(PlaylistSimple playlist) async {
    List list = [];
    String trackId;
    String? playlistId = playlist.id;
    try {
      var play = await spotify.playlists.get(playlistId!);
      play.tracks!.itemsNative!.forEach((element) async {
        trackId = element['track']['id'];
        list.add(trackId);
      });
      return list;
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getSongsfromAlbum(AlbumSimple album) async {
    List list = [];
    try {
      album.tracks!.forEach((track) {
        print(track);
        list.add(track);
      });
      print(list);
      return list;
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }
}
