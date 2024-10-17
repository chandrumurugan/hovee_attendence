

class AppConfig {
    AppConfig({
         this.statusCode,
         this.success,
         this.data,
    });

    final int? statusCode;
    final bool? success;
    final Data? data;

    factory AppConfig.fromJson(Map<String, dynamic> json){ 
        return AppConfig(
            statusCode: json["statusCode"],
            success: json["success"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.idProof,
        required this.teaching,
        required this.workExperience,
        required this.teachingSkill,
        required this.highestQualification,
        required this.batchMode,
        required this.batchDays,
        required this.studentCategory,
    });

    final List<BatchDay> idProof;
    final List<BatchDay> teaching;
    final List<BatchDay> workExperience;
    final List<BatchDay> teachingSkill;
    final List<BatchDay> highestQualification;
    final List<BatchDay> batchMode;
    final List<BatchDay> batchDays;
    final List<StudentCategory> studentCategory;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            idProof: json["ID_Proof"] == null ? [] : List<BatchDay>.from(json["ID_Proof"]!.map((x) => BatchDay.fromJson(x))),
            teaching: json["Teaching "] == null ? [] : List<BatchDay>.from(json["Teaching "]!.map((x) => BatchDay.fromJson(x))),
            workExperience: json["Work_Experience  "] == null ? [] : List<BatchDay>.from(json["Work_Experience  "]!.map((x) => BatchDay.fromJson(x))),
            teachingSkill: json["Teaching_Skill"] == null ? [] : List<BatchDay>.from(json["Teaching_Skill"]!.map((x) => BatchDay.fromJson(x))),
            highestQualification: json["Highest_Qualification"] == null ? [] : List<BatchDay>.from(json["Highest_Qualification"]!.map((x) => BatchDay.fromJson(x))),
            batchMode: json["Batch_Mode"] == null ? [] : List<BatchDay>.from(json["Batch_Mode"]!.map((x) => BatchDay.fromJson(x))),
            batchDays: json["Batch_Days"] == null ? [] : List<BatchDay>.from(json["Batch_Days"]!.map((x) => BatchDay.fromJson(x))),
            studentCategory: json["Student_Category"] == null ? [] : List<StudentCategory>.from(json["Student_Category"]!.map((x) => StudentCategory.fromJson(x))),
        );
    }

}

class BatchDay {
    BatchDay({
        required this.id,
        required this.label,
    });

    final String? id;
    final String? label;

    factory BatchDay.fromJson(Map<String, dynamic> json){ 
        return BatchDay(
            id: json["id"],
            label: json["label"],
        );
    }

}

class StudentCategory {
    StudentCategory({
        required this.id,
        required this.label,
    });

    final String? id;
    final Label? label;

    factory StudentCategory.fromJson(Map<String, dynamic> json){ 
        return StudentCategory(
            id: json["id"],
            label: json["label"] == null ? null : Label.fromJson(json["label"]),
        );
    }

}

class Label {
    Label({
        required this.categoryName,
        required this.labelData,
    });

    final String? categoryName;
    final List<LabelDatum> labelData;

    factory Label.fromJson(Map<String, dynamic> json){ 
        return Label(
            categoryName: json["category_name"],
            labelData: json["labelData"] == null ? [] : List<LabelDatum>.from(json["labelData"]!.map((x) => LabelDatum.fromJson(x))),
        );
    }

}

class LabelDatum {
    LabelDatum({
        required this.board,
        required this.classes,
    });

    final String? board;
    final List<Class> classes;

    factory LabelDatum.fromJson(Map<String, dynamic> json){ 
        return LabelDatum(
            board: json["board"],
            classes: json["classes"] == null ? [] : List<Class>.from(json["classes"]!.map((x) => Class.fromJson(x))),
        );
    }

}

class Class {
    Class({
        required this.className,
        required this.subjects,
    });

    final String? className;
    final List<Subject> subjects;

    factory Class.fromJson(Map<String, dynamic> json){ 
        return Class(
            className: json["class_name"],
            subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
        );
    }

}

class Subject {
    Subject({
        required this.name,
    });

    final String? name;

    factory Subject.fromJson(Map<String, dynamic> json){ 
        return Subject(
            name: json["name"],
        );
    }

}
