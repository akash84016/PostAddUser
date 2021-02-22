class JobContackModel{
  String name,number,whatsAppNum,skypeNum,website,location,other;

  JobContackModel({this.name, this.number, this.whatsAppNum, this.skypeNum,
      this.website, this.location, this.other});

  JobContackModel.fromJson(dynamic json) {
    name = json['name'];
    number = json['number'];
    whatsAppNum = json['whatsAppNum'];
    skypeNum = json['skypeNum'];
    website = json['website'];
    location = json['location'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['number'] = this.number;
    data['whatsAppNum'] = this.whatsAppNum;
    data['skypeNum'] = this.skypeNum;
    data['website'] = this.website;
    data['location'] = this.location;
    data['other'] = this.other;
    return data;
  }
}