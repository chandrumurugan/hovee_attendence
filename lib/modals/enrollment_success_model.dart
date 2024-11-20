class UpdateEnrollmentStatusModel {
  int? statusCode;
  String? message;
  Data? data;

  UpdateEnrollmentStatusModel({this.statusCode, this.message, this.data});

  UpdateEnrollmentStatusModel.fromJson(Map<String, dynamic> json) {
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
  String? tutorId;
  String? studentId;
  String? courseId;
  String? batchId;
  String? rollNumber;
  String? startDate;
  String? endDate;
  String? tutorName;
  String? enquiryCode;
  String? status;
  String? entrollmentType;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
      this.tutorId,
      this.studentId,
      this.courseId,
      this.batchId,
      this.rollNumber,
      this.startDate,
      this.endDate,
      this.tutorName,
      this.enquiryCode,
      this.status,
      this.entrollmentType,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tutorId = json['tutorId'];
    studentId = json['studentId'];
    courseId = json['courseId'];
    batchId = json['batchId'];
    rollNumber = json['rollNumber'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    tutorName = json['tutorName'];
    enquiryCode = json['enquiryCode'];
    status = json['status'];
    entrollmentType = json['entrollmentType'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['tutorId'] = this.tutorId;
    data['studentId'] = this.studentId;
    data['courseId'] = this.courseId;
    data['batchId'] = this.batchId;
    data['rollNumber'] = this.rollNumber;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['tutorName'] = this.tutorName;
    data['enquiryCode'] = this.enquiryCode;
    data['status'] = this.status;
    data['entrollmentType'] = this.entrollmentType;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}