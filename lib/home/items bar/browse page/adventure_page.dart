// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';

class AdventurePage extends StatefulWidget {
  @override
  _AdventurePageState createState() => _AdventurePageState();
}

class _AdventurePageState extends State<AdventurePage> {
  late List<dynamic> browsers = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchBrowsers();
  }

  Future<void> fetchBrowsers() async {
    final response =
        await http.get(Uri.parse('https://pastebin.com/raw/LJRs6D98'));
    if (response.statusCode == 200) {
      setState(() {
        browsers = json.decode(response.body)['browsers'];
      });
    } else {
      throw Exception('Failed to load browsers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Adventure",
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                "#Adventure",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
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
                  hintText: 'Search #tags here...',
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
        body: browsers.isEmpty
            ? Center(
                child: SpinKitThreeBounce(
                  color: Color(0xffffff00),
                  size: 25,
                ),
              )
            : ListView.builder(
                itemCount: browsers.length,
                itemBuilder: (context, index) {
                  final browser = browsers[index];
                  return ListTile(
                    title: Text(
                      browser['name'],
                      style: TextStyle(color: Colors.grey),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(detailPage: browser['detailPage']),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final List<dynamic> detailPage;

  DetailPage({required this.detailPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: ListView.builder(
        itemCount: detailPage.length,
        itemBuilder: (context, index) {
          final page = detailPage[index];
          return Column(
            children: [
              ListTile(
                title: Text(page['nameAccount']),
                subtitle: Text('Tags: ${page['tags']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StoryDetail(storyDetail: page['detailPage']),
                    ),
                  );
                },
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}

class StoryDetail extends StatelessWidget {
  final List<dynamic> storyDetail;

  StoryDetail({required this.storyDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Detail'),
      ),
      body: ListView.builder(
        itemCount: storyDetail.length,
        itemBuilder: (context, index) {
          final detail = storyDetail[index];
          return Column(
            children: [
              ListTile(
                title: Text(detail['chapter']),
                subtitle: Text('Rating: ${detail['rating']}'),
                onTap: () {
                  // Do something when a chapter is tapped
                },
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
