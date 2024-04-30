// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FantacyPage extends StatefulWidget {
  const FantacyPage({super.key});

  @override
  State<FantacyPage> createState() => _FantacyPageState();
}

class _FantacyPageState extends State<FantacyPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fantacy",
      home: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
      ),
    );
  }
}
