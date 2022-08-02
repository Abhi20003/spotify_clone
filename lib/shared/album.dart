import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spotify_clone/main.dart';
import 'package:spotify_clone/shared/loading.dart';
import 'package:spotify_clone/shared/tiles.dart';

bool toggle = false;

class AlbumPage extends StatefulWidget {
  late Map<dynamic, dynamic>? args;
  AlbumPage(this.args);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final controller = ScrollController();
  late List tracklist;
  bool isvisible = true;

  @override
  void initState() {
    super.initState();
    tracklist = widget.args!['tracksList'];
  }

  @override
  Widget build(BuildContext context) {
    print("In Album");
    var data = ModalRoute.of(context)!.settings.arguments as Map;
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () {
            print("Out of Album");
            Navigator.pop(context);
          },
          child: Icon(
            FeatherIcons.arrowLeft,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15 * sW / mysW, vertical: 0),
        child: ListView(
          controller: controller,
          children: [
            Container(
              height: (410 + 60 * tracklist.length).toDouble(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.white.withOpacity(0.3),
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
                            hintText: "Find in album",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          onTap: () {
                            // isvisible = false;
                          },
                          onEditingComplete: () {
                            isvisible = true;
                          },
                          onChanged: (query) {
                            isvisible = false;
                            tracklist = widget.args!['tracksList'];
                            print(query);
                            final suggestions = tracklist.where((track) {
                              final trackname = track.name.toLowerCase();
                              final input = query.toLowerCase();
                              return trackname.contains(input);
                            }).toList();
                            setState(() {
                              tracklist = suggestions;
                            });
                            print(tracklist);
                          },
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
                          onPressed: () {
                            setState(() {
                              isvisible = true;
                            });
                          },
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
                  Visibility(
                    visible: isvisible,
                    child: SizedBox(
                      height: 230 * sH / mysH,
                      width: 230 * sW / mysW,
                      child: Image.network(data['url']),
                    ),
                  ),
                  SizedBox(
                    height: 15 * sW / mysW,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Album" + "-" + data['year'],
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 8 * sW / mysW,
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
                                    color: Colors.green,
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
                  Expanded(
                    child: Column(
                        children: List.generate(tracklist.length, (index) {
                      return songTile(tracklist[index], context);
                    })),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
