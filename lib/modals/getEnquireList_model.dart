class getEnquiryListModel {
  int? statusCode;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  getEnquiryListModel(
      {this.statusCode, this.message, this.data, this.pagination});

  getEnquiryListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
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
  List<String>? batchDays;
  String? batchMaximumSlots;
  String? batchName;
  String? batchStartDate;
  String? batchEndDate;
  String? batchMode;
  String? fees;
  String? studentId;
  String? tutorId;
  String? studentName;
  String? tutorName;
  String? studentAddress;
  String? tutorAddress;
  String? enquiryMessage;
  String? enquiryType;
  String? status;
  String? createdAt;
  bool? alreadyEnrollment;
   String? tutionName;
    String? studentEmail;
  String? studentPhoneNo;
  String? institudeId;
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
      this.batchName,
      this.batchStartDate,
      this.batchEndDate,
      this.batchMode,
      this.fees,
      this.studentId,
      this.tutorId,
      this.studentName,
      this.tutorName,
      this.studentAddress,
      this.tutorAddress,
      this.enquiryMessage,
      this.enquiryType,
      this.status,
      this.createdAt,
      this.alreadyEnrollment,
      this.tutionName,
      this.studentEmail,
      this.studentPhoneNo,
      this.institudeId});

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
    // Handling String or List for batch_days
    if (json['batch_days'] != null) {
      if (json['batch_days'] is String) {
        batchDays = [json['batch_days']]; // Convert String to List
      } else if (json['batch_days'] is List) {
        batchDays = List<String>.from(json['batch_days']); // Convert List<dynamic> to List<String>
      }
    }
    batchMaximumSlots = json['batch_maximum_slots'];
    batchName = json['batchName'];
    batchStartDate = json['batch_start_date'];
    batchEndDate = json['batch_end_date'];
    batchMode = json['batch_mode'];
    fees = json['fees'];
    studentId = json['studentId'];
    tutorId = json['tutorId'];
    studentName = json['studentName'];
    tutorName = json['tutorName'];
    studentAddress = json['studentAddress'];
    tutorAddress = json['tutorAddress'];
    enquiryMessage = json['enquiryMessage'];
    enquiryType = json['enquiryType'];
    status = json['status'];
    createdAt = json['createdAt'];
    alreadyEnrollment = json['already_enrollment'];
     tutionName = json['tution_name'];
      studentEmail = json['studentEmail'];
    studentPhoneNo = json['studentPhone_no'];
    institudeId = json['institudeId'];
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
    data['batchName'] = this.batchName;
    data['batch_start_date'] = this.batchStartDate;
    data['batch_end_date'] = this.batchEndDate;
    data['batch_mode'] = this.batchMode;
    data['fees'] = this.fees;
    data['studentId'] = this.studentId;
    data['tutorId'] = this.tutorId;
    data['studentName'] = this.studentName;
    data['tutorName'] = this.tutorName;
    data['studentAddress'] = this.studentAddress;
    data['tutorAddress'] = this.tutorAddress;
    data['enquiryMessage'] = this.enquiryMessage;
    data['enquiryType'] = this.enquiryType;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['already_enrollment'] = this.alreadyEnrollment;
   data['tution_name'] = this.tutionName;
   data['studentEmail'] = this.studentEmail;
    data['studentPhone_no'] = this.studentPhoneNo;
     data['institudeId'] = this.institudeId;
    return data;
  }
}

class Pagination {
  int? totalItems;
  int? currentPage;
  int? totalPages;

  Pagination({this.totalItems, this.currentPage, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    return data;
  }
}