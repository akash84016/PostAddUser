import 'package:flutter/cupertino.dart';

class BlankTab extends StatefulWidget {
  @override
  _BlankTabState createState() => _BlankTabState();
}

class _BlankTabState extends State<BlankTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Blank Tab",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
