class getBatchListModel {
  int? statusCode;
  String? message;
  List<Data2>? data;
  int? totalBatches;
  int? activeBatches;
  int? inactiveBatches;

  getBatchListModel(
      {this.statusCode,
      this.message,
      this.data,
      this.totalBatches,
      this.activeBatches,
      this.inactiveBatches});

  getBatchListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data2>[];
      json['data'].forEach((v) {
        data!.add(new Data2.fromJson(v));
      });
    }
    totalBatches = json['totalBatches'];
    activeBatches = json['activeBatches'];
    inactiveBatches = json['inactiveBatches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalBatches'] = this.totalBatches;
    data['activeBatches'] = this.activeBatches;
    data['inactiveBatches'] = this.inactiveBatches;
    return data;
  }
}

class Data2 {
  String? sId;
  String? batchName;
  String? batchTeacher;
  String? batchMaximumSlots;
  String? batchTimingStart;
  String? batchTimingEnd;
  dynamic batchDays;  // Can be a String or a List, handled dynamically
  String? batchMode;
  String? fees;
  String? month;
  String? createdAt;
  int? totalCourses;
  String? batchShortName;
  String? branchName;
  String? endDate;
  String? institudeId;
  String? startDate;
  String? teacherId;
 
  Data2(
      {this.sId,
      this.batchName,
      this.batchTeacher,
      this.batchMaximumSlots,
      this.batchTimingStart,
      this.batchTimingEnd,
      this.batchDays,
      this.batchMode,
      this.fees,
      this.month,
      this.createdAt,
      this.totalCourses,
      this.batchShortName,
      this.branchName,
      this.endDate,
      this.institudeId,
      this.startDate,
      this.teacherId});

  Data2.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    batchTeacher = json['batch_teacher'];
    batchMaximumSlots = json['batch_maximum_slots'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];

    // Check if batch_days is a list or a string and handle accordingly
    if (json['batch_days'] is String) {
      batchDays = json['batch_days'];  // If it's a string, assign directly
    } else if (json['batch_days'] is List) {
      batchDays = List<String>.from(json['batch_days']);  // If it's a list, convert to List<String>
    }

    batchMode = json['batch_mode'];
    fees = json['fees'];
    month = json['month'];
    createdAt = json['created_at'];
    totalCourses = json['totalCourses'];
    batchShortName = json['batch_short_name'];
    branchName = json['branch_name'];
    endDate = json['end_date'];
    institudeId = json['institudeId'];
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

    // Handle batchDays serialization
    if (this.batchDays is String) {
      data['batch_days'] = this.batchDays;  // If it's a string, use directly
    } else if (this.batchDays is List) {
      data['batch_days'] = this.batchDays;  // If it's a list, just assign
    }

    data['batch_mode'] = this.batchMode;
    data['fees'] = this.fees;
    data['month'] = this.month;
    data['created_at'] = this.createdAt;
    data['totalCourses'] = this.totalCourses;
    data['batch_short_name'] = this.batchShortName;
    data['branch_name'] = this.branchName;
    data['end_date'] = this.endDate;
    data['institudeId'] = this.institudeId;
    data['start_date'] = this.startDate;
    data['teacherId'] = this.teacherId;
    return data;
  }
}
