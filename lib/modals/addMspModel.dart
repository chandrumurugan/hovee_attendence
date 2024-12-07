class addMspModel {
  int? statusCode;
  bool? success;
  Data? data;

  addMspModel({this.statusCode, this.success, this.data});

  addMspModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? courseName;
  String? batchName;
  String? courseId;
  String? batchId;
  String? date;
  String? reason;
  String? userId;
  String? tutorId;
  String? status;
  int? isActive;
  int? isDeleted;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.courseName,
      this.batchName,
      this.courseId,
      this.batchId,
      this.date,
      this.reason,
      this.userId,
      this.tutorId,
      this.status,
      this.isActive,
      this.isDeleted,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    courseName = json['course_name'];
    batchName = json['batch_name'];
    courseId = json['courseId'];
    batchId = json['batchId'];
    date = json['date'];
    reason = json['reason'];
    userId = json['userId'];
    tutorId = json['tutorId'];
    status = json['status'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    sId = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_name'] = this.courseName;
    data['batch_name'] = this.batchName;
    data['courseId'] = this.courseId;
    data['batchId'] = this.batchId;
    data['date'] = this.date;
    data['reason'] = this.reason;
    data['userId'] = this.userId;
    data['tutorId'] = this.tutorId;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}