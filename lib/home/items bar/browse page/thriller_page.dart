// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThrillerPage extends StatefulWidget {
  const ThrillerPage({super.key});

  @override
  State<ThrillerPage> createState() => _ThrillerPageState();
}

class _ThrillerPageState extends State<ThrillerPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Thriller",
      home: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
      ),
    );
  }
}
