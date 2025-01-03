class getTuitionCourseListModel {
  int? statusCode;
  String? message;
  List<TutionData>? data;

  getTuitionCourseListModel({this.statusCode, this.message, this.data});

  getTuitionCourseListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TutionData>[];
      json['data'].forEach((v) {
        data!.add(new TutionData.fromJson(v));
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

class TutionData {
  String? sId;
  String? board;
  String? className;
  String? subject;
  String? courseCode;
  String? courseId;
  String? batchId;
  String? batchName;
  String? batchMaximumSlots;
  String? batchTimingStart;
  String? batchTimingEnd;
  List<String>? batchDays; // Changed to List<String>
  String? batchMode;
  String? fees;
  String? startDate;
  String? endDate;
  String? status;

  TutionData({
    this.sId,
    this.board,
    this.className,
    this.subject,
    this.courseCode,
    this.courseId,
    this.batchId,
    this.batchName,
    this.batchMaximumSlots,
    this.batchTimingStart,
    this.batchTimingEnd,
    this.batchDays,
    this.batchMode,
    this.fees,
    this.startDate,
    this.endDate,
    this.status,
  });

  TutionData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    board = json['board'];
    className = json['class_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
    courseId = json['courseId'];
    batchId = json['batchId'];
    batchName = json['batch_name'];
    batchMaximumSlots = json['batch_maximum_slots'];
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

    batchMode = json['batch_mode'];
    fees = json['fees'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['board'] = this.board;
    data['class_name'] = this.className;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    data['courseId'] = this.courseId;
    data['batchId'] = this.batchId;
    data['batch_name'] = this.batchName;
    data['batch_maximum_slots'] = this.batchMaximumSlots;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;

    // Convert List<String> to JSON
    if (this.batchDays != null) {
      data['batch_days'] = this.batchDays;
    }

    data['batch_mode'] = this.batchMode;
    data['fees'] = this.fees;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    return data;
  }
}
