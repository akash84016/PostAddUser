class CategoryModel {
  String id, name, time;
  bool status;

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    time = json['time'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
