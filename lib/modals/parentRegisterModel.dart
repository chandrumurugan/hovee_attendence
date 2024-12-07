class parentregisterUserModel {
  bool? success;
  int? statusCode;
  Data? data;
  String? message;

  parentregisterUserModel(
      {this.success, this.statusCode, this.data, this.message});

  parentregisterUserModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? otp;
  String? accountVerificationToken;
  bool? accountVerified;
  String? qrCodeUrl;
  String? createdAt;

  Data(
      {this.sId,
      this.otp,
      this.accountVerificationToken,
      this.accountVerified,
      this.qrCodeUrl,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    otp = json['otp'];
    accountVerificationToken = json['account_verification_token'];
    accountVerified = json['account_verified'];
    qrCodeUrl = json['qr_code_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['otp'] = this.otp;
    data['account_verification_token'] = this.accountVerificationToken;
    data['account_verified'] = this.accountVerified;
    data['qr_code_url'] = this.qrCodeUrl;
    data['created_at'] = this.createdAt;
    return data;
  }
}