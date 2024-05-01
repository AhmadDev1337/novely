// ignore_for_file: prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileWriterPage extends StatefulWidget {
  const ProfileWriterPage({Key? key}) : super(key: key);

  @override
  _ProfileWriterPageState createState() => _ProfileWriterPageState();
}

class _ProfileWriterPageState extends State<ProfileWriterPage> {
  bool _isDarkMode = false;

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: _isDarkMode ? Colors.white : Color(0xff0d0d0d),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                },
                child: Icon(
                  _isDarkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: _isDarkMode ? Colors.white : Color(0xff0d0d0d),
        body: ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Icon(
                    Icons.person,
                    color: themeData.textTheme.bodyText1!.color,
                    size: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "@ahmad_dev1337",
                    style: TextStyle(
                      color: _isDarkMode ? Color(0xff0d0d0d) : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 25, right: 25),
                  child: Text(
                    "Seorang Pengembang Aplikasi Android & Developer Aplikasi Novely",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _isDarkMode ? Color(0xff0d0d0d) : Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchURL(
                        "https://www.instagram.com/ahmad_dev1337/?igshid=MzNINGNkZWQ4Mg==");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.followButtonColor,
                        ),
                        child: Center(
                          child: Text(
                            "Follow",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey,
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/instagram.png",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppColors {
  static const Color primaryColor = Color(0xff0d0d0d);
  static const Color profileIconColor = Colors.black;
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Color(0xffb4b4b4);
  static const Color buttonColor = Color(0xffffff00);
  static const Color iconBackgroundColor = Colors.grey;
  static const Color followButtonColor = Color(0xffffff00);
}
