class GetHostelEnquiryListModel {
    GetHostelEnquiryListModel({
        required this.statusCode,
        required this.message,
        required this.data,
        required this.pagination,
    });

    final int? statusCode;
    final String? message;
    final List<Datum> data;
    final Pagination? pagination;

    factory GetHostelEnquiryListModel.fromJson(Map<String, dynamic> json){ 
        return GetHostelEnquiryListModel(
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
        "pagination": pagination?.toJson(),
    };

}

class Datum {
    Datum({
        required this.id,
        required this.hostelId,
        required this.hostellerObjectId,
        required this.hostelObjectId,
        required this.enquiryMessage,
        required this.status,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.hostelLists,
        required this.hostelPriceDetails,
        required this.hostelDetails,
        required this.hostellerDetails,
    });

    final String? id;
    final String? hostelId;
    final String? hostellerObjectId;
    final String? hostelObjectId;
    final String? enquiryMessage;
    final String? status;
    final int? isActive;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final HostelLists? hostelLists;
    final HostelPriceDetails? hostelPriceDetails;
    final HostelDetails? hostelDetails;
    final HostelDetails? hostellerDetails;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["_id"],
            hostelId: json["hostelId"],
            hostellerObjectId: json["hosteller_ObjectId"],
            hostelObjectId: json["hostel_ObjectId"],
            enquiryMessage: json["enquiry_message"],
            status: json["status"],
            isActive: json["is_active"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            hostelLists: json["hostel_Lists"] == null ? null : HostelLists.fromJson(json["hostel_Lists"]),
            hostelPriceDetails: json["hostelPriceDetails"] == null ? null : HostelPriceDetails.fromJson(json["hostelPriceDetails"]),
            hostelDetails: json["hostelDetails"] == null ? null : HostelDetails.fromJson(json["hostelDetails"]),
            hostellerDetails: json["hostellerDetails"] == null ? null : HostelDetails.fromJson(json["hostellerDetails"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "hostelId": hostelId,
        "hosteller_ObjectId": hostellerObjectId,
        "hostel_ObjectId": hostelObjectId,
        "enquiry_message": enquiryMessage,
        "status": status,
        "is_active": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "hostel_Lists": hostelLists?.toJson(),
        "hostelPriceDetails": hostelPriceDetails?.toJson(),
        "hostelDetails": hostelDetails?.toJson(),
        "hostellerDetails": hostellerDetails?.toJson(),
    };

}

class HostelDetails {
    HostelDetails({
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
        required this.address,
        required this.rolesTypeId,
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
    final String? address;
    final String? rolesTypeId;

    factory HostelDetails.fromJson(Map<String, dynamic> json){ 
        return HostelDetails(
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
            address: json["address"],
            rolesTypeId: json["rolesTypeId"],
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
        "address": address,
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

class HostelLists {
    HostelLists({
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

    factory HostelLists.fromJson(Map<String, dynamic> json){ 
        return HostelLists(
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

class HostelPriceDetails {
    HostelPriceDetails({
        required this.id,
        required this.hostelObjectId,
        required this.roomType,
        required this.price,
        required this.roomCount,
        required this.isActive,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? hostelObjectId;
    final String? roomType;
    final int? price;
    final int? roomCount;
    final int? isActive;
    final int? isDeleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory HostelPriceDetails.fromJson(Map<String, dynamic> json){ 
        return HostelPriceDetails(
            id: json["_id"],
            hostelObjectId: json["hostel_ObjectId"],
            roomType: json["room_type"],
            price: json["price"],
            roomCount: json["room_count"],
            isActive: json["is_active"],
            isDeleted: json["is_deleted"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "hostel_ObjectId": hostelObjectId,
        "room_type": roomType,
        "price": price,
        "room_count": roomCount,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
    };

}

class Pagination {
    Pagination({
        required this.totalItems,
        required this.currentPage,
        required this.totalPages,
    });

    final int? totalItems;
    final int? currentPage;
    final int? totalPages;

    factory Pagination.fromJson(Map<String, dynamic> json){ 
        return Pagination(
            totalItems: json["totalItems"],
            currentPage: json["currentPage"],
            totalPages: json["totalPages"],
        );
    }

    Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "currentPage": currentPage,
        "totalPages": totalPages,
    };

}
