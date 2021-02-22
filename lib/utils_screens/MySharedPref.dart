import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:velo_user/model/CategoryModel.dart';
import 'package:velo_user/model/JobDetailsModel.dart';
import 'package:velo_user/model/UserModel.dart';

class MySharedPref {
  static MySharedPref _classInstance;
  static SharedPreferences _preferences;

  static Future<MySharedPref> getInstance() async {
    if (_classInstance == null) {
      _classInstance = MySharedPref();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _classInstance;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void setString(String key, String content) {
    _preferences.setString(key, content);
  }

  String getString(String key) {
    var value = _getFromDisk(key);
    if (value == null) {
      return "";
    }
    return value;
  }

  void clear(String key) {
    _preferences.remove(key);
  }

  /*---------------------------------------------------------saveModelsData-----------------------------------------------*/

  setUserModel(UserModel model, String key) {
    setString(key, json.encode(model.toJson()));
  }

  UserModel getUserModel(String key) {
    var myJson = _getFromDisk(key);
    if (myJson == null) {
      return null;
    }
    return UserModel.fromJson(json.decode(myJson));
  }

  setCategoryModel(CategoryModel model, String key) {
    setString(key, json.encode(model.toJson()));
  }

  CategoryModel getCategoryModel(String key) {
    var myJson = _getFromDisk(key);
    if (myJson == null) {
      return null;
    }
    return CategoryModel.fromJson(json.decode(myJson));
  }

  setJobDescModel(JobDetailsModel model, String key) {
    setString(key, json.encode(model.toJson()));
  }

  JobDetailsModel getJobDescModel(String key) {
    var myJson = _getFromDisk(key);
    if (myJson == null) {
      return null;
    }
    return JobDetailsModel.fromJson(json.decode(myJson));
  }
}
