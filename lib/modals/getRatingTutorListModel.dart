class GetRatingTutorListModel {
   int? statusCode;
  String? message;
  List<RatingsData>? data;

  GetRatingTutorListModel({this.statusCode,this.message, this.data});

  GetRatingTutorListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RatingsData>[];
      json['data'].forEach((v) {
        data!.add(new RatingsData.fromJson(v));
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

class RatingsData {
  String? sId;
  UserId? userId;
  UserId? tutorId;
  BatchId? batchId;
  CourseId? courseId;
  String? comments;
  int? star;
  String? ratingPoints;
  List<String>? details;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RatingsData(
      {this.sId,
      this.userId,
      this.tutorId,
      this.batchId,
      this.courseId,
      this.comments,
      this.star,
      this.ratingPoints,
      this.details,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RatingsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
        json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    tutorId =
        json['tutorId'] != null ? new UserId.fromJson(json['tutorId']) : null;
    batchId =
        json['batchId'] != null ? new BatchId.fromJson(json['batchId']) : null;
    courseId = json['courseId'] != null
        ? new CourseId.fromJson(json['courseId'])
        : null;
    comments = json['comments'];
    star = json['star'];
    ratingPoints = json['ratingPoints'];
    details = json['details'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    if (this.tutorId != null) {
      data['tutorId'] = this.tutorId!.toJson();
    }
    if (this.batchId != null) {
      data['batchId'] = this.batchId!.toJson();
    }
    if (this.courseId != null) {
      data['courseId'] = this.courseId!.toJson();
    }
    data['comments'] = this.comments;
    data['star'] = this.star;
    data['ratingPoints'] = this.ratingPoints;
    data['details'] = this.details;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class UserId {
  String? sId;
  String? firstName;
  String? lastName;

  UserId({this.sId, this.firstName, this.lastName});

  UserId.fromJson(Map<String, dynamic> json) {
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

class BatchId {
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
  Null? institudeId;
  String? institudeName;
  String? startDate;
  Null? teacherId;

  BatchId(
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

  BatchId.fromJson(Map<String, dynamic> json) {
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

class CourseId {
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

  CourseId(
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

  CourseId.fromJson(Map<String, dynamic> json) {
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