import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:velo_user/model/UserModel.dart';
import 'package:velo_user/screens/HomePage.dart';
import 'package:velo_user/screens/UserDetailsAdd.dart';
import 'package:velo_user/utils_screens/FirebaseTables.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'package:velo_user/utils_screens/common_widget.dart';

import 'file:///E:/Akash/Velo/velo_user/lib/utils_screens/Constants.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  var formKey = new GlobalKey<FormState>();
  String phoneNo, verificationId, smsCode;
  bool codeSent = false;
  ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    initViews();
    return bodyContent();
  }

  Widget bodyContent() {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: toolbar(context, "Login"),
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                    color: Color(0xfff5f6fa),
                    border: Border.all(color: Color(0xfff5f6fa)),
                    borderRadius: BorderRadius.circular(8.3)),
                child: TextFormField(
                  maxLength: 10,
                  style: const TextStyle(
                      color: Color(0xff232b38),
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProDisplay",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0),
                  decoration: new InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    hintText: "Mobile Number",
                    border: InputBorder.none,
                    labelStyle: new TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                    // hintStyle: TextStyle(
                    //     fontSize: 18.0, color: Colors.black87,fontFamily: 'Poppins',fontWeight: FontWeight.w600
                    // ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      this.phoneNo = val;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Mobile Number';
                    }
                    return null;
                  },
                ),
              ),
              codeSent
                  ? Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(top:10,left: 15, right: 15,bottom: 5),
                      decoration: BoxDecoration(
                          color: Color(0xfff5f6fa),
                          border: Border.all(color: Color(0xfff5f6fa)),
                          borderRadius: BorderRadius.circular(8.3)),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: Color(0xff232b38),
                            fontWeight: FontWeight.w400,
                            fontFamily: "SFProDisplay",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0),
                        decoration: new InputDecoration(
                          isDense: true,
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                          hintText: "Enter Otp",
                          border: InputBorder.none,
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                          // hintStyle: TextStyle(
                          //     fontSize: 18.0, color: Colors.black87,fontFamily: 'Poppins',fontWeight: FontWeight.w600
                          // ),
                        ),
                        maxLength: 6,
                        onChanged: (val) {
                          setState(() {
                            this.smsCode = val;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Otp';
                          }
                          return null;
                        },
                      ),
                    )
                  : Container(),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      child: Center(
                          child: codeSent ? Text('Login') : Text('Verify')),
                      onPressed: () {
                        _verifyLogin();
                      })),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      child: Center(
                          child: Text('Guest Login')),
                      onPressed: () {
                        progressDialog.show();
                        phoneNo = "8401673792";
                       login();
                      }))
            ],
          )),
    ));
  }

  Future<void> verifyPhone(phoneNo) async {
    print('akashEnterVerify');
    final PhoneVerificationCompleted verified =
        (PhoneAuthCredential authResult) {
      signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      progressDialog.hide();
      print('akashVerificationFailed ${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      print('akashCodeSent');
      setState(() {
        this.codeSent = true;
      });
      progressDialog.hide();
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
      print('akashTimeOut');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  void _verifyLogin() {
    final isValid = formKey.currentState.validate();
    if (!isValid) {
      return;
    }

    progressDialog.show();
    formKey.currentState.save();
    codeSent ? signInWithOTP(smsCode, verificationId) : verifyPhone(phoneNo);
  }

  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        MySharedPref().setString(numberKey, phoneNo);
        login();
      }
    });
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
    print('akashVerificationCompleted');
  }

  void initViews() {
    progressDialog = progressDialogMy(context);
  }

  void login() {
    userRef
        .orderByChild(numberKey)
        .equalTo(countryCode + phoneNo)
        .once()
        .then((snapshot) {
      progressDialog.hide();
      dynamic value = snapshot.value;
      if (value != null) {
        value.forEach((key, values) {
          UserModel model = UserModel.fromJson(values);
          model.uid = key;
          MySharedPref().setUserModel(model, userModelSave);
          nextScreen(context, HomePage());
        });
      } else {
        nextScreen(context, UserDetailsAdd());
      }
    });
  }
}
