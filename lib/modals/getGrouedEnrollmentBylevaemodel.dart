class getGroupedLeaveByBatch {
  int? statusCode;
  List<Data>? data;

  getGroupedLeaveByBatch({this.statusCode, this.data});

  getGroupedLeaveByBatch.fromJson(Map<String, dynamic> json) {
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
  String? rollNumber;
  String? startDate;
  String? endDate;
  String? tutorId;
  String? batchId;
  String? batchName;
  String? batchCode;
  String? batchTimingStart;
  String? batchTimingEnd;
  String? courseCode;
  String? courseId;

  Data(
      {this.rollNumber,
      this.startDate,
      this.endDate,
      this.tutorId,
      this.batchId,
      this.batchName,
      this.batchCode,
      this.batchTimingStart,
      this.batchTimingEnd,
      this.courseCode,
      this.courseId});

  Data.fromJson(Map<String, dynamic> json) {
    rollNumber = json['rollNumber'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    tutorId = json['tutorId'];
    batchId = json['batchId'];
    batchName = json['batch_name'];
    batchCode = json['batch_code'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
    courseCode = json['course_code'];
    courseId = json['courseId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rollNumber'] = this.rollNumber;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['tutorId'] = this.tutorId;
    data['batchId'] = this.batchId;
    data['batch_name'] = this.batchName;
    data['batch_code'] = this.batchCode;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    data['course_code'] = this.courseCode;
    data['courseId'] = this.courseId;
    return data;
  }
}