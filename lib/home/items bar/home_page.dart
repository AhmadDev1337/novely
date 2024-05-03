// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';

import 'home page/information_page.dart';
import 'home page/new_page.dart';
import 'home page/popular_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImageCarousel();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchImageCarousel() async {
    final response =
        await http.get(Uri.parse('https://pastebin.com/raw/R3vnDxrv'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        imageUrls = List<String>.from(data);
      });
      // Start automatic image change
      startImageSlider();
    } else {
      Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Center(
            child: SpinKitWave(
              color: Color(0xFFE1261C),
              size: 25,
            ),
          ),
        ),
      );
    }
  }

  void startImageSlider() {
    Timer.periodic(Duration(seconds: 6), (Timer timer) {
      if (_pageController.page! < imageUrls.length - 1) {
        _pageController.nextPage(
          duration: Duration(seconds: 6),
          curve: Curves.easeIn,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: Duration(seconds: 6),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        imageUrls.isEmpty
            ? Center(
                child: SpinKitThreeBounce(
                  color: Color(0xffffff00),
                  size: 25,
                ),
              )
            : SizedBox(
                height: 250,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      imageUrls[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: imageUrls.length,
                  viewportFraction: 0.8,
                  autoplay: true,
                  scale: 0.9,
                ),
              ),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 20),
          child: RichText(
            text: TextSpan(
              text: 'New Stories ',
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'For You',
                  style: TextStyle(
                    color: Color(0xffffff00),
                  ),
                ),
              ],
            ),
          ),
        ),
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
