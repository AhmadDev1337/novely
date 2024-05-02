// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_key_in_widget_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';

class FamilyPage extends StatefulWidget {
  @override
  _FamilyPageState createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  late List<dynamic> stories = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchStories();
  }

  Future<void> fetchStories() async {
    final response =
        await http.get(Uri.parse('https://pastebin.com/raw/KuyhcPFX'));
    if (response.statusCode == 200) {
      setState(() {
        stories = json.decode(response.body)['stories'];
      });
    } else {
      throw Exception('Failed to load stories');
    }
  }

  List<dynamic> filteredDataForSearch(String searchText) {
    return stories.where((data) {
      String title = data['title'].toLowerCase();
      String hashtag = data['hashtag'].toLowerCase();

      return title.contains(searchText.toLowerCase()) ||
          hashtag.contains(searchText.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Family",
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "#Family",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 30),
              Container(
                height: 17,
                width: 2,
                color: Colors.grey,
              ),
            ],
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.grey,
                ),
                onChanged: (value) {
                  setState(
                    () {
                      searchText = value;
                    },
                  );
                },
                decoration: InputDecoration(
                  icon: Icon(
                    IconlyLight.search,
                  ),
                  iconColor: Color(0xffffff00),
                  hintText: 'Search title or hashtag here...',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabled: true,
                ),
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: Color(0xff0d0d0d),
        ),
        backgroundColor: Color(0xff0d0d0d),
        body: stories.isEmpty
            ? Center(
                child: SpinKitThreeBounce(
                  color: Color(0xffffff00),
                  size: 25,
                ),
              )
            : ListView.builder(
                itemCount: filteredDataForSearch(searchText).length,
                itemBuilder: (context, index) {
                  final story = filteredDataForSearch(searchText)[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoryDetail(
                            title: filteredDataForSearch(searchText)[index]
                                ['title'],
                            synopsis: filteredDataForSearch(searchText)[index]
                                ['synopsis'],
                            hashtag: filteredDataForSearch(searchText)[index]
                                ['hashtag'],
                            thumbnail: filteredDataForSearch(searchText)[index]
                                ['thumbnail'],
                            detail: filteredDataForSearch(searchText)[index]
                                ['chapters'],
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
                                  filteredDataForSearch(searchText)[index]
                                      ['title'],
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
                                    Text(
                                      filteredDataForSearch(searchText)[index]
                                          ['rating'],
                                      style: TextStyle(
                                          color: Color(0xffffff00),
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  filteredDataForSearch(searchText)[index]
                                      ['synopsis'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
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
      ),
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
      title: "Family",
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
