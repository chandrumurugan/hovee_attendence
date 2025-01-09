class PhoneNumberVerifiedModel {
    PhoneNumberVerifiedModel({
        required this.data,
        required this.statusCode,
        required this.success,
        required this.message,
    });

    final PhnData? data;
    final int? statusCode;
    final bool? success;
    final String? message;

    factory PhoneNumberVerifiedModel.fromJson(Map<String, dynamic> json){ 
        return PhoneNumberVerifiedModel(
            data: json["data"] == null ? null : PhnData.fromJson(json["data"]),
            statusCode: json["statusCode"],
            success: json["success"],
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "statusCode": statusCode,
        "success": success,
        "message": message,
    };

}

class PhnData {
    PhnData({
        required this.accountVerificationToken,
        required this.otp,
    });

    final String? accountVerificationToken;
    final String? otp;

    factory PhnData.fromJson(Map<String, dynamic> json){ 
        return PhnData(
            accountVerificationToken: json["account_verification_token"],
            otp: json["otp"],
        );
    }

    Map<String, dynamic> toJson() => {
        "account_verification_token": accountVerificationToken,
        "otp": otp,
    };

}
