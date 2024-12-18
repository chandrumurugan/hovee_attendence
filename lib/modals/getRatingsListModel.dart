class GetRatingsListModel {
  int? statusCode;
  Data? data;

  GetRatingsListModel({this.statusCode, this.data});

  GetRatingsListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  int? stars;
  int? points;
  List<String>? details;
  String? status;

  Data({this.sId, this.stars, this.points, this.details, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    stars = json['stars'];
    points = json['points'];
    details = json['details'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['stars'] = this.stars;
    data['points'] = this.points;
    data['details'] = this.details;
    data['status'] = this.status;
    return data;
  }
}