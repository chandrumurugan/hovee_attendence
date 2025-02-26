class GetMspHostelModel {
  int? statusCode;
  String? message;
  List<MSPData>? data;
  Pagination? pagination;

  GetMspHostelModel(
      {this.statusCode, this.message, this.data, this.pagination});

  GetMspHostelModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MSPData>[];
      json['data'].forEach((v) {
        data!.add(new MSPData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class MSPData {
  String? sId;
  String? hostelId;
  HostelObjectId? hostelObjectId;
  HostelObjectId? hostellerObjectId;
  String? date;
  String? reason;
  String? status;
  HostelDetails? hostelDetails;

  MSPData(
      {this.sId,
      this.hostelId,
      this.hostelObjectId,
      this.hostellerObjectId,
      this.date,
      this.reason,
      this.status,
      this.hostelDetails});

  MSPData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    hostelId = json['hostelId'];
    hostelObjectId = json['hostel_ObjectId'] != null
        ? new HostelObjectId.fromJson(json['hostel_ObjectId'])
        : null;
    hostellerObjectId = json['hosteller_ObjectId'] != null
        ? new HostelObjectId.fromJson(json['hosteller_ObjectId'])
        : null;
    date = json['date'];
    reason = json['reason'];
    status = json['status'];
    hostelDetails = json['hostelDetails'] != null
        ? new HostelDetails.fromJson(json['hostelDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['hostelId'] = this.hostelId;
    if (this.hostelObjectId != null) {
      data['hostel_ObjectId'] = this.hostelObjectId!.toJson();
    }
    if (this.hostellerObjectId != null) {
      data['hosteller_ObjectId'] = this.hostellerObjectId!.toJson();
    }
    data['date'] = this.date;
    data['reason'] = this.reason;
    data['status'] = this.status;
    if (this.hostelDetails != null) {
      data['hostelDetails'] = this.hostelDetails!.toJson();
    }
    return data;
  }
}

class HostelObjectId {
  String? sId;
  String? firstName;
  String? lastName;

  HostelObjectId({this.sId, this.firstName, this.lastName});

  HostelObjectId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class HostelDetails {
  String? sId;
  String? hostelObjectId;
  String? roomType;
  String? hostelName;
  String? registerNo;
  String? shortName;
  String? hostelType;
  String? food;
  String? categories;
  String? remarks;
  double? latitude;
  double? longitude;
  Location? location;
  String? doorNo;
  String? street;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? profileFilename;
  String? profileUrl;
  String? hostelTimingStart;
  String? hostelTimingEnd;
  int? hostelTimingStartMinutes;
  int? hostelTimingEndMinutes;
  String? qrCodeUrl;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  HostelDetails(
      {this.sId,
      this.hostelObjectId,
      this.roomType,
      this.hostelName,
      this.registerNo,
      this.shortName,
      this.hostelType,
      this.food,
      this.categories,
      this.remarks,
      this.latitude,
      this.longitude,
      this.location,
      this.doorNo,
      this.street,
      this.city,
      this.state,
      this.country,
      this.pincode,
      this.profileFilename,
      this.profileUrl,
      this.hostelTimingStart,
      this.hostelTimingEnd,
      this.hostelTimingStartMinutes,
      this.hostelTimingEndMinutes,
      this.qrCodeUrl,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.iV});

  HostelDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    hostelObjectId = json['hostel_ObjectId'];
    roomType = json['room_type'];
    hostelName = json['hostel_name'];
    registerNo = json['register_no'];
    shortName = json['short_name'];
    hostelType = json['hostel_type'];
    food = json['food'];
    categories = json['categories'];
    remarks = json['remarks'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    doorNo = json['door_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    profileFilename = json['profile_filename'];
    profileUrl = json['profile_url'];
    hostelTimingStart = json['hostel_timing_start'];
    hostelTimingEnd = json['hostel_timing_end'];
    hostelTimingStartMinutes = json['hostel_timing_start_minutes'];
    hostelTimingEndMinutes = json['hostel_timing_end_minutes'];
    qrCodeUrl = json['qr_code_url'];
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['hostel_ObjectId'] = this.hostelObjectId;
    data['room_type'] = this.roomType;
    data['hostel_name'] = this.hostelName;
    data['register_no'] = this.registerNo;
    data['short_name'] = this.shortName;
    data['hostel_type'] = this.hostelType;
    data['food'] = this.food;
    data['categories'] = this.categories;
    data['remarks'] = this.remarks;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['door_no'] = this.doorNo;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['profile_filename'] = this.profileFilename;
    data['profile_url'] = this.profileUrl;
    data['hostel_timing_start'] = this.hostelTimingStart;
    data['hostel_timing_end'] = this.hostelTimingEnd;
    data['hostel_timing_start_minutes'] = this.hostelTimingStartMinutes;
    data['hostel_timing_end_minutes'] = this.hostelTimingEndMinutes;
    data['qr_code_url'] = this.qrCodeUrl;
    data['is_active'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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

class Pagination {
  int? totalItems;
  int? currentPage;
  int? totalPages;

  Pagination({this.totalItems, this.currentPage, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    return data;
  }
}