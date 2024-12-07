class updateLeaveModel {
  int? statusCode;
  String? message;
  Data? data;

  updateLeaveModel({this.statusCode, this.message, this.data});

  updateLeaveModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? courseName;
  String? courseId;
  String? batchId;
  String? leaveType;
  String? fromDate;
  String? endDate;
  String? reason;
  String? userId;
  String? tutorId;
  String? status;
  int? isActive;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.courseName,
      this.courseId,
      this.batchId,
      this.leaveType,
      this.fromDate,
      this.endDate,
      this.reason,
      this.userId,
      this.tutorId,
      this.status,
      this.isActive,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseName = json['course_name'];
    courseId = json['courseId'];
    batchId = json['batchId'];
    leaveType = json['leave_type'];
    fromDate = json['from_date'];
    endDate = json['end_date'];
    reason = json['reason'];
    userId = json['userId'];
    tutorId = json['tutorId'];
    status = json['status'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['course_name'] = this.courseName;
    data['courseId'] = this.courseId;
    data['batchId'] = this.batchId;
    data['leave_type'] = this.leaveType;
    data['from_date'] = this.fromDate;
    data['end_date'] = this.endDate;
    data['reason'] = this.reason;
    data['userId'] = this.userId;
    data['tutorId'] = this.tutorId;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}