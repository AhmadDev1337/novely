// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InspirativePage extends StatefulWidget {
  const InspirativePage({super.key});

  @override
  State<InspirativePage> createState() => _InspirativePageState();
}

class _InspirativePageState extends State<InspirativePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Inspirative",
      home: Scaffold(
        backgroundColor: Color(0xff2f2f2f),
      ),
    );
  }
}
