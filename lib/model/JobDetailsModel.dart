import 'package:velo_user/model/JobContackModel.dart';

class JobDetailsModel {
  String id, uid, time, title, budget, info, catId, subCatId, views;
  bool status;
  JobContackModel jobContackDetails;

  JobDetailsModel(
      {this.id,
      this.uid,
      this.title,
      this.budget,
      this.info,
      this.catId,
      this.subCatId,
      this.status});

  JobDetailsModel.fromJson(dynamic json) {
    id = json['id'];
    uid = json['uid'];
    time = json['time'];
    title = json['title'];
    budget = json['budget'];
    info = json['info'];
    catId = json['catId'];
    subCatId = json['subCatId'];
    status = json['status'];
    views = json['views'] != null ? views = json['views'] : "0";
    jobContackDetails = json['jobContackDetails'] != null
        ? new JobContackModel.fromJson(json['jobContackDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['time'] = this.time;
    data['title'] = this.title;
    data['budget'] = this.budget;
    data['info'] = this.info;
    data['catId'] = this.catId;
    data['subCatId'] = this.subCatId;
    data['status'] = this.status;
    data['views'] = this.views;
    if (this.jobContackDetails != null) {
      data['jobContackDetails'] = this.jobContackDetails.toJson();
    }
    return data;
  }
}
