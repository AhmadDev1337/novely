// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FanFictionPage extends StatefulWidget {
  const FanFictionPage({super.key});

  @override
  State<FanFictionPage> createState() => _FanFictionPageState();
}

class _FanFictionPageState extends State<FanFictionPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fan Fiction",
      home: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
      ),
    );
  }
}
