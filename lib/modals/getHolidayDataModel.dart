class getHolidayDataModel {
  int? statusCode;
  bool? success;
  List<Data1>? data;

  getHolidayDataModel({this.statusCode, this.success, this.data});

  getHolidayDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
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
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data1 {
  String? sId;
  String? batchName;
  String? holidayName;
  String? holidayFromDate;
  String? holidayEndDate;
  String? holidayType;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data1(
      {this.sId,
      this.batchName,
      this.holidayName,
     this.holidayFromDate,
      this.holidayEndDate,
      this.holidayType,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data1.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    holidayName = json['holiday_name'];
     holidayFromDate = json['holiday_from_date'];
    holidayEndDate = json['holiday_end_date'];
    holidayType = json['holiday_type'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch_name'] = this.batchName;
    data['holiday_name'] = this.holidayName;
     data['holiday_from_date'] = this.holidayFromDate;
    data['holiday_end_date'] = this.holidayEndDate;
    data['holiday_type'] = this.holidayType;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}