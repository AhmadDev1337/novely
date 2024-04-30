// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'items bar/home_page.dart';
import 'items bar/browse_page.dart';
import 'items bar/completed_page.dart';

class BarController extends StatefulWidget {
  const BarController({Key? key}) : super(key: key);

  @override
  State<BarController> createState() => _BarControllerState();
}

class _BarControllerState extends State<BarController> {
  int currentPageIndex = 0;
  late PageController _pageController;

  final List<String> items = [
    "Home",
    "Browse",
    "Completed",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Novely",
      home: Scaffold(
        backgroundColor: Color(0xff0d0d0d),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Novely",
                          style: TextStyle(
                              color: Color(0xffffff00),
                              fontWeight: FontWeight.w800,
                              fontSize: 23),
                        ),
                        Icon(
                          IconlyLight.swap,
                          color: Color(0xffffff00),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentPageIndex = index;
                              });
                              _pageController.animateToPage(
                                index,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Center(
                                    child: Text(
                                      items[index],
                                      style: TextStyle(
                                          color: currentPageIndex == index
                                              ? Color(0xffffff00)
                                              : Color(0xffb4b4b4),
                                          fontSize: currentPageIndex == index
                                              ? 18
                                              : 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: currentPageIndex == index ? 3 : 0,
                                  width: currentPageIndex == index ? 30 : 0,
                                  decoration: BoxDecoration(
                                    color: currentPageIndex == index
                                        ? Color(0xffffff00)
                                        : Color(0xffb4b4b4),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: BouncingScrollPhysics(),
                      itemCount: items.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentPageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return buildItemPage(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return BrowsePage();
      case 2:
        return CompletedPage();
      default:
        return Container();
    }
  }
}
