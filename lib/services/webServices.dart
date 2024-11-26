import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/config/appConfig.dart';
import 'package:hovee_attendence/modals/addClassData_model.dart';
import 'package:hovee_attendence/modals/addEnrollmentData_model.dart';
import 'package:hovee_attendence/modals/add_course_data_model.dart';
import 'package:hovee_attendence/modals/addbatch_model.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/deletebatch_model.dart';
import 'package:hovee_attendence/modals/enrollment_success_model.dart';
import 'package:hovee_attendence/modals/getAttendanceCourseList_model.dart';
import 'package:hovee_attendence/modals/getAttendancePunchIn_model.dart';
import 'package:hovee_attendence/modals/getClassTuteeById_model.dart';
import 'package:hovee_attendence/modals/getCouseList_model.dart';
import 'package:hovee_attendence/modals/getDashboardYearFlow_model.dart';
import 'package:hovee_attendence/modals/getEnquireList_model.dart';
import 'package:hovee_attendence/modals/getEnrollment_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendanceTutee_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendance_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/modals/getNotification_model.dart';
import 'package:hovee_attendence/modals/getQrcode_model.dart';
import 'package:hovee_attendence/modals/getTutionCourseList_model.dart';
import 'package:hovee_attendence/modals/getbatchlist_model.dart';
import 'package:hovee_attendence/modals/getmarkedNotification_model.dart';
import 'package:hovee_attendence/modals/loginModal.dart';
import 'package:hovee_attendence/modals/otpModal.dart';
import 'package:hovee_attendence/modals/regiasterModal.dart';
import 'package:hovee_attendence/modals/role_modal.dart';
import 'package:hovee_attendence/modals/singleCoursecategorylist_modal.dart';
import 'package:hovee_attendence/modals/submitEnquirModel.dart';
import 'package:hovee_attendence/modals/updateEnquire_model.dart';
import 'package:hovee_attendence/modals/validateTokenModel.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/modals/userProfile_modal.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebService {
  static String baseUrl = APIConfig.urlsConfig();

  static Future<AppConfig?> fetchAppConfig() async {
    try {
      var url = Uri.parse("${baseUrl}home/appConfig");
      var response = await http.post(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return AppConfig.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<LoginModal?> login(
      String identifiers, BuildContext context) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = {"identifier": identifiers};
      var url = Uri.parse("${baseUrl}user/auth/login");
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().i(response.bodyBytes);
      Logger().i(response.body);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return LoginModal.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showSuccessSnackBar(context,"${result["message"]}",);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<RegisterModal?> Register({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String dob,
    required String phNo,
    required String pincode,
    required String idProof,
  }) async {
    try {
      DateTime parsedDate1 = DateFormat('dd-MM-yyyy').parse(dob);
      String formattedDate1 = DateFormat('dd/MM/yyyy').format(parsedDate1);
      var headers = {'Content-Type': 'application/json'};

      var data = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "dob": formattedDate1,
        "phone_number": phNo,
        "pincode": pincode,
        "user_type": 2,
        "id_proof_label": idProof
      };

      var url = Uri.parse("${baseUrl}user/registerUser");
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return RegisterModal.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
          SnackBarUtils.showSuccessSnackBar(context,"${result["message"]}",);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<OtpModal?> otp(
      String otp, String accountverificationtoken, BuildContext context) async {
    try {
      var headers = {'Content-Type': 'application/json'};

      var data = {
        "account_verification_token": accountverificationtoken,
        "otp": otp
      };
      Logger().i(data);

      var url = Uri.parse("${baseUrl}user/verifyOtp");
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().i(response.body);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return OtpModal.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
         SnackBarUtils.showSuccessSnackBar(context,"${result["message"]}",);

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<LoginModal?> resendOtp(
      {required BuildContext context, required String accountToken}) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = {"account_verification_token": accountToken};
      var url = Uri.parse("${baseUrl}user/resendOtp");

      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().i(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return LoginModal.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
         SnackBarUtils.showSuccessSnackBar(context,"${result["message"]}",);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<AddBatchDataModel?> addBatch(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}batch/addBatch"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    Logger().i("getting24567890avaluue==>${batchData}");
     Logger().i("getting2456hgfujtgf0avaluue==>${token}");
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        
      );
      if (response.statusCode == 200) {
        return AddBatchDataModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getBatchListModel> fetchBatchList(String searchitems) async {
    final url = Uri.parse('${baseUrl}batch/getBatchList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    var data = {"searchKey": searchitems};
    final response = await http.post(
      url, // Replace with the actual API URL
      body: jsonEncode(data),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );
     print(token);
    if (response.statusCode == 200) {
      return getBatchListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load batch list');
    }
  }

  static Future<List<String>> fetchCoursecategory() async {
    final url = Uri.parse('${baseUrl}tutee/getClassTuteeList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";

    final reponse = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );
    if (reponse.statusCode == 200) {
      Map<String, dynamic> result = json.decode(reponse.body);
      return List<String>.from(result["data"]);
    } else {
      return [];
      //  throw Exception('Failed to fetch course category list');
    }
  }

  static Future<SingleCourseCategoryList?> singleCourseListfetch(
      String type) async {
    final url = Uri.parse('${baseUrl}tutee/getClassTuteeFilterList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var data = {"type": type};
    try {
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return SingleCourseCategoryList.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Role>?> getRoles() async {
    try {
      var url = Uri.parse("${baseUrl}roles/getRoles");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['data'] as List;
        return jsonData.map((role) => Role.fromJson(role)).toList();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<GetCourseDataModel> fetchCourseList(String searchitems) async {
    final url = Uri.parse('$baseUrl/course/getCourse');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
     var data = {"searchKey": searchitems};
    final response = await http.post(
      url, // Replace with the actual API URL
       body: jsonEncode(data),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GetCourseDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load course list');
    }
  }

  Future<http.StreamedResponse> submitAccountSetup({
    required String token,
    required Map<dynamic, dynamic> personalInfo,
    required Map<dynamic, dynamic> addressInfo,
    required Map<dynamic, dynamic> educationInfo,
    // required String roleId,
    //  required String roleTypeId,
    String resumePath = '',
    String educationCertPath = '',
    String experienceCertPath = '',
   required String latitude,required String longitude,
  }) async {
    var headers = {
      'Authorization': 'Bearer $token', // Pass the token for authorization
      'Content-Type': 'application/json'
    };

    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}user/accountSetup'));

    // Add personal info
    request.fields['personal_info'] = jsonEncode(personalInfo);

    // Add address info
    request.fields['permanent_address'] = jsonEncode(addressInfo);

    // Add education info
    request.fields['education_info'] = jsonEncode(educationInfo);

    // Add other fields
    request.fields['type'] = 'N';
    //  request.fields['id_proof'] = '';
    //  request.fields['resume'] = '';
    //  request.fields['education_certificate'] = '';
    //  request.fields['experience_certificate'] = '';
    //  request.fields['rolesId'] = roleId;
    //  request.fields['rolesTypeId'] = roleTypeId;
     request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;
    request.headers.addAll(headers);
    Logger().i(request.fields);

    // Add files (if present)
    // if (resumePath.isNotEmpty) {
    //   request.files.add(await http.MultipartFile.fromPath('resume', resumePath));
    // }
    // if (educationCertPath.isNotEmpty) {
    //   request.files.add(await http.MultipartFile.fromPath('education_certificate', educationCertPath));
    // }
    // if (experienceCertPath.isNotEmpty) {
    //   request.files.add(await http.MultipartFile.fromPath('experience_certificate', experienceCertPath));
    // }
    Logger().i(request.headers);

    // Send the request
    return await request.send();
  }

  static Future<UserProfileM?> fetchUserProfile() async {
    final box = GetStorage(); // Get an instance of GetStorage
      SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    try {
      var headers = {'Authorization': "Bearer $token"};
      var url = Uri.parse("${baseUrl}user/getUserProfile");
      var response = await http.post(url, headers: headers);
      Logger().i(response.headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return UserProfileM.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<http.StreamedResponse> submitTuteeAccountSetup({
    required String token,
    required Map<dynamic, dynamic> personalInfo,
    required Map<dynamic, dynamic> addressInfo,
    required Map<dynamic, dynamic> educationInfo,
    required String latitude,required String longitude,
  }) async {
    var headers = {
      'Authorization': 'Bearer $token', // Pass the token for authorization
      'Content-Type': 'application/json'
    };
    Logger().i(personalInfo);

    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}user/accountSetup'));

    // Add personal info
    request.fields['personal_info'] = jsonEncode(personalInfo);

    // Add address info
    request.fields['permanent_address'] = jsonEncode(addressInfo);

    // Add education info
    request.fields['education_info'] = jsonEncode(educationInfo);
    request.fields['type'] = 'N';
     request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;
    request.headers.addAll(headers);
    return await request.send();
  }

  static Future<getAddendanceCourseList> fetchAttendanceCourseList() async {
    final url = Uri.parse('${baseUrl}attendane/getAddendanceCourseList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getAddendanceCourseList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load attendanceCourse list');
    }
  }

  static Future<getAttendancePunchInModel?> getAttendancePunchIn(
      String courseId, String batchId, BuildContext context) async {
    final url = Uri.parse('${baseUrl}attendane/punchIn');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var data = {"courseId": courseId, "batchId": batchId};
    try {
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return getAttendancePunchInModel.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
         SnackBarUtils.showSuccessSnackBar(context,"${result["message"]}",);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getAttendancePunchInModel?> getAttendancePunchOut(
      BuildContext context) async {
    final url = Uri.parse('${baseUrl}attendane/punchOut');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    try {
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return getAttendancePunchInModel.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
          SnackBarUtils.showSuccessSnackBar(context,"${result["message"]}",);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getGroupedEnrollmentByBatch?>
      fetchGroupedEnrollmentByBatch() async {
    final url = Uri.parse('${baseUrl}attendane/getGroupedEnrollmentByBatch');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );
    Logger().i(response.statusCode);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return getGroupedEnrollmentByBatch.fromJson(result);
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<getGroupedEnrollmentByAttendanceModel?>
      fetchGroupedEnrollmentByBatchList(
          String batchId, String selectedDate,selectedMonth) async {
    final url =
        Uri.parse('${baseUrl}attendane/getGroupedEnrollmentByAttendance');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    var data = {"date": selectedDate, "batchId": batchId, "month":selectedMonth,"fromDate":'',
    "toDate":''};
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return getGroupedEnrollmentByAttendanceModel.fromJson(result);
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<AddCourseDataModel?> addCourse(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}course/addCourses"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return AddCourseDataModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

   static Future<AddClassDataModel?> addClass(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}tutor/addTuitionClass"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return AddClassDataModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

   static Future<getTuitionCourseListModel> fetchClassesList( Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}tutor/getTuitionClasses');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(batchData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getTuitionCourseListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load batch list');
    }
  }

    static Future<getTuitionCourseListModel> fetchTuitionCourseList() async {
    final url = Uri.parse('$baseUrl/tutor/getTuitionCourseList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getTuitionCourseListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load course list');
    }
  }

    static Future<AddClassDataModel?> updateClass(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}tutor/addTuitionClass"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return AddClassDataModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

   static Future<getClassTuteeByIdModel?> getClassTuteeById(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}tutee/getClassTuteeById"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return getClassTuteeByIdModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

   static Future<submitEnquiryModel?> addEnquirs(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}attendane/submitEnquiry"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return submitEnquiryModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getQrcodeModel> fetchQrCode() async {
    final url = Uri.parse('${baseUrl}home/getQrcode');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getQrcodeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load attendanceCourse list');
    }
  }

   static Future<getGroupedEnrollmentByAttendanceTutee?>
      fetchTutteAttendanceList(
          String batchId, String selectedDate,selectedMonth) async {
    final url =
        Uri.parse('${baseUrl}attendane/getGroupedEnrollmentByAttendanceTutee');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    var data = {"date": selectedDate, "batchId": batchId, "month":selectedMonth,"fromDate":'',
    "toDate":''};
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return getGroupedEnrollmentByAttendanceTutee.fromJson(result);
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<getEnquiryListModel> fetchEnquireList( Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}attendane/getEnquiryList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(batchData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getEnquiryListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Enquir list');
    }
  }

  static Future<UpdateEnquiryStatusModel ?> updateEnquire(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}attendane/updateEnquiryStatus"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return UpdateEnquiryStatusModel .fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

   static Future<List<String>> fetchNotificationsType() async {
    final url = Uri.parse('${baseUrl}home/getNotificationsType');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";

    final reponse = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );
    if (reponse.statusCode == 200) {
      Map<String, dynamic> result = json.decode(reponse.body);
      return List<String>.from(result["data"]);
    } else {
      return [];
      //  throw Exception('Failed to fetch course category list');
    }
  }

  static Future<getNotificationsModel> getNotifications( Map<String, dynamic> notificationData) async {
    final url = Uri.parse('${baseUrl}home/getNotifications');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(notificationData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getNotificationsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Notification list');
    }
  }


  static Future<getMarkNotificationAsReadModel> FetchMarkedNotification( Map<String, dynamic> notificationData) async {
    final url = Uri.parse('${baseUrl}home/markNotificationAsRead');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(notificationData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getMarkNotificationAsReadModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Notification list');
    }
  }

  static Future<addEnrollmentDataModel> addEnrollment( Map<String, dynamic> enrollmentData) async {
    final url = Uri.parse('${baseUrl}attendane/submitEnrollment');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(enrollmentData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return addEnrollmentDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Notification list');
    }
  }

   static Future<GetEnrollmentModel?> getEnrollment( Map<String, dynamic> batchData) async {
    try {
       final url = Uri.parse('${baseUrl}attendane/getEnrollment');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(batchData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );
    Logger().i(token);

    Logger().i(response.body);

    if (response.statusCode == 200) {
      return GetEnrollmentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Enquir list');
    } 
    } catch (e) {
     
       return null;
    }
   
  }

  static Future<UpdateEnrollmentStatusModel ?> updateEnrollment(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}attendane/updateEnrollment"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return UpdateEnrollmentStatusModel .fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<ValidateTokenModel ?> validateToken() async {
    final url = Uri.parse(
        "${baseUrl}user/validToken"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
     var data = {"token": token};
    try {
      final response = await http.post(
        url,
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return ValidateTokenModel .fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // static Future<ValidateTokenModel> validateToken() async {
  //   final url = Uri.parse('${baseUrl}user/validToken');
  //   final box = GetStorage(); // Get an instance of GetStorage
  //   // Retrieve the token from storage
  //   final token =prefs.getString('Token') ?? "";

  //   final reponse = await http.post(
  //     url, // Replace with the actual API URL
  //     headers: {
  //       'Authorization': 'Bearer $token', // Add the authorization token here
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   if (reponse.statusCode == 200) {
  //     //Map<String, dynamic> result = json.decode(reponse.body);
  //     return ValidateTokenModel.fromJson(json.decode(reponse.body));
  //   } else {
  //    return null;
  //     //  throw Exception('Failed to fetch course category list');
  //   }
  // }
   static Future<getHomeDashboardTutorModel> fetchHomeDashboardList() async {
    final url = Uri.parse('${baseUrl}home/getHomeDashboardTutor');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getHomeDashboardTutorModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load dashboard list');
    }
  }

    static Future<getdashboardYearflowModel?>
      fetchHomeAttendanceList(
          String batchId) async {
    final url =
        Uri.parse('${baseUrl}attendane/dashboardYearflow');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    var data = {"batchId": batchId};
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return getdashboardYearflowModel.fromJson(result);
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<deleteBatchDataModel> deleteBatch( Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}batch/deleteBatch');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(batchData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return deleteBatchDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Notification list');
    }
  }

  static Future<deleteBatchDataModel> deleteCourse( Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}course/deleteCourse');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(batchData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return deleteBatchDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Notification list');
    }
  }
}
