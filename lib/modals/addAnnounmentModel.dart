class addAnnouncementModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  addAnnouncementModel({this.statusCode, this.message, this.data});

  addAnnouncementModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? title;
  String? description;
  String? studentId;
  String? tutorId;
  String? courseId;
  String? batchId;
  String? batchName;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.title,
      this.description,
      this.studentId,
      this.tutorId,
      this.courseId,
      this.batchId,
      this.batchName,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    studentId = json['studentId'];
    tutorId = json['tutorId'];
    courseId = json['courseId'];
    batchId = json['batchId'];
    batchName = json['batch_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['studentId'] = this.studentId;
    data['tutorId'] = this.tutorId;
    data['courseId'] = this.courseId;
    data['batchId'] = this.batchId;
    data['batch_name'] = this.batchName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}