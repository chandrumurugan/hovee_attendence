class getMspModel {
  int? statusCode;
  String? message;
  List<MSPData>? data;

  getMspModel({this.statusCode, this.message, this.data});

  getMspModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MSPData>[];
      json['data'].forEach((v) {
        data!.add(new MSPData.fromJson(v));
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

class MSPData {
  String? sId;
  String? courseName;
  String? courseId;
  String? batchId;
  String? date;
  String? reason;
  String? userId;
  String? tutorId;
  String? status;
  TutorDetails? tutorDetails;
  TutorDetails? studentDetails;
  BatchDetails? batchDetails;
  CourseDetails? courseDetails;
  EnrollmentDetails? enrollmentDetails;

  MSPData(
      {this.sId,
      this.courseName,
      this.courseId,
      this.batchId,
      this.date,
      this.reason,
      this.userId,
      this.tutorId,
      this.status,
      this.tutorDetails,
      this.studentDetails,
      this.batchDetails,
      this.courseDetails,
      this.enrollmentDetails});

  MSPData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseName = json['course_name'];
    courseId = json['courseId'];
    batchId = json['batchId'];
    date = json['date'];
    reason = json['reason'];
    userId = json['userId'];
    tutorId = json['tutorId'];
    status = json['status'];
    tutorDetails = json['tutorDetails'] != null
        ? new TutorDetails.fromJson(json['tutorDetails'])
        : null;
    studentDetails = json['studentDetails'] != null
        ? new TutorDetails.fromJson(json['studentDetails'])
        : null;
    batchDetails = json['batchDetails'] != null
        ? new BatchDetails.fromJson(json['batchDetails'])
        : null;
    courseDetails = json['courseDetails'] != null
        ? new CourseDetails.fromJson(json['courseDetails'])
        : null;
    enrollmentDetails = json['enrollmentDetails'] != null
        ? new EnrollmentDetails.fromJson(json['enrollmentDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['course_name'] = this.courseName;
    data['courseId'] = this.courseId;
    data['batchId'] = this.batchId;
    data['date'] = this.date;
    data['reason'] = this.reason;
    data['userId'] = this.userId;
    data['tutorId'] = this.tutorId;
    data['status'] = this.status;
    if (this.tutorDetails != null) {
      data['tutorDetails'] = this.tutorDetails!.toJson();
    }
    if (this.studentDetails != null) {
      data['studentDetails'] = this.studentDetails!.toJson();
    }
    if (this.batchDetails != null) {
      data['batchDetails'] = this.batchDetails!.toJson();
    }
    if (this.courseDetails != null) {
      data['courseDetails'] = this.courseDetails!.toJson();
    }
    if (this.enrollmentDetails != null) {
      data['enrollmentDetails'] = this.enrollmentDetails!.toJson();
    }
    return data;
  }
}

class TutorDetails {
  String? firstName;
  String? lastName;

  TutorDetails({this.firstName, this.lastName});

  TutorDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class BatchDetails {
  String? batchName;
  String? batchTeacher;
  String? batchMaximumSlots;
  String? batchTimingStart;
  String? batchTimingEnd;

  BatchDetails(
      {this.batchName,
      this.batchTeacher,
      this.batchMaximumSlots,
      this.batchTimingStart,
      this.batchTimingEnd});

  BatchDetails.fromJson(Map<String, dynamic> json) {
    batchName = json['batch_name'];
    batchTeacher = json['batch_teacher'];
    batchMaximumSlots = json['batch_maximum_slots'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_name'] = this.batchName;
    data['batch_teacher'] = this.batchTeacher;
    data['batch_maximum_slots'] = this.batchMaximumSlots;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    return data;
  }
}

class CourseDetails {
  String? batchName;
  String? board;
  String? className;
  String? subject;
  String? courseCode;

  CourseDetails(
      {this.batchName,
      this.board,
      this.className,
      this.subject,
      this.courseCode});

  CourseDetails.fromJson(Map<String, dynamic> json) {
    batchName = json['batch_name'];
    board = json['board'];
    className = json['class_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_name'] = this.batchName;
    data['board'] = this.board;
    data['class_name'] = this.className;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    return data;
  }
}

class EnrollmentDetails {
  String? sId;
  String? rollNumber;

  EnrollmentDetails({this.sId, this.rollNumber});

  EnrollmentDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rollNumber = json['rollNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rollNumber'] = this.rollNumber;
    return data;
  }
}