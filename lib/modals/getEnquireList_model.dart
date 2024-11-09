class getEnquiryListModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  getEnquiryListModel({this.statusCode, this.message, this.data});

  getEnquiryListModel.fromJson(Map<String, dynamic> json) {
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
  String? enquiryId;
  String? courseName;
  String? courseId;
  String? subject;
  String? board;
  String? courseCode;
  String? className;
  String? batchId;
  String? batchTimingStart;
  String? batchTimingEnd;
  String? batchDays;
  String? batchMaximumSlots;
  String? fees;
  String? studentId;
  String? tutorId;
  String? studentName;
  String? tutorName;
  String? enquiryMessage;
  String? enquiryType;
  String? status;
  String? createdAt;

  Data(
      {this.enquiryId,
      this.courseName,
      this.courseId,
      this.subject,
      this.board,
      this.courseCode,
      this.className,
      this.batchId,
      this.batchTimingStart,
      this.batchTimingEnd,
      this.batchDays,
      this.batchMaximumSlots,
      this.fees,
      this.studentId,
      this.tutorId,
      this.studentName,
      this.tutorName,
      this.enquiryMessage,
      this.enquiryType,
      this.status,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    enquiryId = json['enquiryId'];
    courseName = json['courseName'];
    courseId = json['courseId'];
    subject = json['subject'];
    board = json['board'];
    courseCode = json['courseCode'];
    className = json['className'];
    batchId = json['batchId'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
    batchDays = json['batch_days'];
    batchMaximumSlots = json['batch_maximum_slots'];
    fees = json['fees'];
    studentId = json['studentId'];
    tutorId = json['tutorId'];
    studentName = json['studentName'];
    tutorName = json['tutorName'];
    enquiryMessage = json['enquiryMessage'];
    enquiryType = json['enquiryType'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enquiryId'] = this.enquiryId;
    data['courseName'] = this.courseName;
    data['courseId'] = this.courseId;
    data['subject'] = this.subject;
    data['board'] = this.board;
    data['courseCode'] = this.courseCode;
    data['className'] = this.className;
    data['batchId'] = this.batchId;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    data['batch_days'] = this.batchDays;
    data['batch_maximum_slots'] = this.batchMaximumSlots;
    data['fees'] = this.fees;
    data['studentId'] = this.studentId;
    data['tutorId'] = this.tutorId;
    data['studentName'] = this.studentName;
    data['tutorName'] = this.tutorName;
    data['enquiryMessage'] = this.enquiryMessage;
    data['enquiryType'] = this.enquiryType;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    return data;
  }
}