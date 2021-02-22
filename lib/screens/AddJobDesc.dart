import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_user/model/JobDetailsModel.dart';
import 'package:velo_user/screens/JobContackInfo.dart';
import 'package:velo_user/utils_screens/Constants.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'package:velo_user/utils_screens/common_widget.dart';

class AddJobDescription extends StatefulWidget {
  @override
  _AddJobDescriptionState createState() => _AddJobDescriptionState();
}

class _AddJobDescriptionState extends State<AddJobDescription> {
  var formKey = GlobalKey<FormState>();
  String title, budget, info;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: toolbar(context, "Post description"),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                title = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Enter Post Title";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                              hintText: "Post Title",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "SFProDisplay",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.7),
                              labelStyle: new TextStyle(
                                color: const Color(0xff909599),
                              ),
                            ),
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
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                budget = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Enter Budget";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                              hintText: "Your budget",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "SFProDisplay",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.7),
                              labelStyle: new TextStyle(
                                color: const Color(0xff909599),
                              ),
                            ),
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
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                info = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Enter Post Info";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.multiline,
                            decoration: new InputDecoration(
                              hintText: "Enter Detailed information of Post",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "SFProDisplay",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.7),
                              labelStyle: new TextStyle(
                                color: const Color(0xff909599),
                              ),
                            ),
                            maxLines: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: new BoxDecoration(
                  color: Color(0xffc4c4c4),
                  borderRadius: BorderRadius.circular(0)),
              child: FlatButton(
                  padding: EdgeInsets.all(18),
                  onPressed: () {
                    doneClick();
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("NEXT",
                        style: const TextStyle(
                            color: const Color(0xff8b8e95),
                            fontWeight: FontWeight.w500,
                            fontFamily: "SFProDisplay",
                            fontStyle: FontStyle.normal,
                            fontSize: 18.3),
                        textAlign: TextAlign.right),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void doneClick() {
    final isValid = formKey.currentState.validate();
    if (!isValid) {
      return;
    }

    JobDetailsModel model =
        JobDetailsModel(title: title, budget: budget, info: info,status: true);
    MySharedPref().setJobDescModel(model, jobDetailsModelSave);
    nextScreen(context, JobContactInfo());
  }
}
