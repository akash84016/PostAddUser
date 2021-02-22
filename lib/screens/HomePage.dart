import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_user/posts/PostTab.dart';
import 'package:velo_user/screens/Login.dart';
import 'package:velo_user/tabs/BlankTab.dart';
import 'package:velo_user/tabs/HomeTab.dart';
import 'package:velo_user/utils_screens/Constants.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'package:velo_user/utils_screens/common_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final tabs = [
    HomeTab(),
    PostTab(),
    BlankTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: tabs[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color(0xfffa5805),
            unselectedItemColor: Color(0xff8591a4),
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(Icons.collections_bookmark),
                  title: Text('Post'),
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(Icons.more_horiz),
                  title: Text('Logout'),
                  backgroundColor: Colors.black),
            ],
            onTap: (index) {
              if (index == 2) {
                MySharedPref().clear(userModelSave);
                nextScreenWithClear(context, Login());
              } else {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
          ),
        ),
        onWillPop: onBackPressed);
  }

  Future<bool> onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
