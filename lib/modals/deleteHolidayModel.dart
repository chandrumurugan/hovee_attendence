class deleteHolidayModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  deleteHolidayModel({this.success, this.statusCode, this.message, this.data});

  deleteHolidayModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? batchName;
  String? holidayName;
  String? holidayFromDate;
  String? holidayEndDate;
  String? holidayType;
  String? description;
  String? batchId;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.batchName,
      this.holidayName,
      this.holidayFromDate,
      this.holidayEndDate,
      this.holidayType,
      this.description,
      this.batchId,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    batchName = json['batch_name'];
    holidayName = json['holiday_name'];
     holidayFromDate = json['holiday_from_date'];
    holidayEndDate = json['holiday_end_date'];
    holidayType = json['holiday_type'];
    description = json['description'];
    batchId = json['batchId'];
    sId = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_name'] = this.batchName;
    data['holiday_name'] = this.holidayName;
     data['holiday_from_date'] = this.holidayFromDate;
    data['holiday_end_date'] = this.holidayEndDate;
    data['holiday_type'] = this.holidayType;
    data['description'] = this.description;
    data['batchId'] = this.batchId;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}