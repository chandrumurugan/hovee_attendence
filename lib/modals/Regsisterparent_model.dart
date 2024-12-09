class RegisterParentModel {
  bool? success;
  int? statusCode;
  Data? data;
  String? message;

  RegisterParentModel({this.success, this.statusCode, this.data, this.message});

  RegisterParentModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
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
  bool? parentRegister;
  Location? location;
  String? otp;
  String? accountVerificationToken;
  int? isActive;
  int? isDeleted;
  String? sId;
  String? createdAt;
  String? token;

  Data(
      {this.userId,
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
      this.parentRegister,
      this.location,
      this.otp,
      this.accountVerificationToken,
      this.isActive,
      this.isDeleted,
      this.sId,
      this.createdAt,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
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
    parentRegister = json['parentRegister'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    otp = json['otp'];
    accountVerificationToken = json['account_verification_token'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    sId = json['_id'];
    createdAt = json['created_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
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
    data['parentRegister'] = this.parentRegister;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['otp'] = this.otp;
    data['account_verification_token'] = this.accountVerificationToken;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
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