class SubmitEnquiryHostelModel {
    SubmitEnquiryHostelModel({
        required this.statusCode,
        required this.message,
        required this.enquiryId,
    });

    final int? statusCode;
    final String? message;
    final String? enquiryId;

    factory SubmitEnquiryHostelModel.fromJson(Map<String, dynamic> json){ 
        return SubmitEnquiryHostelModel(
            statusCode: json["statusCode"],
            message: json["message"],
            enquiryId: json["enquiryId"],
        );
    }

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "enquiryId": enquiryId,
    };

}
