import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_user/model/JobDetailsModel.dart';
import 'package:velo_user/model/UserModel.dart';
import 'package:velo_user/screens/HomePage.dart';
import 'package:velo_user/screens/JobContackInfo.dart';
import 'package:velo_user/utils_screens/Constants.dart';
import 'package:velo_user/utils_screens/FirebaseTables.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'package:velo_user/utils_screens/common_widget.dart';

class PostDetail extends StatefulWidget {
  String checker;

  PostDetail(this.checker);

  @override
  _PostDetailState createState() => _PostDetailState(checker);
}

class _PostDetailState extends State<PostDetail> {
  UserModel userModel;
  JobDetailsModel jobDetailsModel;

  String getChecker;

  var tvUserName;

  _PostDetailState(this.getChecker);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            appBar: toolbar(context, "",
                getChecker == JobContactInfo.tag ? HomePage() : null),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Architectural project visualization
                        Text(jobDetailsModel.title,
                            style: const TextStyle(
                                color: const Color(0xff202125),
                                fontWeight: FontWeight.w500,
                                fontFamily: "SFProDisplay",
                                fontStyle: FontStyle.normal,
                                fontSize: 22.0),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              '-',
                              style: TextStyle(
                                  color: Color(0xff8591a4), fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            // Vadodara / Gujarat
                            Text(jobDetailsModel.jobContackDetails.location,
                                style: const TextStyle(
                                    color: const Color(0xff8591a4),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "SFProDisplay",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0),
                                textAlign: TextAlign.left)
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Posted by Aakib Khilji

                        Align(
                            alignment: Alignment.centerLeft,
                            child: FutureBuilder(
                                future: userRef
                                    .child(jobDetailsModel.uid)
                                    .child(nameKey)
                                    .once(),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    return Text(
                                        "Posted by " +
                                            snapShot.data.value.toString(),
                                        key: tvUserName,
                                        style: const TextStyle(
                                            color: const Color(0xff202125),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SFProDisplay",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0),
                                        textAlign: TextAlign.left);
                                  } else {
                                    return Text("Posted by -",
                                        key: tvUserName,
                                        style: const TextStyle(
                                            color: const Color(0xff202125),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SFProDisplay",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0),
                                        textAlign: TextAlign.left);
                                  }
                                })),
                        SizedBox(
                          height: 20,
                        ),
                        // I'm looking for a designer to create architectural
                        Text(jobDetailsModel.info,
                            style: const TextStyle(
                                color: const Color(0xff202125),
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFProDisplay",
                                fontStyle: FontStyle.normal,
                                height: 1.3,
                                fontSize: 15.0),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 25,
                        ),
                        // This post will expire in 9 hours
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              jobDetailsModel.time.isEmpty
                                  ? "This post is Expire"
                                  : "This post will expire in ${jobDetailsModel.time} hours",
                              style: const TextStyle(
                                  color: const Color(0xffff1414),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "SFProDisplay",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.0),
                              textAlign: TextAlign.left),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Visibility(
                            visible: userModel.uid == jobDetailsModel.uid,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Post Analytics",
                                      style: const TextStyle(
                                          color: const Color(0xff202125),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFProDisplay",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18.3),
                                      textAlign: TextAlign.left),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      // Views
                                      Text("Views",
                                          style: const TextStyle(
                                              color: const Color(0xff707579),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "SFProDisplay",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.0),
                                          textAlign: TextAlign.left),
                                      // 0
                                      Text(jobDetailsModel.views,
                                          style: const TextStyle(
                                              color: const Color(0xff202125),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "SFProDisplay",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.0),
                                          textAlign: TextAlign.right)
                                    ],
                                  ),
                                ),
                                new Container(
                                  margin: new EdgeInsetsDirectional.only(
                                      start: 1.0, end: 1.0),
                                  height: 1,
                                  width: double.infinity,
                                  color: Color(0xffdadcde),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      // Views
                                      Text("Respons",
                                          style: const TextStyle(
                                              color: const Color(0xff707579),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "SFProDisplay",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.0),
                                          textAlign: TextAlign.left),
                                      // 0
                                      Text("0",
                                          style: const TextStyle(
                                              color: const Color(0xff202125),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "SFProDisplay",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.0),
                                          textAlign: TextAlign.right)
                                    ],
                                  ),
                                ),
                                new Container(
                                  margin: new EdgeInsetsDirectional.only(
                                      start: 1.0, end: 1.0),
                                  height: 1,
                                  width: double.infinity,
                                  color: Color(0xffdadcde),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            )),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Contact Information",
                              style: const TextStyle(
                                  color: const Color(0xff202125),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "SFProDisplay",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.3),
                              textAlign: TextAlign.left),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Views
                              Text("Name",
                                  style: const TextStyle(
                                      color: const Color(0xff707579),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "SFProDisplay",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.left),
                              // 0
                              Text(jobDetailsModel.jobContackDetails.name,
                                  style: const TextStyle(
                                      color: const Color(0xff202125),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "SFProDisplay",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.right)
                            ],
                          ),
                        ),
                        new Container(
                          margin: new EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 1,
                          width: double.infinity,
                          color: Color(0xffdadcde),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Views
                              Text("Mobile number",
                                  style: const TextStyle(
                                      color: const Color(0xff707579),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "SFProDisplay",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.left),
                              // 0
                              Text(jobDetailsModel.jobContackDetails.number,
                                  style: const TextStyle(
                                      color: const Color(0xff202125),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "SFProDisplay",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.right)
                            ],
                          ),
                        ),
                        new Container(
                          margin: new EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 1,
                          width: double.infinity,
                          color: Color(0xffdadcde),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Views
                              Text("Whatsapp",
                                  style: const TextStyle(
                                      color: const Color(0xff707579),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "SFProDisplay",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.left),
                              // 0
                              Text(
                                  jobDetailsModel
                                          .jobContackDetails.whatsAppNum ??
                                      "",
                                  style: const TextStyle(
                                      color: const Color(0xff202125),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "SFProDisplay",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.right)
                            ],
                          ),
                        ),
                        new Container(
                          margin: new EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 1,
                          width: double.infinity,
                          color: Color(0xffdadcde),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Views
                              Text("Skype",
                                  style: const TextStyle(
                                      color: const Color(0xff707579),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "SFProDisplay",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.left),
                              // 0
                              Text(
                                  jobDetailsModel.jobContackDetails.skypeNum ??
                                      "",
                                  style: const TextStyle(
                                      color: const Color(0xff202125),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "SFProDisplay",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.right)
                            ],
                          ),
                        ),
                        new Container(
                          margin: new EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 1,
                          width: double.infinity,
                          color: Color(0xffdadcde),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Views
                              Text("Location",
                                  style: const TextStyle(
                                      color: const Color(0xff707579),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "SFProDisplay",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.left),
                              // 0
                              Text(jobDetailsModel.jobContackDetails.location,
                                  style: const TextStyle(
                                      color: const Color(0xff202125),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "SFProDisplay",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.0),
                                  textAlign: TextAlign.right)
                            ],
                          ),
                        ),
                        new Container(
                          margin: new EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 1,
                          width: double.infinity,
                          color: Color(0xffdadcde),
                        ),

                        Visibility(
                            visible: userModel.uid == jobDetailsModel.uid,
                            child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 30, bottom: 30),
                                decoration: new BoxDecoration(
                                    color: Color(0xfff1f1f1),
                                    border: Border.all(
                                        width: 1, color: Color(0xff000000)),
                                    borderRadius: BorderRadius.circular(25.0)),
                                child: FlatButton(
                                  onPressed: () {
                                    postsRef
                                        .child(jobDetailsModel.id)
                                        .child(statusKey)
                                        .set(false)
                                        .then((value) => _onBackPressed());
                                  },
                                  child: Text(
                                    'Close this job',
                                    style: new TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                        fontFamily: 'SFProDisplay',
                                        fontWeight: FontWeight.w500),
                                  ),
                                )))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() {
    if (getChecker == JobContactInfo.tag) {
      return nextScreenWithClear(context, HomePage()) ?? false;
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userModel = MySharedPref().getUserModel(userModelSave);
    jobDetailsModel = MySharedPref().getJobDescModel(jobDetailsModelSave);

    viewsAddLogin();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    MySharedPref().clear(jobDetailsModelSave);
    MySharedPref().clear(categoryModelSave);
    MySharedPref().clear(subCategoryModelSave);
    super.dispose();
  }

  void viewsAddLogin() {
    var viewRef = postsViewsRef.child(jobDetailsModel.id).child(userModel.uid);
    viewRef.once().then((snap) {
      if (snap.value == null) {
        viewRef
            .set(DateTime.now().millisecondsSinceEpoch.toString())
            .then((value) => print("viewAdd"));

        var viewAddRef = postsRef.child(jobDetailsModel.id).child(viewsKey);
        viewAddRef.once().then((value) {
          int oldViews = 1;
          if (value.value != null) {
            oldViews = int.parse(value.value);
            oldViews++;
            viewAddRef.set(oldViews.toString());
          } else {
            viewAddRef.set(oldViews.toString());
          }

          setState(() {
            jobDetailsModel.views = oldViews.toString();
          });
        });
      }
    });
  }
}
