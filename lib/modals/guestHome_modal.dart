class GuestUserModal {
    GuestUserModal({
        required this.statusCode,
        required this.data,
    });

    final int statusCode;
    final Data? data;

    factory GuestUserModal.fromJson(Map<String, dynamic> json){ 
        return GuestUserModal(
            statusCode: json["statusCode"] ?? 0,
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.courseList,
        required this.teacherList,
    });

    final List<CourseList> courseList;
    final List<TeacherList> teacherList;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            courseList: json["courseList"] == null ? [] : List<CourseList>.from(json["courseList"]!.map((x) => CourseList.fromJson(x))),
            teacherList: json["teacherList"] == null ? [] : List<TeacherList>.from(json["teacherList"]!.map((x) => TeacherList.fromJson(x))),
        );
    }

}

class CourseList {
    CourseList({
        required this.id,
        required this.batchName,
        required this.board,
        required this.className,
        required this.subject,
        required this.courseCode,
    });

    final String id;
    final String batchName;
    final String board;
    final String className;
    final String subject;
    final String courseCode;

    factory CourseList.fromJson(Map<String, dynamic> json){ 
        return CourseList(
            id: json["_id"] ?? "",
            batchName: json["batch_name"] ?? "",
            board: json["board"] ?? "",
            className: json["class_name"] ?? "",
            subject: json["subject"] ?? "",
            courseCode: json["course_code"] ?? "",
        );
    }

}

class TeacherList {
    TeacherList({
        required this.id,
        required this.branchName,
        required this.teacherName,
        required this.teacherRollNumber,
        required this.qualification,
        required this.experience,
        required this.mobileNo,
    });

    final String id;
    final String branchName;
    final String teacherName;
    final String teacherRollNumber;
    final String qualification;
    final String experience;
    final String mobileNo;

    factory TeacherList.fromJson(Map<String, dynamic> json){ 
        return TeacherList(
            id: json["_id"] ?? "",
            branchName: json["branch_name"] ?? "",
            teacherName: json["teacher_name"] ?? "",
            teacherRollNumber: json["teacher_roll_number"] ?? "",
            qualification: json["qualification"] ?? "",
            experience: json["experience"] ?? "",
            mobileNo: json["mobileNo"] ?? "",
        );
    }

}
