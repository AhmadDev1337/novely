// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, unused_local_variable, deprecated_member_use, prefer_final_fields

import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:flutter_staggered_animations/flutter_staggered_animations.dart";
import 'package:http/http.dart' as http;
import "package:iconly/iconly.dart";
import "package:novely/home/items%20bar/browse%20page/fan-fiction_page.dart";
import "package:novely/home/items%20bar/browse%20page/history_page.dart";
import "package:novely/home/items%20bar/browse%20page/mystery_page.dart";
import "package:url_launcher/url_launcher.dart";

import "browse page/adventure_page.dart";
import "browse page/family_page.dart";
import "browse page/fantacy_page.dart";
import "browse page/horror_page.dart";
import 'browse page/comedy_page.dart';
import "browse page/inspirative_page.dart";
import "browse page/psychology_page.dart";
import 'browse page/sience-fiction_page.dart';
import "browse page/romance_page.dart";
import "browse page/thriller_page.dart";

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  late List<dynamic> bankNovels = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final response =
        await http.get(Uri.parse('https://pastebin.com/raw/3G7ZNzEK'));
    if (response.statusCode == 200) {
      setState(() {
        bankNovels = json.decode(response.body)['bankNovels'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<dynamic> filteredDataForSearch(String searchText) {
    return bankNovels.where((data) {
      String userName = data['userName'].toLowerCase();
      String instagram = data['instagram'].toLowerCase();
      bool storyFound = false;

      // Mencari di judul dan hashtag di setiap story
      for (var story in data['stories']) {
        String storyTitle = story['title'].toLowerCase();
        String hashtag = story['hashtag'].toLowerCase();

        if (storyTitle.contains(searchText.toLowerCase()) ||
            hashtag.contains(searchText.toLowerCase())) {
          storyFound = true;
          break;
        }
      }

      return userName.contains(searchText.toLowerCase()) ||
          instagram.contains(searchText.toLowerCase()) ||
          storyFound; // Menambahkan hasil pencarian di Story
    }).toList();
  }

  final List<Map<String, dynamic>> genresA = [
    {
      'name': 'Comedy',
      'detailPage': ComedyPage(),
    },
    {
      'name': 'Family',
      'detailPage': FamilyPage(),
    },
    {
      'name': 'Horror',
      'detailPage': HorrorPage(),
    },
  ];

  final List<Map<String, dynamic>> genresB = [
    {
      'name': 'Adventure',
      'detailPage': AdventurePage(),
    },
    {
      'name': 'History',
      'detailPage': HistoryPage(),
    },
    {
      'name': 'Psychology',
      'detailPage': PsychologyPage(),
    },
  ];

  final List<Map<String, dynamic>> genresC = [
    {
      'name': 'Inspirative',
      'detailPage': InspirativePage(),
    },
    {
      'name': 'Mystery',
      'detailPage': MysteryPage(),
    },
  ];

  final List<Map<String, dynamic>> genresD = [
    {
      'name': 'Thriller',
      'detailPage': ThrillerPage(),
    },
    {
      'name': 'Romance',
      'detailPage': RomancePage(),
    },
    {
      'name': 'Fantacy',
      'detailPage': FantacyPage(),
    },
  ];

  final List<Map<String, dynamic>> genresE = [
    {
      'name': 'Fan Fiction',
      'detailPage': FanFictionPage(),
    },
    {
      'name': 'Science Fiction',
      'detailPage': ScienceFictionPage(),
    },
  ];

  void _navigateToDetailPage(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 45,
            child: TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(
                  () {
                    searchText = value;
                  },
                );
              },
              decoration: InputDecoration(
                icon: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffffff00),
                  ),
                  child: Icon(
                    IconlyLight.search,
                  ),
                ),
                iconColor: Colors.black,
                hintText: 'Search #tags, title, writer name here...',
                hintStyle: TextStyle(color: Colors.grey),
                enabled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffffff00),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: genresA.map((genre) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToDetailPage(context, genre['detailPage']);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffb4b4b4),
                      ),
                      child: Center(
                        child: Text(
                          genre['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: genresB.map((genre) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToDetailPage(context, genre['detailPage']);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffb4b4b4),
                      ),
                      child: Center(
                        child: Text(
                          genre['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: genresC.map((genre) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToDetailPage(context, genre['detailPage']);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffb4b4b4),
                      ),
                      child: Center(
                        child: Text(
                          genre['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: genresD.map((genre) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToDetailPage(context, genre['detailPage']);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffb4b4b4),
                      ),
                      child: Center(
                        child: Text(
                          genre['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: genresE.map((genre) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToDetailPage(context, genre['detailPage']);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffb4b4b4),
                      ),
                      child: Center(
                        child: Text(
                          genre['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10, left: 10, top: 25),
          child: Text(
            "Random Stories",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        AnimationLimiter(
          child: AnimationConfiguration.synchronized(
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              curve: Curves.decelerate,
              child: FadeInAnimation(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: bankNovels.isEmpty
                      ? Center(
                          child: SpinKitThreeBounce(
                            color: Color(0xffffff00),
                            size: 25,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredDataForSearch(searchText).length,
                          itemBuilder: (context, index) {
                            final bankNovel =
                                filteredDataForSearch(searchText)[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserStoriesPage(
                                      userName: filteredDataForSearch(
                                          searchText)[index]['userName'],
                                      instagram: filteredDataForSearch(
                                          searchText)[index]['instagram'],
                                      statusBio: filteredDataForSearch(
                                          searchText)[index]['statusBio'],
                                      detail: filteredDataForSearch(
                                          searchText)[index]['stories'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            filteredDataForSearch(
                                                searchText)[index]['userName'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 13,
                                                color: Color(0xffffff00),
                                              ),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StoryDetail extends StatefulWidget {
  final String title;
  final String synopsis;
  final String hashtag;
  final String thumbnail;
  final List<dynamic> detail;

  StoryDetail({
    required this.title,
    required this.hashtag,
    required this.synopsis,
    required this.thumbnail,
    required this.detail,
  });

  @override
  State<StoryDetail> createState() => _StoryDetailState();
}

class _StoryDetailState extends State<StoryDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "#Chapter",
      home: Scaffold(
        backgroundColor: Color(0xff0d0d0d),
        body: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              height: 250,
              color: Colors.grey,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 15,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        IconlyLight.arrow_left,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Synopsis:'),
                              content: Text(widget.synopsis),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.info_sharp,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Family",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Eh, Sorry Kesantet!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.hashtag,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.detail.length,
                itemBuilder: (context, index) {
                  final chapter = widget.detail[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChapterDetail(chapter: chapter),
                        ),
                      );
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '#${chapter['chapterNumber']}',
                                    style: TextStyle(
                                        color: Color(0xffffff00),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        chapter['title'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        chapter['datePost'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.arrow_right,
                              size: 17,
                              color: Color(0xffb4b4b4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChapterDetail extends StatefulWidget {
  final dynamic chapter;

  ChapterDetail({required this.chapter});

  @override
  State<ChapterDetail> createState() => _ChapterDetailState();
}

class _ChapterDetailState extends State<ChapterDetail> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bio",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: _isDarkMode ? Colors.white : Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(IconlyLight.arrow_left,
                        color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white),
                    SizedBox(width: 15),
                    Text(
                      widget.chapter['title'],
                      style: TextStyle(
                          color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                },
                child: Icon(
                  _isDarkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: _isDarkMode ? Colors.white : Color(0xff0d0d0d),
        body: ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 170,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 17, left: 17, right: 17, bottom: 70),
              child: Text(
                widget.chapter['content'],
                style: TextStyle(
                    color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Divider(
              thickness: 0.5,
              height: 0.5,
              color: Color(0xffb4b4b4),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Writer:",
                          style: TextStyle(
                              color: _isDarkMode
                                  ? Color(0xff0d0d0d)
                                  : Colors.white,
                              fontSize: 13),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.chapter['userName'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: _isDarkMode
                                  ? Color(0xff0d0d0d)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserStoriesPage extends StatefulWidget {
  final String userName;
  final String instagram;
  final String statusBio;
  final List<dynamic> detail;

  UserStoriesPage({
    required this.userName,
    required this.statusBio,
    required this.instagram,
    required this.detail,
  });

  @override
  State<UserStoriesPage> createState() => _UserStoriesPageState();
}

class _UserStoriesPageState extends State<UserStoriesPage> {
  bool _isDarkMode = false;
  int currentPageIndex = 0;

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Profile",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: _isDarkMode ? Color(0xfff2f2f2) : Color(0xff0d0d0d),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                },
                child: Icon(
                  _isDarkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: _isDarkMode ? Color(0xfff2f2f2) : Color(0xff0d0d0d),
        body: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Icon(
                    Icons.person,
                    color: themeData.textTheme.bodyText1!.color,
                    size: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    widget.userName,
                    style: TextStyle(
                      color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 25, right: 25),
                  child: Text(
                    widget.statusBio,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _isDarkMode ? Color(0xff0d0d0d) : Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchURL(widget.instagram);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffffff00),
                        ),
                        child: Center(
                          child: Text(
                            "Follow",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isDarkMode
                                  ? Color(0xff0d0d0d)
                                  : Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey,
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/instagram.png",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 40, bottom: 15),
              child: Text(
                "Stories",
                style: TextStyle(
                  color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.detail.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryDetail(
                          title: widget.detail[index]['title'],
                          synopsis: widget.detail[index]['synopsis'],
                          hashtag: widget.detail[index]['hashtag'],
                          thumbnail: widget.detail[index]['thumbnail'],
                          detail: widget.detail[index]['chapters'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.detail[index]['title'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: _isDarkMode
                                      ? Color(0xff0d0d0d)
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 13,
                                    color: Color(0xffffff00),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.detail[index]['rating'],
                                    style: TextStyle(
                                        color: Color(0xffffff00), fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                widget.detail[index]['synopsis'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                    color: _isDarkMode
                                        ? Color(0xff0d0d0d)
                                        : Colors.grey,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
