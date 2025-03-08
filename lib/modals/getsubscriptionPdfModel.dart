class GetsubscriptionPdfModel {
    GetsubscriptionPdfModel({
        required this.success,
        required this.statusCode,
        required this.data,
    });

    final bool? success;
    final int? statusCode;
    final Data? data;

    factory GetsubscriptionPdfModel.fromJson(Map<String, dynamic> json){ 
        return GetsubscriptionPdfModel(
            success: json["success"],
            statusCode: json["statusCode"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "data": data?.toJson(),
    };

}

class Data {
    Data({
        required this.id,
        required this.subscriptionId,
        required this.planId,
        required this.planName,
        required this.durationType,
        required this.duration,
        required this.price,
        required this.totalPrice,
        required this.isActive,
        required this.purchaseDate,
        required this.expiryDate,
        required this.paymentTxtId,
        required this.paymentStatus,
        required this.paymentStatusLabel,
        required this.paymentNotes,
        required this.invoiceId,
        required this.createdAt,
        required this.pdfFilepath,
        required this.pdfFilename,
    });

    final String? id;
    final String? subscriptionId;
    final String? planId;
    final String? planName;
    final String? durationType;
    final int? duration;
    final int? price;
    final int? totalPrice;
    final int? isActive;
    final String? purchaseDate;
    final String? expiryDate;
    final String? paymentTxtId;
    final int? paymentStatus;
    final String? paymentStatusLabel;
    final String? paymentNotes;
    final String? invoiceId;
    final DateTime? createdAt;
    final String? pdfFilepath;
    final String? pdfFilename;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            subscriptionId: json["subscription_id"],
            planId: json["plan_id"],
            planName: json["plan_name"],
            durationType: json["duration_type"],
            duration: json["duration"],
            price: json["price"],
            totalPrice: json["total_price"],
            isActive: json["is_active"],
            purchaseDate: json["purchase_date"],
            expiryDate: json["expiry_date"],
            paymentTxtId: json["payment_txt_id"],
            paymentStatus: json["payment_status"],
            paymentStatusLabel: json["payment_status_label"],
            paymentNotes: json["payment_notes"],
            invoiceId: json["invoice_id"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            pdfFilepath: json["pdf_filepath"],
            pdfFilename: json["pdf_filename"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "subscription_id": subscriptionId,
        "plan_id": planId,
        "plan_name": planName,
        "duration_type": durationType,
        "duration": duration,
        "price": price,
        "total_price": totalPrice,
        "is_active": isActive,
        "purchase_date": purchaseDate,
        "expiry_date": expiryDate,
        "payment_txt_id": paymentTxtId,
        "payment_status": paymentStatus,
        "payment_status_label": paymentStatusLabel,
        "payment_notes": paymentNotes,
        "invoice_id": invoiceId,
        "created_at": createdAt?.toIso8601String(),
        "pdf_filepath": pdfFilepath,
        "pdf_filename": pdfFilename,
    };

}
