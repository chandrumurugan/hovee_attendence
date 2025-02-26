class GetEnrollmentDataModel {
    GetEnrollmentDataModel({
        required this.statusCode,
        required this.enrollmentData,
        required this.navbarItems,
        required this.roleName,
        required this.hostelListDetails,
        required this.roleTypeName,
    });

    final int? statusCode;
    final List<EnrollmentDatum> enrollmentData;
    final List<NavbarItem> navbarItems;
    final String? roleName;
    final List<HostelListDetail> hostelListDetails;
    final String? roleTypeName;

    factory GetEnrollmentDataModel.fromJson(Map<String, dynamic> json){ 
        return GetEnrollmentDataModel(
            statusCode: json["statusCode"],
            enrollmentData: json["enrollmentData"] == null ? [] : List<EnrollmentDatum>.from(json["enrollmentData"]!.map((x) => EnrollmentDatum.fromJson(x))),
            navbarItems: json["navbarItems"] == null ? [] : List<NavbarItem>.from(json["navbarItems"]!.map((x) => NavbarItem.fromJson(x))),
            roleName: json["roleName"],
            hostelListDetails: json["hostelListDetails"] == null ? [] : List<HostelListDetail>.from(json["hostelListDetails"]!.map((x) => HostelListDetail.fromJson(x))),
            roleTypeName: json["roleTypeName"],
        );
    }

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "enrollmentData": enrollmentData.map((x) => x?.toJson()).toList(),
        "navbarItems": navbarItems.map((x) => x?.toJson()).toList(),
        "roleName": roleName,
        "hostelListDetails": hostelListDetails.map((x) => x?.toJson()).toList(),
        "roleTypeName": roleTypeName,
    };

}

class EnrollmentDatum {
    EnrollmentDatum({
        required this.id,
        required this.hostellerObjectIdDetails,
        required this.hostelObjectIdDetails,
        required this.hostelList,
    });

    final String? id;
    final HostelObjectIdDetails? hostellerObjectIdDetails;
    final HostelObjectIdDetails? hostelObjectIdDetails;
    final List<HostelList> hostelList;

    factory EnrollmentDatum.fromJson(Map<String, dynamic> json){ 
        return EnrollmentDatum(
            id: json["_id"],
            hostellerObjectIdDetails: json["hosteller_ObjectId_Details"] == null ? null : HostelObjectIdDetails.fromJson(json["hosteller_ObjectId_Details"]),
            hostelObjectIdDetails: json["hostel_ObjectId_Details"] == null ? null : HostelObjectIdDetails.fromJson(json["hostel_ObjectId_Details"]),
            hostelList: json["hostelList"] == null ? [] : List<HostelList>.from(json["hostelList"]!.map((x) => HostelList.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "hosteller_ObjectId_Details": hostellerObjectIdDetails?.toJson(),
        "hostel_ObjectId_Details": hostelObjectIdDetails?.toJson(),
        "hostelList": hostelList.map((x) => x?.toJson()).toList(),
    };

}

class HostelList {
    HostelList({
        required this.id,
        required this.hostelName,
        required this.roomType,
        required this.registerNo,
        required this.shortName,
        required this.hostelType,
        required this.food,
        required this.categories,
        required this.remarks,
        required this.hostelTimingStart,
        required this.hostelTimingEnd,
        required this.profileUrl,
    });

    final String? id;
    final String? hostelName;
    final String? roomType;
    final String? registerNo;
    final String? shortName;
    final String? hostelType;
    final String? food;
    final String? categories;
    final String? remarks;
    final String? hostelTimingStart;
    final String? hostelTimingEnd;
    final String? profileUrl;

    factory HostelList.fromJson(Map<String, dynamic> json){ 
        return HostelList(
            id: json["_id"],
            hostelName: json["hostel_name"],
            roomType: json["room_type"],
            registerNo: json["register_no"],
            shortName: json["short_name"],
            hostelType: json["hostel_type"],
            food: json["food"],
            categories: json["categories"],
            remarks: json["remarks"],
            hostelTimingStart: json["hostel_timing_start"],
            hostelTimingEnd: json["hostel_timing_end"],
            profileUrl: json["profileUrl"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "hostel_name": hostelName,
        "room_type": roomType,
        "register_no": registerNo,
        "short_name": shortName,
        "hostel_type": hostelType,
        "food": food,
        "categories": categories,
        "remarks": remarks,
        "hostel_timing_start": hostelTimingStart,
        "hostel_timing_end": hostelTimingEnd,
    };

}

class HostelObjectIdDetails {
    HostelObjectIdDetails({
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
        required this.latitude,
        required this.longitude,
        required this.location,
        required this.fcmToken,
        required this.qrCodeUrl,
        required this.isActive,
        required this.isDeleted,
        required this.createdAt,
        required this.v,
        required this.token,
        required this.rolesId,
        required this.countryCode,
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
    final String? profileUrl;
    final dynamic latitude;
    final dynamic longitude;
    final Location? location;
    final String? fcmToken;
    final String? qrCodeUrl;
    final int? isActive;
    final int? isDeleted;
    final DateTime? createdAt;
    final int? v;
    final String? token;
    final String? rolesId;
    final String? countryCode;

    factory HostelObjectIdDetails.fromJson(Map<String, dynamic> json){ 
        return HostelObjectIdDetails(
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
            latitude: json["latitude"],
            longitude: json["longitude"],
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            fcmToken: json["fcm_token"],
            qrCodeUrl: json["qr_code_url"],
            isActive: json["is_active"],
            isDeleted: json["is_deleted"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            v: json["__v"],
            token: json["token"],
            rolesId: json["rolesId"],
            countryCode: json["country_code"],
        );
    }

    Map<String, dynamic> toJson() => {
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
        "id_proof": idProof,
        "id_proof_label": idProofLabel,
        "id_proof_filename": idProofFilename,
        "id_proof_url": idProofUrl,
        "profile_filename": profileFilename,
        "profile_url": profileUrl,
        "latitude": latitude,
        "longitude": longitude,
        "location": location?.toJson(),
        "fcm_token": fcmToken,
        "qr_code_url": qrCodeUrl,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "__v": v,
        "token": token,
        "rolesId": rolesId,
        "country_code": countryCode,
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

class HostelListDetail {
    HostelListDetail({
        required this.id,
        required this.hostelObjectId,
        required this.roomType,
        required this.hostelName,
        required this.registerNo,
        required this.shortName,
        required this.hostelType,
        required this.food,
        required this.categories,
        required this.remarks,
        required this.latitude,
        required this.longitude,
        required this.location,
        required this.doorNo,
        required this.street,
        required this.city,
        required this.state,
        required this.country,
        required this.pincode,
        required this.profileFilename,
        required this.profileUrl,
        required this.hostelTimingStart,
        required this.hostelTimingEnd,
        required this.hostelTimingStartMinutes,
        required this.hostelTimingEndMinutes,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? hostelObjectId;
    final String? roomType;
    final String? hostelName;
    final String? registerNo;
    final String? shortName;
    final String? hostelType;
    final String? food;
    final String? categories;
    final String? remarks;
    final double? latitude;
    final double? longitude;
    final Location? location;
    final String? doorNo;
    final String? street;
    final String? city;
    final String? state;
    final String? country;
    final String? pincode;
    final dynamic profileFilename;
    final dynamic profileUrl;
    final String? hostelTimingStart;
    final String? hostelTimingEnd;
    final int? hostelTimingStartMinutes;
    final int? hostelTimingEndMinutes;
    final int? isActive;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory HostelListDetail.fromJson(Map<String, dynamic> json){ 
        return HostelListDetail(
            id: json["_id"],
            hostelObjectId: json["hostel_ObjectId"],
            roomType: json["room_type"],
            hostelName: json["hostel_name"],
            registerNo: json["register_no"],
            shortName: json["short_name"],
            hostelType: json["hostel_type"],
            food: json["food"],
            categories: json["categories"],
            remarks: json["remarks"],
            latitude: json["latitude"],
            longitude: json["longitude"],
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            doorNo: json["door_no"],
            street: json["street"],
            city: json["city"],
            state: json["state"],
            country: json["country"],
            pincode: json["pincode"],
            profileFilename: json["profile_filename"],
            profileUrl: json["profile_url"],
            hostelTimingStart: json["hostel_timing_start"],
            hostelTimingEnd: json["hostel_timing_end"],
            hostelTimingStartMinutes: json["hostel_timing_start_minutes"],
            hostelTimingEndMinutes: json["hostel_timing_end_minutes"],
            isActive: json["is_active"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "hostel_ObjectId": hostelObjectId,
        "room_type": roomType,
        "hostel_name": hostelName,
        "register_no": registerNo,
        "short_name": shortName,
        "hostel_type": hostelType,
        "food": food,
        "categories": categories,
        "remarks": remarks,
        "latitude": latitude,
        "longitude": longitude,
        "location": location?.toJson(),
        "door_no": doorNo,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "profile_filename": profileFilename,
        "profile_url": profileUrl,
        "hostel_timing_start": hostelTimingStart,
        "hostel_timing_end": hostelTimingEnd,
        "hostel_timing_start_minutes": hostelTimingStartMinutes,
        "hostel_timing_end_minutes": hostelTimingEndMinutes,
        "is_active": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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
