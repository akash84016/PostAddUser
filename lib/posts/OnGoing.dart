import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_user/model/JobDetailsModel.dart';
import 'package:velo_user/model/UserModel.dart';
import 'package:velo_user/screens/CategoryLists.dart';
import 'package:velo_user/utils_screens/Constants.dart';
import 'package:velo_user/utils_screens/FirebaseTables.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'package:velo_user/utils_screens/common_widget.dart';

import 'PostDetails.dart';

class Ongoing extends StatefulWidget {
  static const String tag = "Ongoing ";

  @override
  _OngoingState createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {
  UserModel userModel;
  List<JobDetailsModel> modelArrayList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: modelArrayList.length,
                  itemBuilder: (context, i) => InkWell(
                        onTap: () {
                          MySharedPref().setJobDescModel(
                              modelArrayList[i], jobDetailsModelSave);
                          nextScreen(context, PostDetail(Ongoing.tag));
                        },
                        child: Column(
                          children: <Widget>[
                            dataAdd(modelArrayList[i]),
                          ],
                        ),
                      ))),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(right: 10, left: 10),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: FlatButton(
                onPressed: () {
                  nextScreen(context, CategoryLists(Ongoing.tag));
                },
                child: Text(
                  "Add New Post",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = MySharedPref().getUserModel(userModelSave);
    postsRef
        .orderByChild(uidKey)
        .equalTo(userModel.uid)
        .onValue
        .listen(_onEntryAdded);
  }

  void _onEntryAdded(Event event) {
    if (this.mounted) {
      List<JobDetailsModel> newList = [];
      dynamic value = event.snapshot.value;
      if (value != null) {
        value.forEach((key, values) {
          JobDetailsModel model = JobDetailsModel.fromJson(values);
          String hr = hrDiff(model.time);
          if (model.status) {
            model.id = key;
            model.time = hr;
            newList.add(model);
          }
        });
      }
      newList.sort((a, b) => b.time.compareTo(a.time));
      setState(() {
        modelArrayList = newList;
      });
    }
  }

  dataAdd(JobDetailsModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 6.3, right: 18, left: 18),
      child: Container(
        width: double.infinity,
        decoration: new BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 15, bottom: 15, left: 11.7, right: 11.7),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  model.title,
                  style: TextStyle(
                      color: Color(0xff202125),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.7),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  model.info,
                  style: TextStyle(
                      color: Color(0xff707579),
                      letterSpacing: 0.0625,
                      height: 1.3,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.3),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 5,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    model.time + ' Hours Left',
                    style: TextStyle(
                        color: Color(0xff202125),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Text(model.views + " Views",
                      style: const TextStyle(
                          color: const Color(0xff8b8e95),
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: 13.3),
                      textAlign: TextAlign.right)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
