import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

toolbar(BuildContext context, String title, [Widget widget]) {
  return PreferredSize(
      preferredSize: Size(double.infinity, 100),
      child: Material(
        elevation: 1,
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (widget == null) {
                      Navigator.pop(context);
                    } else {
                      nextScreenWithClear(context, widget);
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(right: 8),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
      ));
}

ProgressDialog progressDialogMy(BuildContext context) {
  ProgressDialog pr = ProgressDialog(context);
  pr = ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
  pr.style(message: "Please Wait...");
  return pr;
}

nextScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

nextScreenWithClear(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => widget), (r) => false);
}

snackBarShow(String message) {
  SnackBar(
      content: new Text(message), duration: const Duration(milliseconds: 800));
}

myPrint(String message) {
  print("akash " + message);
}

String hrDiff(String time){
  var date = new DateTime.fromMicrosecondsSinceEpoch(int.parse(time) * 1000);
  var hr = DateTime.now().difference(date).inHours;
  int minHr = 24 - hr;
  var finalHr = minHr.toString().replaceAll("-", "");
  if (int.parse(finalHr) <= 24) {
    return finalHr;
  } else {
    return "";
  }
}
