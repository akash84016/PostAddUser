class UserModel {
  String uid,time, name, number;

  UserModel.para(this.time,this.name, this.number);

  UserModel.fromJson(dynamic json) {
    uid = json['uid'];
    time = json['time'];
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['time'] = this.time;
    data['name'] = this.name;
    data['number'] = this.number;
    return data;
  }
}
