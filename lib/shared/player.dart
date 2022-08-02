import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spotify_clone/main.dart';
import 'package:video_player/video_player.dart';

bool toggle = false;
int? position;

String convertTotime(int seconds) {
  String time = "";
  if (seconds % 60 >= 10) {
    time = "${seconds ~/ 60}:${seconds % 60}";
  } else {
    time = "${seconds ~/ 60}:0${seconds % 60}";
  }
  return time;
}

class Player extends StatefulWidget {
  late Map<dynamic, dynamic>? args;
  Player(this.args);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController _controller;
  bool backward = false;
  bool forward = false;
  bool play = true;
  bool shuffle = false;
  bool repeat = true;
  double sliderValue = 0;
  bool isUrl = true;
  int progress = 0;

  @override
  void initState() {
    super.initState();
    String url = widget.args!['previewUrl'];
    _controller = VideoPlayerController.network(url);
    if (url != 'NA') {
      _controller.initialize();
    } else {
      isUrl = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var prevdata = ModalRoute.of(context)!.settings.arguments as Map;
    if (isUrl) {
      play ? _controller.play() : _controller.pause();
      repeat ? _controller.setLooping(true) : _controller.setLooping(false);
    }
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          splashRadius: 1,
          icon: Icon(
            FeatherIcons.chevronDown,
            color: Colors.white,
          ),
          onPressed: () {
            _controller.pause();
            Navigator.pop(context, {
              'url': prevdata['url'],
              'name': prevdata['name'],
              'artists': prevdata['artists'],
              'duration': prevdata['duration'],
              'previewUrl': prevdata['previewUrl'],
            });
          },
        ),
        title: isUrl
            ? Text(
                "Now Playing",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            : Text(
                "Preview not Available",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            splashRadius: 1,
            icon: Icon(
              FeatherIcons.moreVertical,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            25 * sW / mysW, 75 * sH / mysH, 25 * sW / mysW, 0),
        child: Column(
          children: [
            Image.network(
              prevdata['url'],
              alignment: Alignment.center,
              height: 340,
            ),
            SizedBox(
              height: 80 * sH / mysH,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        prevdata['name'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        prevdata['artists'],
                        style: TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
                Spacer(),
                IconButton(
                  splashRadius: 1,
                  icon: toggle
                      ? Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.green,
                          size: 30,
                        )
                      : Icon(
                          CupertinoIcons.heart,
                          color: Colors.white,
                          size: 30,
                        ),
                  onPressed: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                height: 45,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(playedColor: Colors.white),
                )),
            Padding(
              padding:
                  EdgeInsets.only(left: 15 * sW / mysW, right: 25 * sW / mysW),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    convertTotime(29),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    splashRadius: 1,
                    onPressed: () {
                      setState(() {
                        shuffle = !shuffle;
                      });
                    },
                    icon: Icon(
                      FeatherIcons.shuffle,
                      color: shuffle ? Colors.green : Colors.white,
                    )),
                Spacer(
                  flex: 2,
                ),
                IconButton(
                    enableFeedback: isUrl,
                    splashRadius: 1,
                    onPressed: () {},
                    icon: Icon(
                      FeatherIcons.skipBack,
                      color: Colors.white,
                      size: 30,
                    )),
                Spacer(),
                IconButton(
                  splashRadius: 1,
                  iconSize: 60,
                  onPressed: () {
                    setState(() {
                      play = !play;
                    });
                  },
                  icon: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Center(
                        child: play
                            ? Icon(
                                Icons.pause,
                                size: 40,
                              )
                            : Icon(
                                Icons.play_arrow_sharp,
                                size: 40,
                              )),
                  ),
                ),
                Spacer(),
                IconButton(
                    splashRadius: 1,
                    onPressed: () {
                      setState(() {
                        forward = true;
                      });
                      _controller.pause();
                      Navigator.pop(context, {
                        'url': prevdata['url'],
                        'name': prevdata['name'],
                        'artists': prevdata['artists'],
                        'duration': prevdata['duration'],
                        'previewUrl': prevdata['previewUrl'],
                      });
                    },
                    icon: Icon(
                      FeatherIcons.skipForward,
                      color: Colors.white,
                      size: 30,
                    )),
                Spacer(
                  flex: 2,
                ),
                IconButton(
                    splashRadius: 1,
                    onPressed: () {
                      setState(() {
                        repeat = !repeat;
                      });
                      repeat
                          ? _controller.setLooping(true)
                          : _controller.setLooping(false);
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_2_squarepath,
                      color: repeat ? Colors.green : Colors.white,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
