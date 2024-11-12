class getEnrollmentModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  getEnrollmentModel({this.statusCode, this.message, this.data});

  getEnrollmentModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? tutorId;
  String? studentId;
  String? courseId;
  String? batchId;
  String? rollNumber;
  String? startDate;
  String? endDate;
  String? status;
  String? entrollmentType;
  String? createdAt;
  int? iV;
  String? tutorName;

  Data(
      {this.sId,
      this.tutorId,
      this.studentId,
      this.courseId,
      this.batchId,
      this.rollNumber,
      this.startDate,
      this.endDate,
      this.status,
      this.entrollmentType,
      this.createdAt,
      this.iV,
      this.tutorName});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tutorId = json['tutorId'];
    studentId = json['studentId'];
    courseId = json['courseId'];
    batchId = json['batchId'];
    rollNumber = json['rollNumber'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    entrollmentType = json['entrollmentType'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    tutorName = json['tutorName'];
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
    data['status'] = this.status;
    data['entrollmentType'] = this.entrollmentType;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['tutorName'] = this.tutorName;
    return data;
  }
}