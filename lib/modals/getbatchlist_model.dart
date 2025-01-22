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
  InstitudeId? institudeId;
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
    institudeId = json['institudeId'] != null
        ? new InstitudeId.fromJson(json['institudeId'])
        : null;
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
     if (this.institudeId != null) {
      data['institudeId'] = this.institudeId!.toJson();
    }
    data['start_date'] = this.startDate;
    data['teacherId'] = this.teacherId;
    return data;
  }
}

class InstitudeId {
  Location? location;
  String? sId;
  String? institudeName;
  String? registerNo;
  String? address;
  String? branchShortName;
  String? doorNo;
  String? pincode;
  String? street;
  String? country;
  String? city;
  String? state;
  String? landmark;
  String? institudeFilename;
  String? institudeUrl;
  String? userId;
  String? qrCode;
  String? status;
  int? isActive;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  InstitudeId(
      {this.location,
      this.sId,
      this.institudeName,
      this.registerNo,
      this.address,
      this.branchShortName,
      this.doorNo,
      this.pincode,
      this.street,
      this.country,
      this.city,
      this.state,
      this.landmark,
      this.institudeFilename,
      this.institudeUrl,
      this.userId,
      this.qrCode,
      this.status,
      this.isActive,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  InstitudeId.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    institudeName = json['institude_name'];
    registerNo = json['register_no'];
    address = json['address'];
    branchShortName = json['branch_short_name'];
    doorNo = json['door_no'];
    pincode = json['pincode'];
    street = json['street'];
    country = json['country'];
    city = json['city'];
    state = json['state'];
    landmark = json['landmark'];
    institudeFilename = json['institude_filename'];
    institudeUrl = json['institude_url'];
    userId = json['userId'];
    qrCode = json['qr_code'];
    status = json['status'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['institude_name'] = this.institudeName;
    data['register_no'] = this.registerNo;
    data['address'] = this.address;
    data['branch_short_name'] = this.branchShortName;
    data['door_no'] = this.doorNo;
    data['pincode'] = this.pincode;
    data['street'] = this.street;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['landmark'] = this.landmark;
    data['institude_filename'] = this.institudeFilename;
    data['institude_url'] = this.institudeUrl;
    data['userId'] = this.userId;
    data['qr_code'] = this.qrCode;
    data['status'] = this.status;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

