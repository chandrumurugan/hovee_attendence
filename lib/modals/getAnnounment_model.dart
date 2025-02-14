class getAnnouncementModel {
  int? statusCode;
  List<AnnounmentsData>? data;

  getAnnouncementModel({this.statusCode, this.data});

  getAnnouncementModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <AnnounmentsData>[];
      json['data'].forEach((v) {
        data!.add(new AnnounmentsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnnounmentsData {
  String? title;
  String? announcementId;
  String? description;
  BatchDetails? batchDetails;
  CourseDetails? courseDetails;
  List<UserDetails>? userDetails;

  AnnounmentsData(
      {this.title,
      this.announcementId,
      this.description,
      this.batchDetails,
      this.courseDetails,
      this.userDetails});

  AnnounmentsData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    announcementId = json['announcementId'];
    description = json['description'];
    batchDetails = json['batchDetails'] != null
        ? new BatchDetails.fromJson(json['batchDetails'])
        : null;
    courseDetails = json['courseDetails'] != null
        ? new CourseDetails.fromJson(json['courseDetails'])
        : null;
    if (json['userDetails'] != null) {
      userDetails = <UserDetails>[];
      json['userDetails'].forEach((v) {
        userDetails!.add(new UserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['announcementId'] = this.announcementId;
    data['description'] = this.description;
    if (this.batchDetails != null) {
      data['batchDetails'] = this.batchDetails!.toJson();
    }
    if (this.courseDetails != null) {
      data['courseDetails'] = this.courseDetails!.toJson();
    }
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BatchDetails {
  String? sId;
  String? batchName;
  String? batchTeacher;
  String? batchMaximumSlots;
  String? batchTimingStart;
  String? batchTimingEnd;
  int? batchTimingStartMinutes;
  int? batchTimingEndMinutes;
  String? batchDays;
  String? batchMode;
  String? fees;
  String? month;
  String? userId;
  String? batchCode;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? endDate;
  String? institudeId;
  String? institudeName;
  String? startDate;
  String? teacherId;

  BatchDetails(
      {this.sId,
      this.batchName,
      this.batchTeacher,
      this.batchMaximumSlots,
      this.batchTimingStart,
      this.batchTimingEnd,
      this.batchTimingStartMinutes,
      this.batchTimingEndMinutes,
      this.batchDays,
      this.batchMode,
      this.fees,
      this.month,
      this.userId,
      this.batchCode,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.endDate,
      this.institudeId,
      this.institudeName,
      this.startDate,
      this.teacherId});

  BatchDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    batchTeacher = json['batch_teacher'];
    batchMaximumSlots = json['batch_maximum_slots'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
    batchTimingStartMinutes = json['batch_timing_start_minutes'];
    batchTimingEndMinutes = json['batch_timing_end_minutes'];
            batchDays: json["batch_days"] == null
    ? []
    : (json["batch_days"] is String
        ? json["batch_days"].split(', ') // Handle string case
        : List<String>.from(json["batch_days"]));
    batchMode = json['batch_mode'];
    fees = json['fees'];
    month = json['month'];
    userId = json['userId'];
    batchCode = json['batch_code'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    endDate = json['end_date'];
    institudeId = json['institudeId'];
    institudeName = json['institude_name'];
    startDate = json['start_date'];
    teacherId = json['teacherId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch_name'] = this.batchName;
    data['batch_teacher'] = this.batchTeacher;
    data['batch_maximum_slots'] = this.batchMaximumSlots;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    data['batch_timing_start_minutes'] = this.batchTimingStartMinutes;
    data['batch_timing_end_minutes'] = this.batchTimingEndMinutes;
    data['batch_days'] = this.batchDays;
    data['batch_mode'] = this.batchMode;
    data['fees'] = this.fees;
    data['month'] = this.month;
    data['userId'] = this.userId;
    data['batch_code'] = this.batchCode;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['end_date'] = this.endDate;
    data['institudeId'] = this.institudeId;
    data['institude_name'] = this.institudeName;
    data['start_date'] = this.startDate;
    data['teacherId'] = this.teacherId;
    return data;
  }
}

class CourseDetails {
  String? sId;
  String? batchName;
  String? board;
  String? className;
  String? subject;
  String? courseCode;
  String? remarks;
  String? batchId;
  String? userId;
  Null? courseFilename;
  Null? courseUrl;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CourseDetails(
      {this.sId,
      this.batchName,
      this.board,
      this.className,
      this.subject,
      this.courseCode,
      this.remarks,
      this.batchId,
      this.userId,
      this.courseFilename,
      this.courseUrl,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CourseDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    board = json['board'];
    className = json['class_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
    remarks = json['remarks'];
    batchId = json['batchId'];
    userId = json['userId'];
    courseFilename = json['course_filename'];
    courseUrl = json['course_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch_name'] = this.batchName;
    data['board'] = this.board;
    data['class_name'] = this.className;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    data['remarks'] = this.remarks;
    data['batchId'] = this.batchId;
    data['userId'] = this.userId;
    data['course_filename'] = this.courseFilename;
    data['course_url'] = this.courseUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class UserDetails {
  String? studentFirstName;
  String? studentLastName;
  String? studentId;

  UserDetails({this.studentFirstName, this.studentLastName, this.studentId});

  UserDetails.fromJson(Map<String, dynamic> json) {
    studentFirstName = json['student_first_name'];
    studentLastName = json['student_last_name'];
    studentId = json['studentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_first_name'] = this.studentFirstName;
    data['student_last_name'] = this.studentLastName;
    data['studentId'] = this.studentId;
    return data;
  }
}