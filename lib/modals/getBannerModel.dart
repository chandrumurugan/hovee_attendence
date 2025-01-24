class GetBannerListModel {
    GetBannerListModel({
        required this.success,
        required this.statusCode,
        required this.message,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final String? message;
    final List<guestUserBannerData> data;

    factory GetBannerListModel.fromJson(Map<String, dynamic> json){ 
        return GetBannerListModel(
            success: json["success"],
            statusCode: json["statusCode"],
            message: json["message"],
            data: json["data"] == null ? [] : List<guestUserBannerData>.from(json["data"]!.map((x) => guestUserBannerData.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
    };

}

class guestUserBannerData {
    guestUserBannerData({
        required this.id,
        required this.regNo,
        required this.banTitle,
        required this.banFilename,
        required this.banUrl,
        required this.banDescription,
        required this.banType,
        required this.banCreated,
        required this.isActive,
        required this.isDelete,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? regNo;
    final String? banTitle;
    final String? banFilename;
    final String? banUrl;
    final String? banDescription;
    final String? banType;
    final String? banCreated;
    final int? isActive;
    final int? isDelete;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory guestUserBannerData.fromJson(Map<String, dynamic> json){ 
        return guestUserBannerData(
            id: json["_id"],
            regNo: json["reg_no"],
            banTitle: json["ban_title"],
            banFilename: json["ban_filename"],
            banUrl: json["ban_url"],
            banDescription: json["ban_description"],
            banType: json["ban_type"],
            banCreated: json["ban_created"],
            isActive: json["is_active"],
            isDelete: json["is_delete"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "reg_no": regNo,
        "ban_title": banTitle,
        "ban_filename": banFilename,
        "ban_url": banUrl,
        "ban_description": banDescription,
        "ban_type": banType,
        "ban_created": banCreated,
        "is_active": isActive,
        "is_delete": isDelete,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
    };

}
