// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PsychologyPage extends StatefulWidget {
  const PsychologyPage({super.key});

  @override
  State<PsychologyPage> createState() => _PsychologyPageState();
}

class _PsychologyPageState extends State<PsychologyPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Psychology",
      home: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
      ),
    );
  }
}
