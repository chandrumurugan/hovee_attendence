class AddHolidayModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  AddHolidayModel({this.success, this.statusCode, this.message, this.data});

  AddHolidayModel.fromJson(Map<String, dynamic> json) {
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
  String? holidayDate;
  String? holidayType;
  String? description;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.batchName,
      this.holidayName,
      this.holidayDate,
      this.holidayType,
      this.description,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    batchName = json['batch_name'];
    holidayName = json['holiday_name'];
    holidayDate = json['holiday_date'];
    holidayType = json['holiday_type'];
    description = json['description'];
    sId = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_name'] = this.batchName;
    data['holiday_name'] = this.holidayName;
    data['holiday_date'] = this.holidayDate;
    data['holiday_type'] = this.holidayType;
    data['description'] = this.description;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}