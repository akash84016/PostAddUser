import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:velo_user/screens/HomePage.dart';
import 'package:velo_user/screens/Login.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'file:///E:/Akash/Velo/velo_user/lib/utils_screens/Constants.dart';

import 'model/UserModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  UserModel userDetails;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appname,
      theme: ThemeData(
        primaryColor: Colors.yellow,
        accentColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: userDetails != null ? HomePage() : Login(),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetails = MySharedPref().getUserModel(userModelSave);
  }
}

GetIt locator = GetIt();

Future setupLocator() async {
  var instance = await MySharedPref.getInstance();
  locator.registerSingleton<MySharedPref>(instance);
}
