class RegisterModal {
    RegisterModal({
         this.success,
         this.statusCode,
         this.data,
         this.message,
    });

    final bool? success;
    final int? statusCode;
    final Data? data;
    final String? message;

    factory RegisterModal.fromJson(Map<String, dynamic> json){ 
        return RegisterModal(
            success: json["success"],
            statusCode: json["statusCode"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            message: json["message"],
        );
    }

}

class Data {
    Data({
        required this.id,
        required this.otp,
        required this.accountVerificationToken,
        required this.accountVerified,
        // required this.createdAt,
    });

    final String? id;
    final String? otp;
    final String? accountVerificationToken;
    final bool? accountVerified;
    // final DateTime? createdAt;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["_id"],
            otp: json["otp"],
            accountVerificationToken: json["account_verification_token"],
            accountVerified: json["account_verified"],
            // createdAt: DateTime.tryParse(json["created_at"] ?? ""),
        );
    }

}
