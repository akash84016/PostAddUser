import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:velo_user/model/JobContackModel.dart';
import 'package:velo_user/model/JobDetailsModel.dart';
import 'package:velo_user/model/UserModel.dart';
import 'package:velo_user/posts/PostDetails.dart';
import 'package:velo_user/utils_screens/Constants.dart';
import 'package:velo_user/utils_screens/FirebaseTables.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'package:velo_user/utils_screens/common_widget.dart';

class JobContactInfo extends StatefulWidget {
  static const String tag = "SubCategory ";

  @override
  _JobContactInfoState createState() => _JobContactInfoState();
}

class _JobContactInfoState extends State<JobContactInfo> {
  var formKey = GlobalKey<FormState>();
  String name, number, whatsAppNum, skypeNum, website, location, other;
  UserModel userModel;

  ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    initViews();

    return SafeArea(
      child: Scaffold(
        appBar: toolbar(context, "Contact Information"),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SingleChildScrollView(
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                // Name
                                Container(
                                  width: 150,
                                  child: Text("Name",
                                      style: const TextStyle(
                                          color: const Color(0xff909599),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFProDisplay",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.7),
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        name = val;
                                      });
                                    },
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Enter Your Name";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      hintText: "Akash Lalpuriya",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Color(0xff202125),
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                // Name
                                Container(
                                  width: 150,
                                  child: Text("Mobile number",
                                      style: const TextStyle(
                                          color: const Color(0xff909599),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFProDisplay",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.7),
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        number = val;
                                      });
                                    },
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Enter Your Number";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(
                                      hintText: "**********",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Color(0xff202125),
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                // Name
                                Container(
                                  width: 150,
                                  child: Text("Whatsapp",
                                      style: const TextStyle(
                                          color: const Color(0xff909599),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFProDisplay",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.7),
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        whatsAppNum = val;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(
                                      hintText: "**********",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Color(0xff202125),
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                // Name
                                Container(
                                  width: 150,
                                  child: Text("Skype",
                                      style: const TextStyle(
                                          color: const Color(0xff909599),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFProDisplay",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.7),
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        skypeNum = val;
                                      });
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      hintText: "akash84016",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Color(0xff202125),
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                // Name
                                Container(
                                  width: 150,
                                  child: Text("Website",
                                      style: const TextStyle(
                                          color: const Color(0xff909599),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFProDisplay",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.7),
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        website = val;
                                      });
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      hintText: "https://google.in",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Color(0xff202125),
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                // Name
                                Container(
                                  width: 150,
                                  child: Text("Your location",
                                      style: const TextStyle(
                                          color: const Color(0xff909599),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFProDisplay",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.7),
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() {
                                        location = val;
                                      });
                                    },
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Enter Your Location";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      hintText: "Dahod/Gujarat/India",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Color(0xff202125),
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  other = val;
                                });
                              },
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                hintText: "Additional Details",
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
                        ],
                      )),
                ),
              ),
            ),
            Container(
                width: double.infinity,
                decoration: new BoxDecoration(
                    color: Color(0xfffa5805),
                    borderRadius: BorderRadius.circular(0)),
                child: FlatButton(
                    padding: EdgeInsets.all(18),
                    onPressed: () {
                      doneClick();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Post Submit",
                          style: const TextStyle(
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w500,
                              fontFamily: "SFProDisplay",
                              fontStyle: FontStyle.normal,
                              fontSize: 18.3),
                          textAlign: TextAlign.right),
                    )))
          ],
        ),
      ),
    );
  }

  void doneClick() {
    if (!formKey.currentState.validate()) {
      return;
    }

    progressDialog.show();
    JobDetailsModel jobDetailsModel =
        MySharedPref().getJobDescModel(jobDetailsModelSave);
    String cateogoryId = MySharedPref().getCategoryModel(categoryModelSave).id;
    String subCateogoryId =
        MySharedPref().getCategoryModel(subCategoryModelSave).id;

    JobContackModel jobContactInfo = JobContackModel(
        name: name,
        number: number,
        whatsAppNum: whatsAppNum,
        skypeNum: skypeNum,
        website: website,
        location: location,
        other: other);
    jobDetailsModel.time = DateTime.now().millisecondsSinceEpoch.toString();
    jobDetailsModel.catId = cateogoryId;
    jobDetailsModel.subCatId = subCateogoryId;
    jobDetailsModel.uid = userModel.uid;
    jobDetailsModel.jobContackDetails = jobContactInfo;

    String id = postsRef.push().key;
    postsRef.child(id).set(jobDetailsModel.toJson()).then((value) {
      jobDetailsModel.id = id;
      jobDetailsModel.time = hrDiff(jobDetailsModel.time);
      MySharedPref().setJobDescModel(jobDetailsModel, jobDetailsModelSave);
      progressDialog.hide();
      nextScreenWithClear(context, PostDetail(JobContactInfo.tag));
    });
  }

  void initViews() {
    progressDialog = progressDialogMy(context);
    userModel = MySharedPref().getUserModel(userModelSave);
  }
}
