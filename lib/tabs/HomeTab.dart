import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_user/model/JobDetailsModel.dart';
import 'package:velo_user/model/UserModel.dart';
import 'package:velo_user/posts/PostDetails.dart';
import 'package:velo_user/utils_screens/Constants.dart';
import 'package:velo_user/utils_screens/FirebaseTables.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'package:velo_user/utils_screens/common_widget.dart';

class HomeTab extends StatefulWidget {
  static const String tag = "HomeFragment ";

  @override
  State<StatefulWidget> createState() {
    return new OrderItem();
  }
}

class OrderItem extends State<HomeTab> {
  UserModel userModel;
  List<JobDetailsModel> modelArrayList = [];
  List<JobDetailsModel> modelArrayListSearch = [];
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffafafa),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                decoration: new BoxDecoration(
                  color: Color(0xff9e8691),
                  border: Border.all(color: Color(0xfff9efe5)),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 26, left: 15, right: 15),
                      child: Container(
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
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 26,
                            ),
                            Expanded(
                                child: TextField(
                              controller: controller,
                              onChanged: onSearchTextChanged,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5, right: 15),
                                  hintText: "Search Jobs"),
                            )),
                            Icon(
                              Icons.border_clear,
                              color: Colors.grey,
                              size: 26,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Hi ${userModel.name},",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Find posts as per your skills and \nget contact details of clients \ndirectly.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              controller.text.isNotEmpty ? retriveData(modelArrayListSearch) : retriveData(modelArrayList)
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
    postsRef.onValue.listen(_onEntryAdded);
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

  retriveData(List<JobDetailsModel> modelArrayList) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: modelArrayList.length,
        itemBuilder: (context, i) => InkWell(
              onTap: () {
                MySharedPref()
                    .setJobDescModel(modelArrayList[i], jobDetailsModelSave);
                nextScreen(context, PostDetail(HomeTab.tag));
              },
              child: Column(
                children: <Widget>[
                  dataAdd(modelArrayList[i]),
                ],
              ),
            ));
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
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    '-',
                    style: TextStyle(color: Color(0xff8591a4), fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                      child: Text(model.jobContackDetails.location,
                          style: TextStyle(
                              color: Color(0xff8591a4), fontSize: 12))),
                  Text(
                    model.time + ' Hours Left',
                    style: TextStyle(
                        color: Color(0xff202125),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    modelArrayListSearch.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    modelArrayList.forEach((model) {
      if (model.title.toLowerCase().contains(text.toLowerCase()))
        modelArrayListSearch.add(model);
    });

    setState(() {});
  }
}
