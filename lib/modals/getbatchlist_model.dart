class getBatchListModel {
  int? statusCode;
  String? message;
  List<Data2>? data;

  getBatchListModel({this.statusCode, this.message, this.data});

  getBatchListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data2>[];
      json['data'].forEach((v) {
        data!.add(new Data2.fromJson(v));
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

class Data2 {
  String? sId;
  String? batchName;
  String? batchTeacher;
  String? batchTimingStart;
  String? batchTimingEnd;
  String? batchDays;
  String? batchMode;
  String? fees;
  String? month;
  String? createdAt;

  Data2(
      {this.sId,
      this.batchName,
      this.batchTeacher,
      this.batchTimingStart,
      this.batchTimingEnd,
      this.batchDays,
      this.batchMode,
      this.fees,
      this.month,
      this.createdAt});

  Data2.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    batchTeacher = json['batch_teacher'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
    batchDays = json['batch_days'];
    batchMode = json['batch_mode'];
    fees = json['fees'];
    month = json['month'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch_name'] = this.batchName;
    data['batch_teacher'] = this.batchTeacher;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    data['batch_days'] = this.batchDays;
    data['batch_mode'] = this.batchMode;
    data['fees'] = this.fees;
    data['month'] = this.month;
    data['created_at'] = this.createdAt;
    return data;
  }
}