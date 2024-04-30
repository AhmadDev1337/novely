// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HorrorPage extends StatefulWidget {
  const HorrorPage({super.key});

  @override
  State<HorrorPage> createState() => _HorrorPageState();
}

class _HorrorPageState extends State<HorrorPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Horror",
      home: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
      ),
    );
  }
}
