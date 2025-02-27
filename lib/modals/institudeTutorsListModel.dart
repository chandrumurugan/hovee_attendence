class InstitudeTutorsListModel {
    InstitudeTutorsListModel({
        required this.success,
        required this.statusCode,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final Data2? data;

    factory InstitudeTutorsListModel.fromJson(Map<String, dynamic> json){ 
        return InstitudeTutorsListModel(
            success: json["success"],
            statusCode: json["statusCode"],
            data: json["data"] == null ? null : Data2.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "data": data?.toJson(),
    };

}

class Data2 {
    Data2({
        required this.records,
        required this.totalRecords,
        required this.roleName,
        required this.totalPages,
        required this.currentPage,
    });

    final List<Record> records;
    final int? totalRecords;
    final String? roleName;
    final int? totalPages;
    final dynamic currentPage;

    factory Data2.fromJson(Map<String, dynamic> json){ 
        return Data2(
            records: json["records"] == null ? [] : List<Record>.from(json["records"]!.map((x) => Record.fromJson(x))),
            totalRecords: json["totalRecords"],
            roleName: json["roleName"],
            totalPages: json["totalPages"],
            currentPage: json["currentPage"],
        );
    }

    Map<String, dynamic> toJson() => {
        "records": records.map((x) => x?.toJson()).toList(),
        "totalRecords": totalRecords,
        "roleName": roleName,
        "totalPages": totalPages,
        "currentPage": currentPage,
    };

}

class Record {
    Record({
        required this.location,
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
        required this.countryCode,
        required this.idProof,
        required this.idProofLabel,
        required this.idProofFilename,
        required this.idProofUrl,
        required this.profileFilename,
        required this.profileUrl,
        required this.latitude,
        required this.longitude,
        required this.fcmToken,
        required this.qrCodeUrl,
        required this.isActive,
        required this.isDeleted,
        required this.createdAt,
        required this.token,
        required this.address,
        required this.rolesId,
        required this.rolesTypeId,
    });

    final Location? location;
    final String? id;
    final String? firstName;
    final String? lastName;
    final String? wowId;
    final String? email;
    final String? dob;
    final String? phoneNumber;
    final int? pincode;
    final int? userType;
    final String? otp;
    final String? accountVerificationToken;
    final bool? accountVerified;
    final bool? accountSetup;
    final String? doorNo;
    final String? street;
    final String? city;
    final String? state;
    final String? country;
    final String? countryCode;
    final String? idProof;
    final String? idProofLabel;
    final String? idProofFilename;
    final String? idProofUrl;
    final String? profileFilename;
    final String? profileUrl;
    final double? latitude;
    final double? longitude;
    final String? fcmToken;
    final String? qrCodeUrl;
    final int? isActive;
    final int? isDeleted;
    final DateTime? createdAt;
    final String? token;
    final String? address;
    final String? rolesId;
    final String? rolesTypeId;

    factory Record.fromJson(Map<String, dynamic> json){ 
        return Record(
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
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
            countryCode: json["country_code"],
            idProof: json["id_proof"],
            idProofLabel: json["id_proof_label"],
            idProofFilename: json["id_proof_filename"],
            idProofUrl: json["id_proof_url"],
            profileFilename: json["profile_filename"],
            profileUrl: json["profile_url"],
            latitude: json["latitude"],
            longitude: json["longitude"],
            fcmToken: json["fcm_token"],
            qrCodeUrl: json["qr_code_url"],
            isActive: json["is_active"],
            isDeleted: json["is_deleted"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            token: json["token"],
            address: json["address"],
            rolesId: json["rolesId"],
            rolesTypeId: json["rolesTypeId"],
        );
    }

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "wow_id": wowId,
        "email": email,
        "dob": dob,
        "phone_number": phoneNumber,
        "pincode": pincode,
        "user_type": userType,
        "otp": otp,
        "account_verification_token": accountVerificationToken,
        "account_verified": accountVerified,
        "account_setup": accountSetup,
        "door_no": doorNo,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "country_code": countryCode,
        "id_proof": idProof,
        "id_proof_label": idProofLabel,
        "id_proof_filename": idProofFilename,
        "id_proof_url": idProofUrl,
        "profile_filename": profileFilename,
        "profile_url": profileUrl,
        "latitude": latitude,
        "longitude": longitude,
        "fcm_token": fcmToken,
        "qr_code_url": qrCodeUrl,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "token": token,
        "address": address,
        "rolesId": rolesId,
        "rolesTypeId": rolesTypeId,
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
