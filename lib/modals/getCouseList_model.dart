// models/get_course_list_model.dart

class GetCourseListModel {
  int? statusCode;
  String? message;
  List<CouseData>? data;

  GetCourseListModel({this.statusCode, this.message, this.data});

  GetCourseListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CouseData>[];
      json['data'].forEach((v) {
        data!.add(CouseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouseData {
  String? userId;
  String? sId;
  String? createdAt;
  String? updatedAt;

  CouseData({this.userId, this.sId, this.createdAt, this.updatedAt});

  CouseData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    sId = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}