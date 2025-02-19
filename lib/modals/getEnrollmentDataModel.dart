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
    final List<dynamic> enrollmentData;
    final List<NavbarItem> navbarItems;
    final String? roleName;
    final List<HostelListDetail> hostelListDetails;
    final String? roleTypeName;

    factory GetEnrollmentDataModel.fromJson(Map<String, dynamic> json){ 
        return GetEnrollmentDataModel(
            statusCode: json["statusCode"],
            enrollmentData: json["enrollmentData"] == null ? [] : List<dynamic>.from(json["enrollmentData"]!.map((x) => x)),
            navbarItems: json["navbarItems"] == null ? [] : List<NavbarItem>.from(json["navbarItems"]!.map((x) => NavbarItem.fromJson(x))),
            roleName: json["roleName"],
            hostelListDetails: json["hostelListDetails"] == null ? [] : List<HostelListDetail>.from(json["hostelListDetails"]!.map((x) => HostelListDetail.fromJson(x))),
            roleTypeName: json["roleTypeName"],
        );
    }

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "enrollmentData": enrollmentData.map((x) => x).toList(),
        "navbarItems": navbarItems.map((x) => x?.toJson()).toList(),
        "roleName": roleName,
        "hostelListDetails": hostelListDetails.map((x) => x?.toJson()).toList(),
        "roleTypeName": roleTypeName,
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
