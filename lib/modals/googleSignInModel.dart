class GoogleSignInModel {
    GoogleSignInModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final GoogleSignInData? data;

    factory GoogleSignInModel.fromJson(Map<String, dynamic> json){ 
        return GoogleSignInModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : GoogleSignInData.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };

}

class GoogleSignInData {
    GoogleSignInData({
        required this.token,
        required this.otp,
        required this.accountSetup,
        required this.accountVerified,
        required this.user,
    });

    final String? token;
    final dynamic otp;
    final bool? accountSetup;
    final bool? accountVerified;
    final User? user;

    factory GoogleSignInData.fromJson(Map<String, dynamic> json){ 
        return GoogleSignInData(
            token: json["token"],
            otp: json["otp"],
            accountSetup: json["account_setup"],
            accountVerified: json["account_verified"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "token": token,
        "otp": otp,
        "account_setup": accountSetup,
        "account_verified": accountVerified,
        "user": user?.toJson(),
    };

}

class User {
    User({
        required this.id,
        required this.accountSetup,
        required this.accountVerified,
        required this.email,
        required this.name,
        required this.phoneNumber,
        required this.role,
        required this.rolesTypeName,
    });

    final String? id;
    final bool? accountSetup;
    final bool? accountVerified;
    final String? email;
    final String? name;
    final String? phoneNumber;
    final Role1? role;
    final Role1? rolesTypeName;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            accountSetup: json["account_setup"],
            accountVerified: json["account_verified"],
            email: json["email"],
            name: json["name"],
            phoneNumber: json["phone_number"],
            role: json["role"] == null ? null : Role1.fromJson(json["role"]),
            rolesTypeName: json["RolesTypeName"] == null ? null : Role1.fromJson(json["RolesTypeName"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "account_setup": accountSetup,
        "account_verified": accountVerified,
        "email": email,
        "name": name,
        "phone_number": phoneNumber,
        "role": role?.toJson(),
        "RolesTypeName": rolesTypeName?.toJson(),
    };

}

class Role1 {
    Role1({
        required this.id,
        required this.roleId,
        required this.roleTypeName,
        required this.isActive,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.roleName,
        required this.roleTypes,
    });

    final String? id;
    final String? roleId;
    final String? roleTypeName;
    final int? isActive;
    final int? isDelete;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? roleName;
    final List<String> roleTypes;

    factory Role1.fromJson(Map<String, dynamic> json){ 
        return Role1(
            id: json["_id"],
            roleId: json["roleId"],
            roleTypeName: json["roleTypeName"],
            isActive: json["is_active"],
            isDelete: json["is_delete"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            roleName: json["roleName"],
            roleTypes: json["roleTypes"] == null ? [] : List<String>.from(json["roleTypes"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "roleId": roleId,
        "roleTypeName": roleTypeName,
        "is_active": isActive,
        "is_delete": isDelete,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "roleName": roleName,
        "roleTypes": roleTypes.map((x) => x).toList(),
    };

}
