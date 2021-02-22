import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:velo_user/model/UserModel.dart';
import 'package:velo_user/utils_screens/FirebaseTables.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'package:velo_user/utils_screens/common_widget.dart';

import 'file:///E:/Akash/Velo/velo_user/lib/utils_screens/Constants.dart';

import 'HomePage.dart';

class UserDetailsAdd extends StatefulWidget {
  @override
  _UserDetailsAddState createState() => _UserDetailsAddState();
}

class _UserDetailsAddState extends State<UserDetailsAdd> {
  var formKey = new GlobalKey<FormState>();
  String strName;
  ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    initViews();
    return SafeArea(
        child: Scaffold(
      appBar: toolbar(context, "Add Details"),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(hintText: 'Enter Name'),
                onChanged: (val) {
                  setState(() {
                    this.strName = val;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Name';
                  }
                  return null;
                },
              ),
              RaisedButton(
                  child: Center(child: Text('Submit')),
                  onPressed: () {
                    _addData();
                  })
            ],
          )),
    ));
  }

  void _addData() {
    final isValid = formKey.currentState.validate();
    if (!isValid) {
      return;
    }

    progressDialog.show();
    formKey.currentState.save();

    String strNumber = MySharedPref().getString(numberKey);
    UserModel userModel = UserModel.para(
        DateTime.now().millisecondsSinceEpoch.toString(),
        strName,
        countryCode + strNumber);
    String uid = userRef.push().key;
    userRef.child(uid).set(userModel.toJson()).then((value) {
      userModel.uid = uid;
      MySharedPref().setUserModel(userModel, userModelSave);
      MySharedPref().clear(numberKey);
      nextScreen(context, HomePage());
    });
  }

  void initViews() {
    progressDialog = progressDialogMy(context);
  }
}
