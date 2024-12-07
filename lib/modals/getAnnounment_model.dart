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
  String? description;
  UserDetails? userDetails;
  BatchList? batchList;
  CourseList? courseList;

  AnnounmentsData(
      {this.title,
      this.description,
      this.userDetails,
      this.batchList,
      this.courseList});

  AnnounmentsData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    batchList = json['batchList'] != null
        ? new BatchList.fromJson(json['batchList'])
        : null;
    courseList = json['courseList'] != null
        ? new CourseList.fromJson(json['courseList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    if (this.batchList != null) {
      data['batchList'] = this.batchList!.toJson();
    }
    if (this.courseList != null) {
      data['courseList'] = this.courseList!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? firstName;
  String? lastName;

  UserDetails({this.firstName, this.lastName});

  UserDetails.fromJson(Map<String, dynamic> json) {
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

class BatchList {
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

  BatchList(
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
      this.iV});

  BatchList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    batchTeacher = json['batch_teacher'];
    batchMaximumSlots = json['batch_maximum_slots'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
    batchTimingStartMinutes = json['batch_timing_start_minutes'];
    batchTimingEndMinutes = json['batch_timing_end_minutes'];
    batchDays = json['batch_days'];
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
    return data;
  }
}

class CourseList {
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

  CourseList(
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

  CourseList.fromJson(Map<String, dynamic> json) {
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