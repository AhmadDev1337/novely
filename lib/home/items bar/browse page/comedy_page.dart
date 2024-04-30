import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ComedyPage extends StatefulWidget {
  @override
  _ComedyPageState createState() => _ComedyPageState();
}

class _ComedyPageState extends State<ComedyPage> {
  late List<dynamic> stories = [];

  @override
  void initState() {
    super.initState();
    fetchStories();
  }

  Future<void> fetchStories() async {
    final response =
        await http.get(Uri.parse('https://pastebin.com/raw/aW2L5fkX'));
    if (response.statusCode == 200) {
      setState(() {
        stories = json.decode(response.body)['browsers'][0]['stories'];
      });
    } else {
      throw Exception('Failed to load stories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stories'),
      ),
      body: stories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                return ListTile(
                  title: Text(story['title']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoryDetail(story: story),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class StoryDetail extends StatelessWidget {
  final dynamic story;

  StoryDetail({required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story['title']),
      ),
      body: ListView.builder(
        itemCount: story['chapters'].length,
        itemBuilder: (context, index) {
          final chapter = story['chapters'][index];
          return ListTile(
            title: Text(chapter['title']),
            subtitle: Text('Rating: ${chapter['rating']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterDetail(chapter: chapter),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChapterDetail extends StatelessWidget {
  final dynamic chapter;

  ChapterDetail({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapter['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(chapter['content']),
      ),
    );
  }
}
