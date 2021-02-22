import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_user/model/JobDetailsModel.dart';
import 'package:velo_user/model/UserModel.dart';
import 'package:velo_user/utils_screens/Constants.dart';
import 'package:velo_user/utils_screens/FirebaseTables.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'package:velo_user/utils_screens/common_widget.dart';

import 'PostDetails.dart';

class Expired extends StatefulWidget {
  static const String tag = "Expired ";

  @override
  _ExpiredState createState() => _ExpiredState();
}

class _ExpiredState extends State<Expired> {
  UserModel userModel;
  List<JobDetailsModel> modelArrayList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: modelArrayList.length,
                  itemBuilder: (context, i) => InkWell(
                        onTap: () {
                          MySharedPref().setJobDescModel(
                              modelArrayList[i], jobDetailsModelSave);
                          nextScreen(context, PostDetail(Expired.tag));
                        },
                        child: Column(
                          children: <Widget>[
                            dataAdd(modelArrayList[i]),
                          ],
                        ),
                      ))
            ],
          ),
        ),
      ),
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
          if (model.status && hr.isEmpty) {
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
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 35,
                        ),
                        Icon(
                          Icons.autorenew,
                          size: 20,
                          color: Colors.black87,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            repostClick(model.id);
                          },
                          child: Text(
                            'RePost',
                            style: TextStyle(
                                color: Color(0xff202125),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      postDeleteClick(model.id);
                    },
                    child:
                        Icon(Icons.delete, size: 20, color: Color(0xffff1414)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void repostClick(String id) {
    postsRef
        .child(id)
        .child(timeKey)
        .set(DateTime.now().millisecondsSinceEpoch.toString());
  }

  Future<bool> postDeleteClick(String id) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to delete?'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  postsRef
                      .child(id)
                      .child(statusKey)
                      .set(false)
                      .then((value) => Navigator.of(context).pop(false));
                },
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
