// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_staggered_animations/flutter_staggered_animations.dart";
import 'package:http/http.dart' as http;
import "package:iconly/iconly.dart";
import "package:novely/home/items%20bar/browse%20page/fan-fiction_page.dart";
import "package:novely/home/items%20bar/browse%20page/history_page.dart";
import "package:novely/home/items%20bar/browse%20page/mystery_page.dart";

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
  late List<dynamic> songs = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final response =
        await http.get(Uri.parse('https://pastebin.com/raw/zK7GzAh7'));
    if (response.statusCode == 200) {
      setState(() {
        songs = json.decode(response.body)['songs'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<dynamic> filteredDataForSearch(String searchText) {
    return songs.where((data) {
      String name = data['name'].toLowerCase();
      String title = data['title'].toLowerCase();
      String youTube = data['youTube'].toLowerCase();
      return name.contains(searchText.toLowerCase()) ||
          title.contains(searchText.toLowerCase()) ||
          youTube.contains(searchText.toLowerCase());
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
                hintText: 'Search #tags here...',
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
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.7),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      filteredDataForSearch(searchText).length < 4
                          ? filteredDataForSearch(searchText).length
                          : 4,
                      (index) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  filteredDataForSearch(searchText)[index]
                                      ['imgUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                              imgUrl: filteredDataForSearch(
                                                  searchText)[index]['imgUrl'],
                                              logoUrl: filteredDataForSearch(
                                                  searchText)[index]['logoUrl'],
                                              name: filteredDataForSearch(
                                                  searchText)[index]['name'],
                                              youTube: filteredDataForSearch(
                                                  searchText)[index]['youTube'],
                                              tikTok: filteredDataForSearch(
                                                  searchText)[index]['tikTok'],
                                              title: filteredDataForSearch(
                                                  searchText)[index]['title'],
                                              detail: filteredDataForSearch(
                                                      searchText)[index]
                                                  ['detailPage'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(250),
                                          color: Colors.grey.shade900,
                                        ),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(250),
                                              child: Image.network(
                                                filteredDataForSearch(
                                                        searchText)[index]
                                                    ['logoUrl'],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          filteredDataForSearch(
                                              searchText)[index]['name'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          filteredDataForSearch(
                                              searchText)[index]['title'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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

class DetailPage extends StatefulWidget {
  final String imgUrl;
  final String logoUrl;
  final String name;
  final String youTube;
  final String tikTok;
  final String title;
  final List<dynamic> detail;

  DetailPage({
    required this.imgUrl,
    required this.logoUrl,
    required this.name,
    required this.youTube,
    required this.tikTok,
    required this.title,
    required this.detail,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String searchText = '';

  List<dynamic> filterDataByTitle(String searchText) {
    return widget.detail.where((data) {
      String title = data['titleSong'].toLowerCase();
      return title.contains(searchText.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MoodPlay",
      home: Scaffold(
        backgroundColor: Color(0xff0d0d0d),
        appBar: AppBar(
          backgroundColor: Color(0xff0d0d0d),
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                SizedBox(width: 18),
                Text(
                  "Playlist Song",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search song...',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.imgUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(250),
                          color: Colors.grey.shade900,
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(250),
                              child: Image.network(
                                widget.logoUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "YouTube :",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  widget.youTube,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TikTok :",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  widget.tikTok,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 20, top: 40),
              child: Text(
                "Videos",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filterDataByTitle(searchText).length,
                itemBuilder: (BuildContext context, int index) {
                  var filteredData = filterDataByTitle(searchText);
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(
                              width: 130,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  filteredData[index]['thumbnail'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredData[index]['titleSong'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    filteredData[index]['nameAccount'],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
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
