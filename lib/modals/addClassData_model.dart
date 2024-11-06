class AddClassDataModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  AddClassDataModel({this.statusCode, this.success, this.message, this.data});

  AddClassDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? courseCode;
  String? tutorId;
  String? courseId;
  String? batchId;
  String? batchName;
  String? status;
  int? isActive;
  int? isDelete;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.courseCode,
      this.tutorId,
      this.courseId,
      this.batchId,
      this.batchName,
      this.status,
      this.isActive,
      this.isDelete,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    courseCode = json['course_code'];
    tutorId = json['tutorId'];
    courseId = json['courseId'];
    batchId = json['batchId'];
    batchName = json['batch_name'];
    status = json['status'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    sId = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_code'] = this.courseCode;
    data['tutorId'] = this.tutorId;
    data['courseId'] = this.courseId;
    data['batchId'] = this.batchId;
    data['batch_name'] = this.batchName;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}