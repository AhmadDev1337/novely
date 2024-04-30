// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ScienceFictionPage extends StatefulWidget {
  const ScienceFictionPage({super.key});

  @override
  State<ScienceFictionPage> createState() => _ScienceFictionPageState();
}

class _ScienceFictionPageState extends State<ScienceFictionPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Science Fiction",
      home: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
      ),
    );
  }
}
