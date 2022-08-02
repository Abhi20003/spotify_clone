import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spotify_clone/main.dart';
import 'package:spotify_clone/services/spotify.dart';
import 'package:spotify_clone/shared/tiles.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  // const Search({Key? key}) : super(key: key);

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
  List list = [];

  @override
  Widget build(BuildContext context) {
    spotifyQuery spotify = spotifyQuery();
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              13 * sW / mysW, 60 * sH / mysH, 13 * sW / mysW, 0),
          child: Column(
            children: [
              Container(
                height: (50.0 * sH / mysH),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Search",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15 * sH / mysH,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 10 * sW / mysW),
                height: 45 * sH / mysH,
                child: TextFormField(
                  controller: TextEditingController(),
                  cursorColor: Colors.green,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FeatherIcons.search,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.all(0),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hintText: "Artists or songs",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {},
                  onChanged: (value) {},
                  onFieldSubmitted: (query) async {
                    Navigator.pushNamed(context, 'loading');
                    TextEditingController().clear();
                    print(query);
                    List list = [];
                    spotify.search(query).then((value) {
                      list = value;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'results',
                          arguments: {'searchResult': list});
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15 * sH / mysH,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Browse all",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10 * sH / mysH,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 500 * sH / mysH,
                    width: 358 * sW / mysW,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: [
                              genreCard(),
                              SizedBox(
                                width: 10 * sW / mysW,
                              ),
                              genreCard()
                            ],
                          );
                        })),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
