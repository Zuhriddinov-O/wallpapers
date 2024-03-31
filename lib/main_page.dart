import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wallpapers/pages/home_page.dart';
import 'package:wallpapers/pages/liked_page.dart';
import 'package:wallpapers/pages/random_page.dart';
import 'package:wallpapers/pages/rated_page.dart';
import 'package:wallpapers/storage/wallpapers.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  bool chosen = false;
  bool searchIsActive = false;
  List pages = [
    const HomePage(),
    const RatedPage(),
    const RandomPage(),
    LikedPage(),
  ];
  List<String> labelText = ["Home", "Rated", "Random", "Favorites"];
  List<Photos> foundUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu, size: 28));
          },
        ),
        backgroundColor: const Color(0xFFC2D9EC),
        title: Text(labelText[pageIndex]),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                searchIsActive = !searchIsActive;
              });
            },
            icon: pageIndex == 0
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        pageIndex = 3;
                      });
                    },
                    icon: Icon(pageIndex == 3 ? CupertinoIcons.home : CupertinoIcons.suit_heart))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                    icon: Icon(pageIndex == 3 ? CupertinoIcons.home : CupertinoIcons.suit_heart)),
          ),
        ],
      ),
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Color(0xFFC2D9EC))],
          color: Colors.transparent,
          backgroundBlendMode: BlendMode.screen,
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 10,
              right: MediaQuery.of(context).size.width / 10,
              bottom: 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              color: Colors.white30,
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        pageIndex = 0;
                      });
                    },
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          CircleBorder(),
                        ),
                        backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
                    icon: Image.asset(
                      pageIndex == 0 ? "assets/logos/home_icon.png" : "assets/logos/home_icon1.png",
                      color: pageIndex != 0 ? Colors.black : null,
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      pageIndex == 1
                          ? "assets/logos/rating_icon.png"
                          : "assets/logos/rating_icon1.png",
                      color: pageIndex != 1 ? Colors.black : null,
                    ),
                    color: pageIndex == 1 ? Colors.purpleAccent : Colors.black,
                    onPressed: () {
                      setState(() {
                        pageIndex = 1;
                      });
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      pageIndex == 2
                          ? "assets/logos/random_icon.png"
                          : "assets/logos/random_icon1.png",
                      color: pageIndex != 2 ? Colors.black : null,
                    ),
                    onPressed: () {
                      setState(() {
                        pageIndex = 2;
                      });
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      pageIndex == 3 ? "assets/logos/liked.png" : "assets/logos/liked1.png",
                      color: pageIndex != 3 ? Colors.black : null,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          pageIndex = 3;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(),
        backgroundColor: const Color(0xFFC2D9EC),
        child: ListView(
          addSemanticIndexes: true,
          children: [
            DrawerHeader(
              curve: Curves.bounceIn,
              decoration: Decoration.lerp(const MagnifierDecoration(), const MagnifierDecoration(),
                  VisualDensity.maximumDensity),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                      return const HeroPage();
                    })),
                    child: HeroMode(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/logos/basic_logo.png",
                              width: MediaQuery.of(context).size.width / 5.5,
                            ))),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "4K Full Wallpapers",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Image.asset("assets/logos/home_icon.png"),
              title: const Text("Home"),
              onTap: () {
                setState(() {
                  pageIndex = 0;
                  Navigator.of(context).pop();
                });
              },
            ),
            ListTile(
              leading: Image.asset("assets/logos/rating_icon.png"),
              title: const Text("Popular"),
              onTap: () {
                setState(() {
                  pageIndex = 1;
                  Navigator.of(context).pop();
                });
              },
            ),
            ListTile(
              leading: Image.asset("assets/logos/random_icon.png"),
              title: const Text("Random"),
              onTap: () {
                setState(() {
                  pageIndex = 2;
                  Navigator.of(context).pop();
                });
              },
            ),
            ListTile(
              leading: Image.asset("assets/logos/liked.png"),
              title: const Text("Liked"),
              onTap: () {
                setState(() {
                  pageIndex = 3;
                  Navigator.of(context).pop();
                });
              },
            ),
            Container(
              padding: const EdgeInsets.only(left: 0),
              height: MediaQuery.of(context).size.height / 2.7,
            ),
            const ListTile(
                leading: Text(
              "Photo Source:",
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/source_img0.png",
                    filterQuality: FilterQuality.high,
                  ),
                  const Gap(25),
                  Image.asset("assets/images/source_img1.png"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroPage extends StatelessWidget {
  const HeroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(tag: "helo", child: Image.asset("assets/logos/basic_logo.png"));
  }
}
