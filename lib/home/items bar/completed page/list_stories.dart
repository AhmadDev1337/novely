// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';

class ListStoriesCompletedPage extends StatefulWidget {
  const ListStoriesCompletedPage({Key? key}) : super(key: key);

  @override
  State<ListStoriesCompletedPage> createState() =>
      _ListStoriesCompletedPageState();
}

class _ListStoriesCompletedPageState extends State<ListStoriesCompletedPage> {
  late List<dynamic> stories = [];
  int currentPage = 0;
  int itemsPerPage = 12;

  Future<void> fetchStories() async {
    final response =
        await http.get(Uri.parse('https://pastebin.com/raw/sR03t5mG'));
    if (response.statusCode == 200) {
      setState(() {
        stories = json.decode(response.body)['stories'];
      });
    } else {
      throw Exception('Failed to load stories');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStories();
  }

  List<dynamic> getCurrentPageStories() {
    final startIndex = currentPage * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return stories.sublist(
        startIndex, endIndex > stories.length ? stories.length : endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          stories.isEmpty
              ? Center(
                  child: SpinKitThreeBounce(
                    color: Color(0xffffff00),
                    size: 25,
                  ),
                )
              : AnimationLimiter(
                  child: AnimationConfiguration.synchronized(
                    duration: const Duration(milliseconds: 400),
                    child: SlideAnimation(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.decelerate,
                      child: FadeInAnimation(
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            childAspectRatio:
                                MediaQuery.of(context).size.width / 700,
                          ),
                          itemCount: getCurrentPageStories().length,
                          itemBuilder: (BuildContext context, int index) {
                            final currentStory = getCurrentPageStories()[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StoryDetail(
                                      title: stories[index]['title'],
                                      synopsis: stories[index]['synopsis'],
                                      hashtag: stories[index]['hashtag'],
                                      genre: stories[index]['genre'],
                                      thumbnail: stories[index]['thumbnail'],
                                      detail: stories[index]['chapters'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 130,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color(0xffb4b4b4),
                                            ),
                                          ),
                                          Positioned(
                                            top: 5,
                                            left: 5,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.yellow,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "END",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 5),
                                      child: Text(
                                        currentStory['title'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      currentStory['genre'],
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 10,
                                          color: Color(0xffffff00),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          currentStory['rating'],
                                          style: TextStyle(
                                            color: Color(0xffffff00),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
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
          SizedBox(
            height: 15,
          ),
          if (stories.length > itemsPerPage)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (currentPage > 0)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentPage--;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffffff00),
                      ),
                      child: Center(child: Icon(Icons.arrow_back_ios)),
                    ),
                  ),
                if (currentPage < (stories.length - 1) ~/ itemsPerPage)
                  SizedBox(width: 10),
                if (currentPage < (stories.length - 1) ~/ itemsPerPage)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentPage++;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffffff00),
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class StoryDetail extends StatefulWidget {
  final String title;
  final String synopsis;
  final String hashtag;
  final String genre;
  final String thumbnail;
  final List<dynamic> detail;

  StoryDetail({
    required this.title,
    required this.hashtag,
    required this.genre,
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
                          widget.genre,
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
      title: "Romance",
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
