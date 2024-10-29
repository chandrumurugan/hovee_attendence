class getGroupedEnrollmentByBatch {
  int? statusCode;
  List<Data1>? data;

  getGroupedEnrollmentByBatch({this.statusCode, this.data});

  getGroupedEnrollmentByBatch.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data1>[];
      json['data'].forEach((v) {
        data!.add(new Data1.fromJson(v));
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

class Data1 {
  String? batchId;
  String? batchName;
  String? batchCode;
  String? startDate;
  String? endDate;
  String? batchTimingStart;
  String? batchTimingEnd;

  Data1(
      {this.batchId,
      this.batchName,
      this.batchCode,
      this.startDate,
      this.endDate,
      this.batchTimingStart,
      this.batchTimingEnd});

  Data1.fromJson(Map<String, dynamic> json) {
    batchId = json['batchId'];
    batchName = json['batch_name'];
    batchCode = json['batch_code'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batchId'] = this.batchId;
    data['batch_name'] = this.batchName;
    data['batch_code'] = this.batchCode;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    return data;
  }
}