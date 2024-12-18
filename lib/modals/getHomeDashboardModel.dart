class getHomeDashboardTutorModel {
  int? statusCode;
  List<StudentDetails>? studentDetails;
  List<NavbarItems>? navbarItems;
  String? roleName;
  String? roleTypeName;
   PartentId? partentId;

  getHomeDashboardTutorModel(
      {this.statusCode,
      this.studentDetails,
      this.navbarItems,
      this.roleName,
      this.roleTypeName,
      this.partentId});

  getHomeDashboardTutorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['studentDetails'] != null) {
      studentDetails = <StudentDetails>[];
      json['studentDetails'].forEach((v) {
        studentDetails!.add(new StudentDetails.fromJson(v));
      });
    }
    if (json['navbarItems'] != null) {
      navbarItems = <NavbarItems>[];
      json['navbarItems'].forEach((v) {
        navbarItems!.add(new NavbarItems.fromJson(v));
      });
    }
    roleName = json['roleName'];
    roleTypeName = json['roleTypeName'];
     partentId = json["partentId"] == null ? null : PartentId.fromJson(json["partentId"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.studentDetails != null) {
      data['studentDetails'] =
          this.studentDetails!.map((v) => v.toJson()).toList();
    }
    if (this.navbarItems != null) {
      data['navbarItems'] = this.navbarItems!.map((v) => v.toJson()).toList();
    }
    data['roleName'] = this.roleName;
    data['roleTypeName'] = this.roleTypeName;
     data['partentId'] = this.partentId;
    return data;
  }
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
  // Null? otp;
  // Null? accountVerificationToken;
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
  // Null? latitude;
  // Null? longitude;
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
      // this.otp,
      // this.accountVerificationToken,
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
      // this.latitude,
      // this.longitude,
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
    // otp = json['otp'];
    // accountVerificationToken = json['account_verification_token'];
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
    // latitude = json['latitude'];
    // longitude = json['longitude'];
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
    // data['otp'] = this.otp;
    // data['account_verification_token'] = this.accountVerificationToken;
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
    // data['latitude'] = this.latitude;
    // data['longitude'] = this.longitude;
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

class CourseList {
  Course? course;
  Batch? batch;

  CourseList({this.course, this.batch});

  CourseList.fromJson(Map<String, dynamic> json) {
    course =
        json['course'] != null ? new Course.fromJson(json['course']) : null;
    batch = json['batch'] != null ? new Batch.fromJson(json['batch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    if (this.batch != null) {
      data['batch'] = this.batch!.toJson();
    }
    return data;
  }
}

class Course {
  String? sId;
  String? className;
  String? subject;
  String? courseCode;
  String? remarks;

  Course(
      {this.sId, this.className, this.subject, this.courseCode, this.remarks});

  Course.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    className = json['class_name'];
    subject = json['subject'];
    courseCode = json['course_code'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['class_name'] = this.className;
    data['subject'] = this.subject;
    data['course_code'] = this.courseCode;
    data['remarks'] = this.remarks;
    return data;
  }
}

class Batch {
  String? sId;
  String? batchName;
  String? batchTeacher;
  String? fees;
  dynamic? batchDays;
  String? batchTimingStart;
  String? batchTimingEnd;

  Batch(
      {this.sId, this.batchName, this.batchTeacher, this.fees, this.batchDays,this.batchTimingStart,
      this.batchTimingEnd});

  Batch.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchName = json['batch_name'];
    batchTeacher = json['batch_teacher'];
    fees = json['fees'];
    batchDays =json['batch_days'];//json['batch_days']
     batchTimingStart = json['batch_timing_start'];
    batchTimingEnd = json['batch_timing_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['batch_name'] = this.batchName;
    data['batch_teacher'] = this.batchTeacher;
    data['fees'] = this.fees;
    data['batch_days'] = this.batchDays;
    data['batch_timing_start'] = this.batchTimingStart;
    data['batch_timing_end'] = this.batchTimingEnd;
    return data;
  }
}

class NavbarItems {
  String? sId;
  String? name;
  String? icon;
  String? route;
  String? type;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? roleTypeName;
  String? roleId;
  String? roleTypeId;
  String? color;
  String? desc;
  String? image;
  String? title;

  NavbarItems(
      {this.sId,
      this.name,
      this.icon,
      this.route,
      this.type,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.roleTypeName,
      this.roleId,
      this.roleTypeId,
      this.color,
      this.desc,
      this.image,
      this.title});

  NavbarItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    icon = json['icon'];
    route = json['route'];
    type = json['type'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    roleTypeName = json['roleTypeName'];
    roleId = json['roleId'];
    roleTypeId = json['roleTypeId'];
    color = json['color'];
    desc = json['desc'];
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['route'] = this.route;
    data['type'] = this.type;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['roleTypeName'] = this.roleTypeName;
    data['roleId'] = this.roleId;
    data['roleTypeId'] = this.roleTypeId;
    data['color'] = this.color;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}

class PartentId {
    PartentId({
        required this.location,
        required this.parentRegister,
        required this.otp,
        required this.accountVerificationToken,
        required this.id,
        // required this.userId,
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
        required this.isActive,
        required this.isDeleted,
        required this.createdAt,
        required this.token,
    });

    final Location? location;
    final bool? parentRegister;
    final String? otp;
    final String? accountVerificationToken;
    final String? id;
    // final List<dynamic> userId;
    final String? firstName;
    final String? lastName;
    final String? wowId;
    final String? email;
    final DateTime? dob;
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
    final int? isActive;
    final int? isDeleted;
    final DateTime? createdAt;
    final String? token;

    factory PartentId.fromJson(Map<String, dynamic> json){ 
        return PartentId(
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            parentRegister: json["parentRegister"],
            otp: json["otp"],
            accountVerificationToken: json["account_verification_token"],
            id: json["_id"],
            // userId: json["userId"] == null ? [] : List<dynamic>.from(json["userId"]!.map((x) => x)),
            firstName: json["first_name"],
            lastName: json["last_name"],
            wowId: json["wow_id"],
            email: json["email"],
            dob: DateTime.tryParse(json["dob"] ?? ""),
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
            isActive: json["is_active"],
            isDeleted: json["is_deleted"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            token: json["token"],
        );
    }

}
