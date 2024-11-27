class getUserTokenListModel {
  bool? success;
  int? statusCode;
  Data? data;
  String? message;

  getUserTokenListModel(
      {this.success, this.statusCode, this.data, this.message});

  getUserTokenListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  Location? location;
  String? sId;
  List<UserId>? userId;
  String? firstName;
  String? lastName;
  String? wowId;
  String? email;
  String? dob;
  String? address;
  String? phoneNumber;
  int? pincode;
  String? doorNo;
  String? street;
  String? city;
  String? state;
  String? country;
  Null? latitude;
  Null? longitude;
  int? isActive;
  int? isDeleted;
  String? createdAt;
  int? iV;
  String? token;

  Data(
      {this.location,
      this.sId,
      this.userId,
      this.firstName,
      this.lastName,
      this.wowId,
      this.email,
      this.dob,
      this.address,
      this.phoneNumber,
      this.pincode,
      this.doorNo,
      this.street,
      this.city,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.isActive,
      this.isDeleted,
      this.createdAt,
      this.iV,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    if (json['userId'] != null) {
      userId = <UserId>[];
      json['userId'].forEach((v) {
        userId!.add(new UserId.fromJson(v));
      });
    }
    firstName = json['first_name'];
    lastName = json['last_name'];
    wowId = json['wow_id'];
    email = json['email'];
    dob = json['dob'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    pincode = json['pincode'];
    doorNo = json['door_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    iV = json['__v'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['userId'] = this.userId!.map((v) => v.toJson()).toList();
    }
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['wow_id'] = this.wowId;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['pincode'] = this.pincode;
    data['door_no'] = this.doorNo;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    data['token'] = this.token;
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

class UserId {
  String? sId;
  String? firstName;
  String? lastName;
  String? wowId;
  String? email;
  String? dob;
  String? phoneNumber;
  int? pincode;
  String? doorNo;
  String? street;
  String? city;
  String? state;
  String? country;
  double? latitude;
  double? longitude;
  String? token;
  String? address;
  String? rolesId;

  UserId(
      {this.sId,
      this.firstName,
      this.lastName,
      this.wowId,
      this.email,
      this.dob,
      this.phoneNumber,
      this.pincode,
      this.doorNo,
      this.street,
      this.city,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.token,
      this.address,
      this.rolesId});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    wowId = json['wow_id'];
    email = json['email'];
    dob = json['dob'];
    phoneNumber = json['phone_number'];
    pincode = json['pincode'];
    doorNo = json['door_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    token = json['token'];
    address = json['address'];
    rolesId = json['rolesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['wow_id'] = this.wowId;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['phone_number'] = this.phoneNumber;
    data['pincode'] = this.pincode;
    data['door_no'] = this.doorNo;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['token'] = this.token;
    data['address'] = this.address;
    data['rolesId'] = this.rolesId;
    return data;
  }
}