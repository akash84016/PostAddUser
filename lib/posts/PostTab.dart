import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Expired.dart';
import 'OnGoing.dart';

class PostTab extends StatefulWidget {
  @override
  _PostTabState createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
          title: Text("YOUR POSTS",
              style: const TextStyle(
                  color: const Color(0xff202125),
                  fontWeight: FontWeight.w600,
                  fontFamily: "SFProDisplay",
                  fontStyle: FontStyle.normal,
                  fontSize: 18.3),
              textAlign: TextAlign.left),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xfffafafa),
          bottom: new PreferredSize(
            preferredSize: new Size(0, 40),
            child: new Container(
              child: new TabBar(
                isScrollable: false,
                //indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color(0xfffa5805),
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.black26,
                labelPadding: EdgeInsets.symmetric(horizontal: 22.0),

                tabs: <Widget>[
                  new Tab(
                    child: Text("Ongoing post"),
                  ),
                  new Tab(
                    child: Text("Expired"),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            new Container(
              child: Ongoing(),
            ),
            new Container(
              child: Expired(),
            ),
          ],
        ),
      ),
    );
  }
}
