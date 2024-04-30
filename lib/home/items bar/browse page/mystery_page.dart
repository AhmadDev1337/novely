// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MysteryPage extends StatefulWidget {
  const MysteryPage({super.key});

  @override
  State<MysteryPage> createState() => _MysteryPageState();
}

class _MysteryPageState extends State<MysteryPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mystery",
      home: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
      ),
    );
  }
}
