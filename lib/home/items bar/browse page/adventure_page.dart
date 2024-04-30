import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdventurePage extends StatefulWidget {
  @override
  _AdventurePageState createState() => _AdventurePageState();
}

class _AdventurePageState extends State<AdventurePage> {
  late List<dynamic> browsers = [];

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Stories'),
      ),
      body: browsers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: browsers.length,
              itemBuilder: (context, index) {
                final browser = browsers[index];
                return ListTile(
                  title: Text(browser['name']),
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
