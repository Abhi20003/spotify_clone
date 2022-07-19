import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spotify_clone/main.dart';

bool toggle = false;

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({Key? key}) : super(key: key);

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              FeatherIcons.arrowLeft,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: sW - (95 * sW / mysW),
                    height: 40 * sH / mysH,
                    // color: Colors.white.withOpacity(0.5),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.2),
                        contentPadding: EdgeInsets.only(bottom: 0),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.white)),
                        prefixIcon: Icon(
                          FeatherIcons.search,
                          color: Colors.white,
                          size: 20,
                        ),
                        hintText: "Find in playlist",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      cursorColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5 * sW / mysW),
                  Container(
                    width: 60 * sW / mysW,
                    height: 40 * sH / mysH,
                    // color: Colors.white.withOpacity(0.5),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: Colors.white,
                          )),
                      onPressed: () {},
                      color: Colors.white.withOpacity(0.2),
                      child: Text(
                        'Sort',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30 * sW / mysW,
              ),
              SizedBox(
                height: 230 * sH / mysH,
                width: 230 * sW / mysW,
                child: Image.network(data['url']),
              ),
              SizedBox(
                height: 15 * sW / mysW,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['description'],
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(
                    height: 8 * sW / mysW,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/spotify_logo.png",
                        scale: 50,
                      ),
                      SizedBox(
                        width: 7 * sH / mysH,
                      ),
                      Text(
                        data['owner'].displayName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8 * sW / mysW,
                  ),
                  Text(
                    'Likes and Length',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        splashRadius: 1,
                        icon: toggle
                            ? Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.white,
                              )
                            : Icon(
                                CupertinoIcons.heart,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          setState(() {
                            toggle = !toggle;
                          });
                        },
                      ),
                      IconButton(
                        splashRadius: 1,
                        onPressed: () {},
                        icon: Icon(
                          FeatherIcons.moreVertical,
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        splashRadius: 1,
                        iconSize: 50,
                        onPressed: () {},
                        icon: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: Center(
                              child: Icon(
                            Icons.play_arrow_sharp,
                            size: 35,
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
