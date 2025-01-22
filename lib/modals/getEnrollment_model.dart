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
  InstitudeId? institudeId;
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
      this.iV,
      this.institudeId,});

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
     institudeId = json['institudeId'] != null
        ? new InstitudeId.fromJson(json['institudeId'])
        : null;
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
     if (this.institudeId != null) {
      data['institudeId'] = this.institudeId!.toJson();
    }
    return data;
  }
}

class TutorId {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  int? pincode;
  String? doorNo;
  String? street;
  String? city;
  String? state;
  String? country;

  TutorId(
      {this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.pincode,
      this.doorNo,
      this.street,
      this.city,
      this.state,
      this.country});

  TutorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    pincode = json['pincode'];
    doorNo = json['door_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['pincode'] = this.pincode;
    data['door_no'] = this.doorNo;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
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
  class InstitudeId {
  String? sId;
  String? institudeName;
  String? registerNo;
  String? address;
  String? branchShortName;
  String? doorNo;
  String? pincode;
  String? street;
  String? country;
  String? city;
  String? state;
  String? landmark;
  String? institudeFilename;
  String? institudeUrl;
  String? userId;
  String? qrCode;
  String? status;
  int? isActive;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  InstitudeId(
      {this.sId,
      this.institudeName,
      this.registerNo,
      this.address,
      this.branchShortName,
      this.doorNo,
      this.pincode,
      this.street,
      this.country,
      this.city,
      this.state,
      this.landmark,
      this.institudeFilename,
      this.institudeUrl,
      this.userId,
      this.qrCode,
      this.status,
      this.isActive,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  InstitudeId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    institudeName = json['institude_name'];
    registerNo = json['register_no'];
    address = json['address'];
    branchShortName = json['branch_short_name'];
    doorNo = json['door_no'];
    pincode = json['pincode'];
    street = json['street'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    landmark = json['landmark'];
    institudeFilename = json['institude_filename'];
    institudeUrl = json['institude_url'];
    userId = json['userId'];
    qrCode = json['qr_code'];
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
    data['institude_name'] = this.institudeName;
    data['register_no'] = this.registerNo;
    data['address'] = this.address;
    data['branch_short_name'] = this.branchShortName;
    data['door_no'] = this.doorNo;
    data['pincode'] = this.pincode;
    data['street'] = this.street;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['landmark'] = this.landmark;
    data['institude_filename'] = this.institudeFilename;
    data['institude_url'] = this.institudeUrl;
    data['userId'] = this.userId;
    data['qr_code'] = this.qrCode;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
