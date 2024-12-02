class AppConfig {
  int? statusCode;
  bool? success;
  Data? data;

  AppConfig({this.statusCode, this.success, this.data});

  AppConfig.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<IDProof>? iDProof;
  List<IDProof>? teaching;
  List<IDProof>? workExperience;
  List<IDProof>? highestQualification;
  List<IDProof>? batchMode;
  List<IDProof>? batchDays;
  List<StudentCategory>? studentCategory;
  List<IDProof>? tuteeHighestQualification;
  List<IDProof>? teachingSkill;
  List<IDProof>? leaveType;
  List<IDProof>? holidayType;

  Data(
      {this.iDProof,
      this.teaching,
      this.workExperience,
      this.highestQualification,
      this.batchMode,
      this.batchDays,
      this.studentCategory,
      this.tuteeHighestQualification,
      this.teachingSkill,
       this.leaveType,
      this.holidayType});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ID_Proof'] != null) {
      iDProof = <IDProof>[];
      json['ID_Proof'].forEach((v) {
        iDProof!.add(new IDProof.fromJson(v));
      });
    }
    if (json['Teaching'] != null) {
      teaching = <IDProof>[];
      json['Teaching'].forEach((v) {
        teaching!.add(new IDProof.fromJson(v));
      });
    }
    if (json['Work_Experience'] != null) {
      workExperience = <IDProof>[];
      json['Work_Experience'].forEach((v) {
        workExperience!.add(new IDProof.fromJson(v));
      });
    }
    if (json['Highest_Qualification'] != null) {
      highestQualification = <IDProof>[];
      json['Highest_Qualification'].forEach((v) {
        highestQualification!.add(new IDProof.fromJson(v));
      });
    }
    if (json['Batch_Mode'] != null) {
      batchMode = <IDProof>[];
      json['Batch_Mode'].forEach((v) {
        batchMode!.add(new IDProof.fromJson(v));
      });
    }
    if (json['Batch_Days'] != null) {
      batchDays = <IDProof>[];
      json['Batch_Days'].forEach((v) {
        batchDays!.add(new IDProof.fromJson(v));
      });
    }
    if (json['Student_Category'] != null) {
      studentCategory = <StudentCategory>[];
      json['Student_Category'].forEach((v) {
        studentCategory!.add(new StudentCategory.fromJson(v));
      });
    }
    if (json['Tutee_Highest_Qualification'] != null) {
      tuteeHighestQualification = <IDProof>[];
      json['Tutee_Highest_Qualification'].forEach((v) {
        tuteeHighestQualification!
            .add(new IDProof.fromJson(v));
      });
    }
    if (json['Teaching_Skill'] != null) {
      teachingSkill = <IDProof>[];
      json['Teaching_Skill'].forEach((v) {
        teachingSkill!.add(new IDProof.fromJson(v));
      });
    }
    if (json['Leave_type'] != null) {
      leaveType = <IDProof>[];
      json['Leave_type'].forEach((v) {
        leaveType!.add(new IDProof.fromJson(v));
      });
    }
    if (json['Holiday_type'] != null) {
      holidayType = <IDProof>[];
      json['Holiday_type'].forEach((v) {
        holidayType!.add(new IDProof.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iDProof != null) {
      data['ID_Proof'] = this.iDProof!.map((v) => v.toJson()).toList();
    }
    if (this.teaching != null) {
      data['Teaching'] = this.teaching!.map((v) => v.toJson()).toList();
    }
    if (this.workExperience != null) {
      data['Work_Experience'] =
          this.workExperience!.map((v) => v.toJson()).toList();
    }
    if (this.highestQualification != null) {
      data['Highest_Qualification'] =
          this.highestQualification!.map((v) => v.toJson()).toList();
    }
    if (this.batchMode != null) {
      data['Batch_Mode'] = this.batchMode!.map((v) => v.toJson()).toList();
    }
    if (this.batchDays != null) {
      data['Batch_Days'] = this.batchDays!.map((v) => v.toJson()).toList();
    }
    if (this.studentCategory != null) {
      data['Student_Category'] =
          this.studentCategory!.map((v) => v.toJson()).toList();
    }
    if (this.tuteeHighestQualification != null) {
      data['Tutee_Highest_Qualification'] =
          this.tuteeHighestQualification!.map((v) => v.toJson()).toList();
    }
    if (this.teachingSkill != null) {
      data['Teaching_Skill'] =
          this.teachingSkill!.map((v) => v.toJson()).toList();
    }
    if (this.leaveType != null) {
      data['Leave_type'] = this.leaveType!.map((v) => v.toJson()).toList();
    }
    if (this.holidayType != null) {
      data['Holiday_type'] = this.holidayType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IDProof {
  String? id;
  String? label;

  IDProof({this.id, this.label});

  IDProof.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    return data;
  }
}

class StudentCategory {
  String? id;
  Label? label;

  StudentCategory({this.id, this.label});

  StudentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'] != null ? new Label.fromJson(json['label']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.label != null) {
      data['label'] = this.label!.toJson();
    }
    return data;
  }
}

class Label {
  String? categoryName;
  List<LabelData>? labelData;

  Label({this.categoryName, this.labelData});

  Label.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    if (json['labelData'] != null) {
      labelData = <LabelData>[];
      json['labelData'].forEach((v) {
        labelData!.add(new LabelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    if (this.labelData != null) {
      data['labelData'] = this.labelData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LabelData {
  String? board;
  List<Classes>? classes;

  LabelData({this.board, this.classes});

  LabelData.fromJson(Map<String, dynamic> json) {
    board = json['board'];
    if (json['classes'] != null) {
      classes = <Classes>[];
      json['classes'].forEach((v) {
        classes!.add(new Classes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['board'] = this.board;
    if (this.classes != null) {
      data['classes'] = this.classes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Classes {
  String? className;
  List<Subjects>? subjects;

  Classes({this.className, this.subjects});

  Classes.fromJson(Map<String, dynamic> json) {
    className = json['class_name'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_name'] = this.className;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  String? name;

  Subjects({this.name});

  Subjects.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}