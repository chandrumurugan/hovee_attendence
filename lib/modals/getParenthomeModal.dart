class GetHomeDashboardParentModel {
    GetHomeDashboardParentModel({
        required this.statusCode,
        required this.studentDetails,
        required this.navbarItems,
        required this.roleName,
        required this.courseList,
        required this.teacherList,
        required this.roleTypeName,
        required this.partentId,
    });

    final int? statusCode;
    final List<StudentDetails> studentDetails;
    final List<NavbarItem> navbarItems;
    final String? roleName;
    final List<CourseList> courseList;
    final List<TeacherList> teacherList;
    final String? roleTypeName;
    final PartentId? partentId;

    factory GetHomeDashboardParentModel.fromJson(Map<String, dynamic> json){ 
        return GetHomeDashboardParentModel(
            statusCode: json["statusCode"],
            studentDetails: json["studentDetails"] == null ? [] : List<StudentDetails>.from(json["studentDetails"]!.map((x) => x)),
            navbarItems: json["navbarItems"] == null ? [] : List<NavbarItem>.from(json["navbarItems"]!.map((x) => NavbarItem.fromJson(x))),
            roleName: json["roleName"],
            courseList: json["courseList"] == null ? [] : List<CourseList>.from(json["courseList"]!.map((x) => CourseList.fromJson(x))),
            teacherList: json["teacherList"] == null ? [] : List<TeacherList>.from(json["teacherList"]!.map((x) => TeacherList.fromJson(x))),
            roleTypeName: json["roleTypeName"],
            partentId: json["partentId"] == null ? null : PartentId.fromJson(json["partentId"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "studentDetails": studentDetails.map((x) => x).toList(),
        "navbarItems": navbarItems.map((x) => x?.toJson()).toList(),
        "roleName": roleName,
        "courseList": courseList.map((x) => x?.toJson()).toList(),
        "teacherList": teacherList.map((x) => x?.toJson()).toList(),
        "roleTypeName": roleTypeName,
        "partentId": partentId?.toJson(),
    };

}

class CourseList {
    CourseList({
        required this.id,
        required this.batchName,
        required this.board,
        required this.className,
        required this.subject,
        required this.courseCode,
    });

    final String? id;
    final String? batchName;
    final String? board;
    final String? className;
    final String? subject;
    final String? courseCode;

    factory CourseList.fromJson(Map<String, dynamic> json){ 
        return CourseList(
            id: json["_id"],
            batchName: json["batch_name"],
            board: json["board"],
            className: json["class_name"],
            subject: json["subject"],
            courseCode: json["course_code"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "batch_name": batchName,
        "board": board,
        "class_name": className,
        "subject": subject,
        "course_code": courseCode,
    };

}

class NavbarItem {
    NavbarItem({
        required this.id,
        required this.name,
        required this.icon,
        required this.route,
        required this.type,
        required this.roleId,
        required this.roleTypeId,
        required this.roleTypeName,
        required this.isActive,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.color,
        required this.desc,
        required this.image,
        required this.title,
    });

    final String? id;
    final String? name;
    final String? icon;
    final String? route;
    final String? type;
    final String? roleId;
    final String? roleTypeId;
    final String? roleTypeName;
    final int? isActive;
    final int? isDelete;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? color;
    final String? desc;
    final String? image;
    final String? title;

    factory NavbarItem.fromJson(Map<String, dynamic> json){ 
        return NavbarItem(
            id: json["_id"],
            name: json["name"],
            icon: json["icon"],
            route: json["route"],
            type: json["type"],
            roleId: json["roleId"],
            roleTypeId: json["roleTypeId"],
            roleTypeName: json["roleTypeName"],
            isActive: json["is_active"],
            isDelete: json["is_delete"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
            color: json["color"],
            desc: json["desc"],
            image: json["image"],
            title: json["title"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "icon": icon,
        "route": route,
        "type": type,
        "roleId": roleId,
        "roleTypeId": roleTypeId,
        "roleTypeName": roleTypeName,
        "is_active": isActive,
        "is_delete": isDelete,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "color": color,
        "desc": desc,
        "image": image,
        "title": title,
    };

}

class PartentId {
    PartentId({
        required this.location,
        required this.id,
        required this.userId,
        required this.firstName,
        required this.lastName,
        required this.wowId,
        required this.email,
        required this.dob,
        required this.address,
        required this.phoneNumber,
        required this.pincode,
        required this.doorNo,
        required this.street,
        required this.city,
        required this.state,
        required this.country,
        required this.latitude,
        required this.longitude,
        required this.parentRegister,
        required this.otp,
        required this.accountVerificationToken,
        required this.isActive,
        required this.isDeleted,
        required this.createdAt,
        required this.token,
    });

    final Location? location;
    final String? id;
    final List<String> userId;
    final String? firstName;
    final String? lastName;
    final String? wowId;
    final String? email;
    final String? dob;
    final String? address;
    final String? phoneNumber;
    final int? pincode;
    final String? doorNo;
    final String? street;
    final String? city;
    final String? state;
    final String? country;
    final dynamic latitude;
    final dynamic longitude;
    final bool? parentRegister;
    final String? otp;
    final String? accountVerificationToken;
    final int? isActive;
    final int? isDeleted;
    final DateTime? createdAt;
    final String? token;

    factory PartentId.fromJson(Map<String, dynamic> json){ 
        return PartentId(
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            id: json["_id"],
            userId: json["userId"] == null ? [] : List<String>.from(json["userId"]!.map((x) => x)),
            firstName: json["first_name"],
            lastName: json["last_name"],
            wowId: json["wow_id"],
            email: json["email"],
            dob: json["dob"],
            address: json["address"],
            phoneNumber: json["phone_number"],
            pincode: json["pincode"],
            doorNo: json["door_no"],
            street: json["street"],
            city: json["city"],
            state: json["state"],
            country: json["country"],
            latitude: json["latitude"],
            longitude: json["longitude"],
            parentRegister: json["parentRegister"],
            otp: json["otp"],
            accountVerificationToken: json["account_verification_token"],
            isActive: json["is_active"],
            isDeleted: json["is_deleted"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            token: json["token"],
        );
    }

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "userId": userId.map((x) => x).toList(),
        "first_name": firstName,
        "last_name": lastName,
        "wow_id": wowId,
        "email": email,
        "dob": dob,
        "address": address,
        "phone_number": phoneNumber,
        "pincode": pincode,
        "door_no": doorNo,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "parentRegister": parentRegister,
        "otp": otp,
        "account_verification_token": accountVerificationToken,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "token": token,
    };

}

class Location {
    Location({
        required this.type,
        required this.coordinates,
    });

    final String? type;
    final List<double> coordinates;

    factory Location.fromJson(Map<String, dynamic> json){ 
        return Location(
            type: json["type"],
            coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates.map((x) => x).toList(),
    };

}

class TeacherList {
    TeacherList({
        required this.id,
        required this.branchName,
        required this.teacherName,
        required this.teacherRollNumber,
        required this.qualification,
        required this.experience,
        required this.mobileNo,
    });

    final String? id;
    final String? branchName;
    final String? teacherName;
    final String? teacherRollNumber;
    final String? qualification;
    final String? experience;
    final String? mobileNo;

    factory TeacherList.fromJson(Map<String, dynamic> json){ 
        return TeacherList(
            id: json["_id"],
            branchName: json["branch_name"],
            teacherName: json["teacher_name"],
            teacherRollNumber: json["teacher_roll_number"],
            qualification: json["qualification"],
            experience: json["experience"],
            mobileNo: json["mobileNo"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "branch_name": branchName,
        "teacher_name": teacherName,
        "teacher_roll_number": teacherRollNumber,
        "qualification": qualification,
        "experience": experience,
        "mobileNo": mobileNo,
    };

}
class StudentDetails {
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
  Location? location;
  String? qrCodeUrl;
  int? isActive;
  int? isDeleted;
  String? createdAt;
  int? iV;
  String? token;
  String? address;
  String? rolesId;
  String? rolesTypeId;
  String? parentPhoneNumber;
  List<CourseList>? courseList;

  StudentDetails(
      {this.sId,
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
      this.location,
      this.qrCodeUrl,
      this.isActive,
      this.isDeleted,
      this.createdAt,
      this.iV,
      this.token,
      this.address,
      this.rolesId,
      this.rolesTypeId,
      this.parentPhoneNumber,
      this.courseList});

  StudentDetails.fromJson(Map<String, dynamic> json) {
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
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    qrCodeUrl = json['qr_code_url'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    iV = json['__v'];
    token = json['token'];
    address = json['address'];
    rolesId = json['rolesId'];
    rolesTypeId = json['rolesTypeId'];
    parentPhoneNumber = json['parent_phone_number'];
    if (json['courseList'] != null) {
      courseList = <CourseList>[];
      json['courseList'].forEach((v) {
        courseList!.add(new CourseList.fromJson(v));
      });
    }
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
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['qr_code_url'] = this.qrCodeUrl;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    data['token'] = this.token;
    data['address'] = this.address;
    data['rolesId'] = this.rolesId;
    data['rolesTypeId'] = this.rolesTypeId;
    data['parent_phone_number'] = this.parentPhoneNumber;
    if (this.courseList != null) {
      data['courseList'] = this.courseList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

