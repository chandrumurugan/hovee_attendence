class ValidateTokenModel {
  ValidateTokenData? data;
  String? roleName;
  String? rolesTypes;
  int? statusCode;
  bool? success;
  bool? tokenValid;

  ValidateTokenModel(
      {this.data,
      this.roleName,
      this.rolesTypes,
      this.statusCode,
      this.success,
      this.tokenValid});

  ValidateTokenModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ValidateTokenData.fromJson(json['data']) : null;
    roleName = json['roleName'];
    rolesTypes = json['rolesTypes'];
    statusCode = json['statusCode'];
    success = json['success'];
    tokenValid = json['tokenValid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['roleName'] = this.roleName;
    data['rolesTypes'] = this.rolesTypes;
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['tokenValid'] = this.tokenValid;
    return data;
  }
}

class ValidateTokenData {
  Location? location;
  String? sId;
  String? firstName;
  String? lastName;
  String? wowId;
  String? email;
  String? dob;
  String? phoneNumber;
  int? pincode;
  int? userType;
  Null? otp;
  Null? accountVerificationToken;
  bool? accountVerified;
  bool? accountSetup;
  String? doorNo;
  String? street;
  String? city;
  String? state;
  String? country;
  String? idProof;
  String? idProofLabel;
  String? idProofFilename;
  String? idProofUrl;
  String? profileFilename;
  String? profileUrl;
  Null? latitude;
  Null? longitude;
  String? qrCodeUrl;
  int? isActive;
  int? isDeleted;
  String? createdAt;
  String? token;
  String? address;
  String? rolesId;
  String? rolesTypeId;

  ValidateTokenData(
      {this.location,
      this.sId,
      this.firstName,
      this.lastName,
      this.wowId,
      this.email,
      this.dob,
      this.phoneNumber,
      this.pincode,
      this.userType,
      this.otp,
      this.accountVerificationToken,
      this.accountVerified,
      this.accountSetup,
      this.doorNo,
      this.street,
      this.city,
      this.state,
      this.country,
      this.idProof,
      this.idProofLabel,
      this.idProofFilename,
      this.idProofUrl,
      this.profileFilename,
      this.profileUrl,
      this.latitude,
      this.longitude,
      this.qrCodeUrl,
      this.isActive,
      this.isDeleted,
      this.createdAt,
      this.token,
      this.address,
      this.rolesId,
      this.rolesTypeId});

  ValidateTokenData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    wowId = json['wow_id'];
    email = json['email'];
    dob = json['dob'];
    phoneNumber = json['phone_number'];
    pincode = json['pincode'];
    userType = json['user_type'];
    otp = json['otp'];
    accountVerificationToken = json['account_verification_token'];
    accountVerified = json['account_verified'];
    accountSetup = json['account_setup'];
    doorNo = json['door_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    idProof = json['id_proof'];
    idProofLabel = json['id_proof_label'];
    idProofFilename = json['id_proof_filename'];
    idProofUrl = json['id_proof_url'];
    profileFilename = json['profile_filename'];
    profileUrl = json['profile_url'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    qrCodeUrl = json['qr_code_url'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    token = json['token'];
    address = json['address'];
    rolesId = json['rolesId'];
    rolesTypeId = json['rolesTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['wow_id'] = this.wowId;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['phone_number'] = this.phoneNumber;
    data['pincode'] = this.pincode;
    data['user_type'] = this.userType;
    data['otp'] = this.otp;
    data['account_verification_token'] = this.accountVerificationToken;
    data['account_verified'] = this.accountVerified;
    data['account_setup'] = this.accountSetup;
    data['door_no'] = this.doorNo;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['id_proof'] = this.idProof;
    data['id_proof_label'] = this.idProofLabel;
    data['id_proof_filename'] = this.idProofFilename;
    data['id_proof_url'] = this.idProofUrl;
    data['profile_filename'] = this.profileFilename;
    data['profile_url'] = this.profileUrl;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['qr_code_url'] = this.qrCodeUrl;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['token'] = this.token;
    data['address'] = this.address;
    data['rolesId'] = this.rolesId;
    data['rolesTypeId'] = this.rolesTypeId;
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