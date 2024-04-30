// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RomancePage extends StatefulWidget {
  const RomancePage({super.key});

  @override
  State<RomancePage> createState() => _RomancePageState();
}

class _RomancePageState extends State<RomancePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Romance",
      home: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
      ),
    );
  }
}
