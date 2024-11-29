// class OtpModal {
//     OtpModal({
//          this.success,
//          this.statusCode,
//          this.accountVerified,
//          this.accountSetup,
//          this.token,
//          this.login,
//          this.message,
//          this.data,
//     });

//     final bool? success;
//     final int? statusCode;
//     final bool? accountVerified;
//     final bool? accountSetup;
//     final String? token;
//     final bool? login;
//     final String? message;
//     final ValidateTokenData? data;

//     factory OtpModal.fromJson(Map<String, dynamic> json){ 
//         return OtpModal(
//             success: json["success"],
//             statusCode: json["statusCode"],
//             accountVerified: json["account_verified"],
//             accountSetup: json["account_setup"],
//             token: json["token"],
//             login: json["login"],
//             message: json["message"],
//             data: json["data"] == null ? null : ValidateTokenData.fromJson(json["data"]),
//         );
//     }

// }

// class ValidateTokenData {
//     ValidateTokenData({
//         required this.id,
//         required this.firstName,
//         required this.lastName,
//         required this.wowId,
//         required this.email,
//         required this.dob,
//         required this.phoneNumber,
//         required this.pincode,
//         required this.doorNo,
//         required this.street,
//         required this.city,
//         required this.state,
//         required this.country,
//         required this.idProof,
//         required this.idProofFilename,
//         required this.idProofUrl,
//         required this.profileFilename,
//         required this.profileUrl,
//          required this.roles,
//     });

//     final String? id;
//     final String? firstName;
//     final String? lastName;
//     final String? wowId;
//     final String? email;
//     final String? dob;
//     final String? phoneNumber;
//     final int? pincode;
//     final String? doorNo;
//     final String? street;
//     final String? city;
//     final String? state;
//     final String? country;
//     final String? idProof;
//     final String? idProofFilename;
//     final String? idProofUrl;
//     final String? profileFilename;
//     final String? profileUrl;
//      final Roles? roles;

//     factory ValidateTokenData.fromJson(Map<String, dynamic> json){ 
//         return ValidateTokenData(
//             id: json["_id"],
//             firstName: json["first_name"],
//             lastName: json["last_name"],
//             wowId: json["wow_id"],
//             email: json["email"],
//             dob: json["dob"],
//             phoneNumber: json["phone_number"],
//             pincode: json["pincode"],
//             doorNo: json["door_no"],
//             street: json["street"],
//             city: json["city"],
//             state: json["state"],
//             country: json["country"],
//             idProof: json["id_proof"],
//             idProofFilename: json["id_proof_filename"],
//             idProofUrl: json["id_proof_url"],
//             profileFilename: json["profile_filename"],
//             profileUrl: json["profile_url"],
//                         roles: json["roles"] == null ? null : Roles.fromJson(json["roles"]),

//         );
//     }

// }

// class Roles {
//     Roles({
//         required this.roleName,
//         required this.roleTypeName,
//     });

//     final String roleName;
//     final String roleTypeName;

//     factory Roles.fromJson(Map<String, dynamic> json){ 
//         return Roles(
//             roleName: json["roleName"] ?? "",
//             roleTypeName: json["roleTypeName"] ?? "",
//         );
//     }

// }


class OtpModal {
  bool? success;
  int? statusCode;
  bool? accountVerified;
  bool? accountSetup;
  String? token;
  bool? login;
  bool? parentData;
  String? message;
  Data? data;

  OtpModal(
      {this.success,
      this.statusCode,
      this.accountVerified,
      this.accountSetup,
      this.token,
      this.login,
      this.parentData,
      this.message,
      this.data});

  OtpModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    accountVerified = json['account_verified'];
    accountSetup = json['account_setup'];
    token = json['token'];
    login = json['login'];
    parentData = json['parentData'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['account_verified'] = this.accountVerified;
    data['account_setup'] = this.accountSetup;
    data['token'] = this.token;
    data['login'] = this.login;
    data['parentData'] = this.parentData;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  String? idProof;
  String? idProofLabel;
  String? idProofFilename;
  String? idProofUrl;
  String? profileFilename;
  String? profileUrl;
  Roles? roles;

  Data(
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
      this.idProof,
      this.idProofLabel,
      this.idProofFilename,
      this.idProofUrl,
      this.profileFilename,
      this.profileUrl,
      this.roles});

  Data.fromJson(Map<String, dynamic> json) {
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
    idProof = json['id_proof'];
    idProofLabel = json['id_proof_label'];
    idProofFilename = json['id_proof_filename'];
    idProofUrl = json['id_proof_url'];
    profileFilename = json['profile_filename'];
    profileUrl = json['profile_url'];
    roles = json['roles'] != null ? new Roles.fromJson(json['roles']) : null;
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
    data['id_proof'] = this.idProof;
    data['id_proof_label'] = this.idProofLabel;
    data['id_proof_filename'] = this.idProofFilename;
    data['id_proof_url'] = this.idProofUrl;
    data['profile_filename'] = this.profileFilename;
    data['profile_url'] = this.profileUrl;
    if (this.roles != null) {
      data['roles'] = this.roles!.toJson();
    }
    return data;
  }
}

class Roles {
  String? roleName;
  String? roleTypeName;

  Roles({this.roleName, this.roleTypeName});

  Roles.fromJson(Map<String, dynamic> json) {
    roleName = json['roleName'];
    roleTypeName = json['roleTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleName'] = this.roleName;
    data['roleTypeName'] = this.roleTypeName;
    return data;
  }
}