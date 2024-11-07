class getQrcodeModel {
  int? statusCode;
  bool? success;
  Data? data;

  getQrcodeModel({this.statusCode, this.success, this.data});

  getQrcodeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? qrCode;

  Data({this.qrCode});

  Data.fromJson(Map<String, dynamic> json) {
    qrCode = json['qrCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qrCode'] = this.qrCode;
    return data;
  }
}