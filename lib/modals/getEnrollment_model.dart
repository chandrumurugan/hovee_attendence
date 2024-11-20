// class getEnrollmentModel {
//   int? statusCode;
//   String? message;
//   List<Data>? data;

//   getEnrollmentModel({this.statusCode, this.message, this.data});

//   getEnrollmentModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   String? sId;
//   String? tutorId;
//   String? studentId;
//   String? courseId;
//   String? batchId;
//   String? rollNumber;
//   String? startDate;
//   String? endDate;
//   String? status;
//   String? entrollmentType;
//   String? createdAt;
//   int? iV;
//   String? tutorName;

//   Data(
//       {this.sId,
//       this.tutorId,
//       this.studentId,
//       this.courseId,
//       this.batchId,
//       this.rollNumber,
//       this.startDate,
//       this.endDate,
//       this.status,
//       this.entrollmentType,
//       this.createdAt,
//       this.iV,
//       this.tutorName});

//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     tutorId = json['tutorId'];
//     studentId = json['studentId'];
//     courseId = json['courseId'];
//     batchId = json['batchId'];
//     rollNumber = json['rollNumber'];
//     startDate = json['startDate'];
//     endDate = json['endDate'];
//     status = json['status'];
//     entrollmentType = json['entrollmentType'];
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//     tutorName = json['tutorName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['tutorId'] = this.tutorId;
//     data['studentId'] = this.studentId;
//     data['courseId'] = this.courseId;
//     data['batchId'] = this.batchId;
//     data['rollNumber'] = this.rollNumber;
//     data['startDate'] = this.startDate;
//     data['endDate'] = this.endDate;
//     data['status'] = this.status;
//     data['entrollmentType'] = this.entrollmentType;
//     data['createdAt'] = this.createdAt;
//     data['__v'] = this.iV;
//     data['tutorName'] = this.tutorName;
//     return data;
//   }
// }

class GetEnrollmentModel {
  int? statusCode;
  String? message;
  List<Data>? data;

  GetEnrollmentModel({this.statusCode, this.message, this.data});

  GetEnrollmentModel.fromJson(Map<String, dynamic> json) {
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
  TutorId? tutorId;
  TutorId? studentId;
  CourseId? courseId;
  BatchId? batchId;
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
    tutorId =
        json['tutorId'] != null ? new TutorId.fromJson(json['tutorId']) : null;
    studentId = json['studentId'] != null
        ? new TutorId.fromJson(json['studentId'])
        : null;
    courseId = json['courseId'] != null
        ? new CourseId.fromJson(json['courseId'])
        : null;
    batchId =
        json['batchId'] != null ? new BatchId.fromJson(json['batchId']) : null;
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
    if (this.tutorId != null) {
      data['tutorId'] = this.tutorId!.toJson();
    }
    if (this.studentId != null) {
      data['studentId'] = this.studentId!.toJson();
    }
    if (this.courseId != null) {
      data['courseId'] = this.courseId!.toJson();
    }
    if (this.batchId != null) {
      data['batchId'] = this.batchId!.toJson();
    }
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

class TutorId {
  String? sId;
  String? firstName;
  String? lastName;

  TutorId({this.sId, this.firstName, this.lastName});

  TutorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class CourseId {
  String? sId;
  String? board;
  String? className;
  String? subject;
  String? courseCode;

  CourseId(
      {this.sId, this.board, this.className, this.subject, this.courseCode});

  CourseId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    board = json['board'];
    className = json['class_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['board'] = this.board;
    data['class_name'] = this.className;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    return data;
  }
}

class BatchId {
  String? sId;
  String? batchName;
  String? batchTimingStart;
  String? batchTimingEnd;
  String? fees;

  BatchId(
      {this.sId,
      this.batchName,
      this.batchTimingStart,
      this.batchTimingEnd,
      this.fees});

  BatchId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
    fees = json['fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch_name'] = this.batchName;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    data['fees'] = this.fees;
    return data;
  }
}