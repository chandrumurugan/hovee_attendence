
class LoginModal {
    LoginModal({
         this.statusCode,
         this.success,
         this.message,
         this.accountVerified,
         this.accountVerificationToken,
         this.otp,
    });

    final int? statusCode;
    final bool? success;
    final String? message;
    final bool? accountVerified;
    final String? accountVerificationToken;
    final String? otp;

    factory LoginModal.fromJson(Map<String, dynamic> json){ 
        return LoginModal(
            statusCode: json["statusCode"],
            success: json["success"],
            message: json["message"],
            accountVerified: json["account_verified"],
            accountVerificationToken: json["account_verification_token"],
            otp: json["otp"],
        );
    }

}