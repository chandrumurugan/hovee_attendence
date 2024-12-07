class getParentInviteCodeModel {
  int? statusCode;
  Data? data;

  getParentInviteCodeModel({this.statusCode, this.data});

  getParentInviteCodeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? userId;
  String? parentCode;
  String? invitationLink;
  String? phoneNumber;
  String? expiresAt;
  bool? isUsed;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
      this.userId,
      this.parentCode,
      this.invitationLink,
      this.phoneNumber,
      this.expiresAt,
      this.isUsed,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    parentCode = json['parent_code'];
    invitationLink = json['invitation_link'];
    phoneNumber = json['phoneNumber'];
    expiresAt = json['expires_at'];
    isUsed = json['is_used'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['parent_code'] = this.parentCode;
    data['invitation_link'] = this.invitationLink;
    data['phoneNumber'] = this.phoneNumber;
    data['expires_at'] = this.expiresAt;
    data['is_used'] = this.isUsed;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}