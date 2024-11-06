
class SingleCourseCategoryList {
    SingleCourseCategoryList({
        required this.statusCode,
        required this.message,
        required this.dataList,
    });

    final int statusCode;
    final String message;
    final List<Map<String, String>> dataList;

    factory SingleCourseCategoryList.fromJson(Map<String, dynamic> json){ 
        return SingleCourseCategoryList(
            statusCode: json["statusCode"] ?? 0,
            message: json["message"] ?? "",
            dataList: json["data"] == null ? [] : List<Map<String, String>>.from(json["data"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v ?? "")))),
        );
    }

}