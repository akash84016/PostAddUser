import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velo_user/model/CategoryModel.dart';
import 'package:velo_user/posts/OnGoing.dart';
import 'package:velo_user/screens/AddJobDesc.dart';
import 'package:velo_user/utils_screens/Constants.dart';
import 'package:velo_user/utils_screens/FirebaseTables.dart';
import 'package:velo_user/utils_screens/MySharedPref.dart';
import 'package:velo_user/utils_screens/common_widget.dart';

class CategoryLists extends StatefulWidget {
  static const String tag = "SubCategory ";

  String checker;

  CategoryLists(this.checker);

  @override
  _CategoryListsState createState() => _CategoryListsState(checker);
}

class _CategoryListsState extends State<CategoryLists> {
  CategoryModel categoryModel;
  List<CategoryModel> modelArrayList = [];
  List<CategoryModel> modelArrayListSearch = [];
  TextEditingController controller = new TextEditingController();

  String getChecker;

  _CategoryListsState(this.getChecker);

  @override
  Widget build(BuildContext context) {
    initViews();
    return SafeArea(
        child: Scaffold(
      appBar: toolbar(
          context,
          getChecker == Ongoing.tag
              ? "Choose Category"
              : "Choose Sub Category"),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: controller,
              onChanged: onSearchTextChanged,
              decoration: new InputDecoration(
                hintText: getChecker == Ongoing.tag
                    ? "Search in Category"
                    : "Search in Sub Category",
                labelStyle: new TextStyle(color: const Color(0xFF424242)),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: getChecker == Ongoing.tag
                  ? categoryRef.once()
                  : subCategoryRef
                      .orderByChild(mainCatIdKey)
                      .equalTo(categoryModel.id)
                      .once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  modelArrayList.clear();
                  dynamic values = snapshot.data.value;
                  if (values != null) {
                    values.forEach((key, values) {
                      CategoryModel model = CategoryModel.fromJson(values);
                      if (model.status) {
                        model.id = key;
                        modelArrayList.add(model);
                      }
                    });
                  }
                  return controller.text.isNotEmpty
                      ? dataRetrive(modelArrayListSearch)
                      : dataRetrive(modelArrayList);
                }
                return CircularProgressIndicator();
              })
        ],
      ),
    ));
  }

  dataRetrive(List<CategoryModel> modelArrayList) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        reverse: true,
        itemCount: modelArrayList.length,
        itemBuilder: (context, position) => InkWell(
              onTap: () {
                if (getChecker == Ongoing.tag) {
                  MySharedPref().setCategoryModel(
                      modelArrayList[position], categoryModelSave);
                  nextScreen(context, CategoryLists(CategoryLists.tag));
                } else if (getChecker == CategoryLists.tag) {
                  MySharedPref().setCategoryModel(
                      modelArrayList[position], subCategoryModelSave);
                  nextScreen(context, AddJobDescription());
                }
              },
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Android app development
                        Text(modelArrayList[position].name,
                            style: const TextStyle(
                                color: const Color(0xff202125),
                                fontWeight: FontWeight.w500,
                                fontFamily: "SFProDisplay",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.7),
                            textAlign: TextAlign.left),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Colors.black87,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }

  onSearchTextChanged(String text) async {
    modelArrayListSearch.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    modelArrayList.forEach((model) {
      if (model.name.toLowerCase().contains(text.toLowerCase()))
        modelArrayListSearch.add(model);
    });

    setState(() {});
  }

  void initViews() {
    categoryModel = MySharedPref().getCategoryModel(categoryModelSave);
  }
}
