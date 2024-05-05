// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class TopWriterPage extends StatefulWidget {
  const TopWriterPage({super.key});

  @override
  State<TopWriterPage> createState() => _TopWriterPageState();
}

class _TopWriterPageState extends State<TopWriterPage> {
  late List<dynamic> writersA = [];
  late List<dynamic> writersB = [];

  Future<void> fetchWritersA() async {
    final response =
        await http.get(Uri.parse('https://pastebin.com/raw/vM1iewiZ'));
    if (response.statusCode == 200) {
      setState(() {
        writersA = json.decode(response.body)['writersA'];
      });
    } else {
      throw Exception('Failed to load writersA');
    }
  }

  Future<void> fetchWritersB() async {
    final response =
        await http.get(Uri.parse('https://pastebin.com/raw/xAmsGurT'));
    if (response.statusCode == 200) {
      setState(() {
        writersB = json.decode(response.body)['writersB'];
      });
    } else {
      throw Exception('Failed to load writersB');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWritersA();
    fetchWritersB();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          Column(
            children: [
              writersA.isEmpty
                  ? Center(
                      child: SpinKitThreeBounce(
                        color: Color(0xffffff00),
                        size: 25,
                      ),
                    )
                  : Row(
                      children: writersA.map<Widget>((writer) {
                        return _buildWriterItem(writer);
                      }).toList(),
                    ),
              writersB.isEmpty
                  ? Center(
                      child: SpinKitThreeBounce(
                        color: Color(0xffffff00),
                        size: 25,
                      ),
                    )
                  : Row(
                      children: writersB.map<Widget>((writer) {
                        return _buildWriterItem(writer);
                      }).toList(),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWriterItem(Map<String, dynamic> writer) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 65,
      width: 275,
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffffff00),
            ),
            child: Center(
              child: Text("1"),
            ),
          ),
          SizedBox(width: 10),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  writer['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  writer['genre'],
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
