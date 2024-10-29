class getAddendanceCourseList {
  int? statusCode;
  List<Data>? data;

  getAddendanceCourseList({this.statusCode, this.data});

  getAddendanceCourseList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Course? course;
  Batch? batch;
  String? startDate;
  String? endDate;

  Data({this.course, this.batch, this.startDate, this.endDate});

  Data.fromJson(Map<String, dynamic> json) {
    course =
        json['course'] != null ? new Course.fromJson(json['course']) : null;
    batch = json['batch'] != null ? new Batch.fromJson(json['batch']) : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    if (this.batch != null) {
      data['batch'] = this.batch!.toJson();
    }
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}

class Course {
  String? sId;
  String? className;
  String? batchName;
  String? subject;
  String? courseCode;
  String? remarks;

  Course(
      {this.sId,
      this.className,
      this.batchName,
      this.subject,
      this.courseCode,
      this.remarks});

  Course.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    className = json['class_name'];
    batchName = json['batch_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['class_name'] = this.className;
    data['batch_name'] = this.batchName;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    data['remarks'] = this.remarks;
    return data;
  }
}

class Batch {
  String? sId;
  String? batchName;
  String? batchTeacher;
  String? batchMaximumSlots;
  String? batchTimingStart;
  String? batchTimingEnd;
  String? batchDays;
  String? batchMode;
  String? batchCode;
  String? fees;

  Batch(
      {this.sId,
      this.batchName,
      this.batchTeacher,
      this.batchMaximumSlots,
      this.batchTimingStart,
      this.batchTimingEnd,
      this.batchDays,
      this.batchMode,
      this.batchCode,
      this.fees});

  Batch.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    batchTeacher = json['batch_teacher'];
    batchMaximumSlots = json['batch_maximum_slots'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
    batchDays = json['batch_days'];
    batchMode = json['batch_mode'];
    batchCode = json['batch_code'];
    fees = json['fees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch_name'] = this.batchName;
    data['batch_teacher'] = this.batchTeacher;
    data['batch_maximum_slots'] = this.batchMaximumSlots;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    data['batch_days'] = this.batchDays;
    data['batch_mode'] = this.batchMode;
    data['batch_code'] = this.batchCode;
    data['fees'] = this.fees;
    return data;
  }
}