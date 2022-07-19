import 'package:flutter/material.dart';
import 'package:spotify_clone/pages/home/library.dart';
import 'package:spotify_clone/pages/home/search.dart';
import 'package:spotify_clone/pages/home/settings.dart';
import 'package:spotify_clone/pages/home/home.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    print(activePage);
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: Footer(),
        body: getPage());
  }

  Widget getPage() {
    return IndexedStack(
      index: activePage,
      children: <Widget>[Home(), Search(), Library(), Settings()],
    );
  }

  Widget Footer() {
    List items = [
      FeatherIcons.home,
      FeatherIcons.search,
      FeatherIcons.bookOpen,
      FeatherIcons.settings
    ];
    List titles = ['Home', 'Search', 'Your Library', 'Premium'];
    return Container(
      color: Colors.white.withOpacity(0),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(items.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    activePage = index;
                  });
                },
                icon: Icon(
                  items[index],
                  color: activePage == index ? Colors.green : Colors.white,
                  size: 25,
                ),
              ),
              Text(
                titles[index],
                style:
                    TextStyle(color: Colors.white, fontSize: 10, height: 0.2),
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          );
        }),
      ),
    );
  }
}
