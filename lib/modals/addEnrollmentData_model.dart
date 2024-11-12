class addEnrollmentDataModel {
  int? statusCode;
  String? message;
  Data? data;

  addEnrollmentDataModel({this.statusCode, this.message, this.data});

  addEnrollmentDataModel.fromJson(Map<String, dynamic> json) {
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
  String? tutorId;
  String? studentId;
  String? courseId;
  String? batchId;
  String? rollNumber;
  String? startDate;
  String? endDate;
  String? tutorName;
  String? status;
  String? entrollmentType;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.tutorId,
      this.studentId,
      this.courseId,
      this.batchId,
      this.rollNumber,
      this.startDate,
      this.endDate,
      this.tutorName,
      this.status,
      this.entrollmentType,
      this.sId,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    tutorId = json['tutorId'];
    studentId = json['studentId'];
    courseId = json['courseId'];
    batchId = json['batchId'];
    rollNumber = json['rollNumber'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    tutorName = json['tutorName'];
    status = json['status'];
    entrollmentType = json['entrollmentType'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tutorId'] = this.tutorId;
    data['studentId'] = this.studentId;
    data['courseId'] = this.courseId;
    data['batchId'] = this.batchId;
    data['rollNumber'] = this.rollNumber;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['tutorName'] = this.tutorName;
    data['status'] = this.status;
    data['entrollmentType'] = this.entrollmentType;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
