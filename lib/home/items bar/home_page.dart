// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'home page/information_page.dart';
import 'home page/new_page.dart';
import 'home page/popular_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        NewPage(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: RichText(
            text: TextSpan(
              text: 'Rekomendasi buat kamu yang saat ini ',
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Tranding',
                  style: TextStyle(
                    color: Color(0xffffff00),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopularPage(),
        Divider(
          thickness: 0.5,
          height: 0.5,
          color: Color(0xffb4b4b4),
        ),
        InformationPage(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
