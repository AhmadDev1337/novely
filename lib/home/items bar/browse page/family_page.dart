// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Family",
      home: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
      ),
    );
  }
}
