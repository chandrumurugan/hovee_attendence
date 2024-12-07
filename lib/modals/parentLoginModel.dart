class parentLoginModal {
  bool? success;
  int? statusCode;
  String? message;
  String? invitationLink;
  String? mobileDeepLink;
  String? code;

  parentLoginModal(
      {this.success,
      this.statusCode,
      this.message,
      this.invitationLink,
      this.mobileDeepLink,
      this.code});

  parentLoginModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    invitationLink = json['invitationLink'];
    mobileDeepLink = json['mobileDeepLink'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['invitationLink'] = this.invitationLink;
    data['mobileDeepLink'] = this.mobileDeepLink;
    data['code'] = this.code;
    return data;
  }
}