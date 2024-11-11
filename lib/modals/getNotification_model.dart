class getNotificationsModel {
  int? statusCode;
  bool? success;
  List<Data1>? data;

  getNotificationsModel({this.statusCode, this.success, this.data});

  getNotificationsModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? role;
  String? type;
  String? head;
  String? message;
  String? redirectTo;
  bool? isRead;
  String? createdAt;
  int? iV;

  Data1(
      {this.sId,
      this.userId,
      this.role,
      this.type,
      this.head,
      this.message,
      this.redirectTo,
      this.isRead,
      this.createdAt,
      this.iV});

  Data1.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    role = json['role'];
    type = json['type'];
    head = json['head'];
    message = json['message'];
    redirectTo = json['redirectTo'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['role'] = this.role;
    data['type'] = this.type;
    data['head'] = this.head;
    data['message'] = this.message;
    data['redirectTo'] = this.redirectTo;
    data['isRead'] = this.isRead;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}