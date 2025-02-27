
class UserProfileM {
    UserProfileM({
         this.statusCode,
         this.success,
         this.data,
    });

    final int? statusCode;
    final bool? success;
    final UserData? data;

    factory UserProfileM.fromJson(Map<String, dynamic> json){ 
        return UserProfileM(
            statusCode: json["statusCode"],
            success: json["success"],
            data: UserData.fromJson(json["data"]),
        );
    }

}

class UserData {
    UserData( {
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.wowId,
        required this.email,
        required this.dob,
        required this.phoneNumber,
        required this.pincode,
        required this.userType,
        required this.otp,
        required this.accountVerificationToken,
        required this.accountVerified,
        required this.accountSetup,
        required this.doorNo,
        required this.street,
        required this.city,
        required this.state,
        required this.country,
        required this.idProof,
        required this.idProofLabel,
        required this.idProofFilename,
        required this.idProofUrl,
        required this.profileFilename,
        required this.profileUrl,
        required this.isActive,
        required this.isDeleted,
        required this.createdAt,
        required this.v,
        required this.token,
        required this.rolesId,
        required this.rolesTypeId,
        required this.qualificationDetails,
       required this.institudeId,
       required this.ratings,
    });

    final String? id;
    final String? firstName;
    final String? lastName;
    final String? wowId;
    final String? email;
    final String? dob;
    final String? phoneNumber;
    final int? pincode;
    final int? userType;
    final dynamic otp;
    final dynamic accountVerificationToken;
    final bool? accountVerified;
    final bool? accountSetup;
    final String? doorNo;
    final String? street;
    final String? city;
    final String? state;
    final String? country;
    final String? idProof;
    final String? idProofLabel;
    final String? idProofFilename;
    final String? idProofUrl;
    final String? profileFilename;
     String? profileUrl;
    final int? isActive;
    final int? isDeleted;
    final DateTime? createdAt;
    final int? v;
    final String? token;
    final RolesId? rolesId;
    final String? rolesTypeId;
    final List<QualificationDetail> qualificationDetails;
    final String? institudeId;
    final Ratings? ratings;

    factory UserData.fromJson(Map<String, dynamic> json){ 
        return UserData(
            id: json["_id"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            wowId: json["wow_id"],
            email: json["email"],
            dob: json["dob"],
            phoneNumber: json["phone_number"],
            pincode: json["pincode"],
            userType: json["user_type"],
            otp: json["otp"],
            accountVerificationToken: json["account_verification_token"],
            accountVerified: json["account_verified"],
            accountSetup: json["account_setup"],
            doorNo: json["door_no"],
            street: json["street"],
            city: json["city"],
            state: json["state"],
            country: json["country"],
            idProof: json["id_proof"],
            idProofLabel: json["id_proof_label"],
            idProofFilename: json["id_proof_filename"],
            idProofUrl: json["id_proof_url"],
            profileFilename: json["profile_filename"],
            profileUrl: json["profile_url"],
            isActive: json["is_active"],
            isDeleted: json["is_deleted"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            v: json["__v"],
            token: json["token"],
            rolesId: json["rolesId"] == null ? null : RolesId.fromJson(json["rolesId"]),
            rolesTypeId: json["rolesTypeId"],
            qualificationDetails: json["qualificationDetails"] == null ? [] : List<QualificationDetail>.from(json["qualificationDetails"]!.map((x) => QualificationDetail.fromJson(x))), institudeId: json['institudeId'],
            ratings: json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
            
        );
    }

}

class QualificationDetail {
  QualificationDetail({
    required this.id,
    required this.highestQualification,
    this.selectBoard,
    this.selectClass,
    required this.organizationName,
    required this.userId,
    required this.teachingSkillSet,
    required this.workingTech,
    required this.additionalInfo,
    required this.attachResume,
    required this.attachEducationCertificate,
    required this.attachExperienceCertificate,
    required this.createdAt,
    required this.updatedAt,
    required this.teachingexperience,
    this.iV,
    this.tutionName,
    this.selectSubject
  });

  final String? id;
  final String? highestQualification;
  String? selectBoard;
  String? selectClass;
   String? selectSubject;
  final String? organizationName;
  final String? userId;
  final String? teachingSkillSet;
  final String? workingTech;
  final String? additionalInfo;
  final String? attachResume;
  final String? attachEducationCertificate;
  final String? attachExperienceCertificate;
  final String? teachingexperience;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  int? iV;
  final String? tutionName;
  factory QualificationDetail.fromJson(Map<String, dynamic> json) {
    return QualificationDetail(
      id: json["_id"],
      highestQualification: json["highest_qualification"],
      selectBoard: json['select_board'] ?? "", // Use ':' to assign values
      selectClass: json['select_class'] ?? "", // Use ':' to assign values
      organizationName: json['organization_name'] ?? "",
      userId: json["userId"] ?? "",
      teachingSkillSet: json["teaching_skill_set"] ?? "",
      workingTech: json["working_tech"] ?? "",
      additionalInfo: json["additional_info"] ?? "",
      attachResume: json["attach_resume"],
      attachEducationCertificate: json["attach_education_certificate"],
      attachExperienceCertificate: json["attach_experience_certificate"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      teachingexperience: json["teaching_experience"],
      iV: json['__v'], // Use ':' to assign values
      tutionName: json['tution_name'],
       selectSubject: json['select_subject'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = this.id;
    data['highest_qualification'] = this.highestQualification;
    data['select_board'] = this.selectBoard;
    data['select_class'] = this.selectClass;
    data['organization_name'] = this.organizationName;
    data['userId'] = this.userId;
    data['teaching_skill_set'] = this.teachingSkillSet;
    data['working_tech'] = this.workingTech;
    data['additional_info'] = this.additionalInfo;
    data['attach_resume'] = this.attachResume;
    data['attach_education_certificate'] = this.attachEducationCertificate;
    data['attach_experience_certificate'] = this.attachExperienceCertificate;
    data['teaching_experience'] = this.teachingexperience;
    data['created_at'] = this.createdAt?.toIso8601String(); // Convert DateTime to string
    data['updated_at'] = this.updatedAt?.toIso8601String(); // Convert DateTime to string
    data['__v'] = this.iV;
     data['tution_name'] = this.tutionName;
       data['select_subject'] = this.selectSubject;
    return data;
  }
}



class RolesId {
    RolesId({
        required this.id,
        required this.roleName,
        required this.isActive,
        required this.isDelete,
        required this.roleTypes,
        // required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? roleName;
    final int? isActive;
    final int? isDelete;
    final List<RoleType> roleTypes;
    // final DateTime? createdAt;
    final DateTime? updatedAt;

    factory RolesId.fromJson(Map<String, dynamic> json){ 
        return RolesId(
            id: json["_id"],
            roleName: json["roleName"],
            isActive: json["is_active"],
            isDelete: json["is_delete"],
            roleTypes: json["roleTypes"] == null ? [] : List<RoleType>.from(json["roleTypes"]!.map((x) => RoleType.fromJson(x))),
            // createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}

class RoleType {
    RoleType({
        required this.id,
        required this.roleTypeName,
        required this.isActive,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? id;
    final String? roleTypeName;
    final int? isActive;
    final int? isDelete;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory RoleType.fromJson(Map<String, dynamic> json){ 
        return RoleType(
            id: json["_id"],
            roleTypeName: json["roleTypeName"],
            isActive: json["is_active"],
            isDelete: json["is_delete"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

}


class Ratings {
  Ratings({
    required this.averageRating,
    required this.totalRatings,
  });

  final String? averageRating;
  final int? totalRatings;

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      averageRating: json["averageRating"]?.toString(), // Convert to String
      totalRatings: json["totalRatings"] as int?, // Ensure it's an int
    );
  }

  Map<String, dynamic> toJson() => {
        "averageRating": averageRating,
        "totalRatings": totalRatings,
      };
}
