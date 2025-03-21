import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/config/appConfig.dart';
import 'package:hovee_attendence/modals/Regsisterparent_model.dart';
import 'package:hovee_attendence/modals/addAnnounmentModel.dart';
import 'package:hovee_attendence/modals/addClassData_model.dart';
import 'package:hovee_attendence/modals/addEnrollmentData_model.dart';
import 'package:hovee_attendence/modals/addHolidaymodel.dart';
import 'package:hovee_attendence/modals/addMspModel.dart';
import 'package:hovee_attendence/modals/add_course_data_model.dart';
import 'package:hovee_attendence/modals/add_leave_model.dart';
import 'package:hovee_attendence/modals/addbatch_model.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/deleteHolidayModel.dart';
import 'package:hovee_attendence/modals/delete_announcement_model.dart';
import 'package:hovee_attendence/modals/deletebatch_model.dart';
import 'package:hovee_attendence/modals/enrollment_success_model.dart';
import 'package:hovee_attendence/modals/fetchGuestUserHostelListModel.dart';
import 'package:hovee_attendence/modals/getAnnounmentBatchList_model.dart';
import 'package:hovee_attendence/modals/getAnnounment_model.dart';
import 'package:hovee_attendence/modals/getAttendanceCourseList_model.dart';
import 'package:hovee_attendence/modals/getAttendancePunchIn_model.dart';
import 'package:hovee_attendence/modals/getBannerModel.dart';
import 'package:hovee_attendence/modals/getBatchtuteelistModel.dart';
import 'package:hovee_attendence/modals/getClassTuteeById_model.dart';
import 'package:hovee_attendence/modals/getCouseList_model.dart';
import 'package:hovee_attendence/modals/getDashboardYearFlow_model.dart';
import 'package:hovee_attendence/modals/getEnquireList_model.dart';
import 'package:hovee_attendence/modals/getEnrollmentDataModel.dart';
import 'package:hovee_attendence/modals/getEnrollment_model.dart';
import 'package:hovee_attendence/modals/getGrouedEnrollmentBylevaemodel.dart';
import 'package:hovee_attendence/modals/getGroupedAnnouncementHostelModel.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendanceTutee_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendanceTutor_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendance_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByHostelModel.dart';
import 'package:hovee_attendence/modals/getHolidayDataModel.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/modals/getHostelAttendanceCalendarReportModel.dart';
import 'package:hovee_attendence/modals/getHostelEnquiryListModel.dart';
import 'package:hovee_attendence/modals/getHostelEnrollmentListModel.dart';
import 'package:hovee_attendence/modals/getHostelFilterListModel.dart';
import 'package:hovee_attendence/modals/getLeaveListModel.dart';
import 'package:hovee_attendence/modals/getMspHostelModel.dart';
import 'package:hovee_attendence/modals/getMsplistmodel.dart';
import 'package:hovee_attendence/modals/getNotification_model.dart';
import 'package:hovee_attendence/modals/getParenthomeModal.dart';
import 'package:hovee_attendence/modals/getParentvalidateCodeModel.dart';
import 'package:hovee_attendence/modals/getQrcode_model.dart';
import 'package:hovee_attendence/modals/getRatingDashboardListModel.dart';
import 'package:hovee_attendence/modals/getRatingTutorListModel.dart';
import 'package:hovee_attendence/modals/getRatingsListModel.dart';
import 'package:hovee_attendence/modals/getSubscriptionByPlanModel.dart';
import 'package:hovee_attendence/modals/getSubscriptionModel.dart';
import 'package:hovee_attendence/modals/getTestimonialsModel.dart';
import 'package:hovee_attendence/modals/getTutionCourseList_model.dart';
import 'package:hovee_attendence/modals/getUserTokenList_model.dart';
import 'package:hovee_attendence/modals/getbatchlist_model.dart';
import 'package:hovee_attendence/modals/getbatchlocation.dart';
import 'package:hovee_attendence/modals/getcurrentsubscriptionModel.dart';
import 'package:hovee_attendence/modals/getmarkedNotification_model.dart';
import 'package:hovee_attendence/modals/getsubscriptionPdfModel.dart';
import 'package:hovee_attendence/modals/googleSignInModel.dart';
import 'package:hovee_attendence/modals/guestHome_modal.dart';
import 'package:hovee_attendence/modals/guest_searchModel.dart';
import 'package:hovee_attendence/modals/institudeTutorsListModel.dart';
import 'package:hovee_attendence/modals/loginModal.dart';
import 'package:hovee_attendence/modals/my_payments_modal.dart';
import 'package:hovee_attendence/modals/otpModal.dart';
import 'package:hovee_attendence/modals/parentLoginDataModel.dart';
import 'package:hovee_attendence/modals/parentLoginModel.dart';
import 'package:hovee_attendence/modals/phonenumberVerfication_model.dart';
import 'package:hovee_attendence/modals/postPayment_model.dart';
import 'package:hovee_attendence/modals/regiasterModal.dart';
import 'package:hovee_attendence/modals/role_modal.dart';
import 'package:hovee_attendence/modals/singleCoursecategorylist_modal.dart';
import 'package:hovee_attendence/modals/submitEnquirModel.dart';
import 'package:hovee_attendence/modals/submitEnquiryHostelModel.dart';
import 'package:hovee_attendence/modals/updateEnquire_model.dart';
import 'package:hovee_attendence/modals/updateLeaveModel.dart';
import 'package:hovee_attendence/modals/update_parent_status_model.dart';
import 'package:hovee_attendence/modals/validateTokenModel.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/modals/userProfile_modal.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

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
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );
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
    required String countrycode,
  }) async {
    try {
      DateTime parsedDate1 = DateFormat('dd-MM-yyyy').parse(dob);
      String formattedDate1 = DateFormat('dd/MM/yyyy').format(parsedDate1);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var fcmToken = prefs.getString("FCM_TOKEN");
      var headers = {'Content-Type': 'application/json'};

      var data = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "dob": formattedDate1,
        "phone_number": phNo,
        "pincode": pincode,
        "user_type": 2,
        "id_proof_label": idProof,
        if (fcmToken != null) "fcm_token": fcmToken,
        "country_code": countrycode,
        "country": 'india',
      };

      var url = Uri.parse("${baseUrl}user/registerUser");
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().i(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return RegisterModal.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<OtpModal?> otp(
      String otp, String accountverificationtoken, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var fcmToken = prefs.getString("FCM_TOKEN");
      var headers = {'Content-Type': 'application/json'};
      final rolename = prefs.getString('Rolename') ?? '';
      var data = {
        "account_verification_token": accountverificationtoken,
        "otp": otp,
        if (fcmToken != null) "fcm_token": fcmToken
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
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );

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
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );
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
    final token = prefs.getString('Token') ?? "";
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

  static Future<getBatchListModel> fetchBatchList(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}batch/getBatchList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: jsonEncode(batchData),
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
    final token = prefs.getString('Token') ?? "";

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
      String type, searchTerm) async {
    final url = Uri.parse('${baseUrl}tutee/getClassTuteeFilterList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var data = {"type": type, "search": searchTerm};
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
    final token = prefs.getString('Token') ?? "";
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

  static Future<http.StreamedResponse> submitAccountSetup({
    required String token,
    required Map<dynamic, dynamic> personalInfo,
    required Map<dynamic, dynamic> addressInfo,
    required Map<dynamic, dynamic> educationInfo,
    // required String roleId,
    //  required String roleTypeId,
    required String resumePath,
    required String educationCertPath,
    required String experienceCertPath,
    required String latitude,
    required String longitude,
    required String parentId,
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
    request.fields['parentId'] = parentId;
    // Attach files if available
    if (resumePath != null && resumePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('resume', resumePath,
          contentType: MediaType('image', 'jpeg')));
    }
    if (educationCertPath != null && educationCertPath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
          'education_certificate', educationCertPath,
          contentType: MediaType('image', 'jpeg')));
    }
    if (experienceCertPath != null && experienceCertPath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
          'experience_certificate', experienceCertPath,
          contentType: MediaType('image', 'jpeg')));
    }
    request.headers.addAll(headers);
    Logger().i(request.fields);
    Logger().i(request.headers);
    Logger().i(personalInfo);
    Logger().i(addressInfo);
    Logger().i(educationInfo);
    // Send the request
    return await request.send();
  }

  // static Future<http.StreamedResponse> submitAccountSetupEdit({
  //   required String token,
  //   required Map<dynamic, dynamic> personalInfo,
  //   required Map<dynamic, dynamic> addressInfo,
  //   required Map<dynamic, dynamic> educationInfo,
  //   // required String roleId,
  //   //  required String roleTypeId,
  //   required String resumePath,
  //   required String educationCertPath,
  //   required String experienceCertPath,
  //   required String latitude,
  //   required String longitude,
  //   required String idproof,
  // }) async {
  //   var headers = {
  //     'Authorization': 'Bearer $token', // Pass the token for authorization
  //     'Content-Type': 'application/json'
  //   };

  //   var request =
  //       http.MultipartRequest('POST', Uri.parse('${baseUrl}user/accountSetup'));

  //   // Add personal info
  //   request.fields['personal_info'] = jsonEncode(personalInfo);

  //   // Add address info
  //   request.fields['permanent_address'] = jsonEncode(addressInfo);

  //   // Add education info
  //   request.fields['education_info'] = jsonEncode(educationInfo);

  //   // Add other fields
  //   request.fields['type'] = 'U';
  //   request.fields['latitude'] = latitude;
  //   request.fields['longitude'] = longitude;
  //    request.files.add(await http.MultipartFile.fromPath(
  //         'id_proof', idproof));
  //   request.headers.addAll(headers);
  //   Logger().i(request.fields);

  //   // Add files (if present)
  //   if (resumePath != null && resumePath.isNotEmpty) {
  //     request.files
  //         .add(await http.MultipartFile.fromPath('resume', resumePath,contentType: MediaType('image', 'jpg')));
  //   }
  //   if (educationCertPath != null && educationCertPath.isNotEmpty) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //         'education_certificate', educationCertPath,contentType: MediaType('image', 'jpg')));
  //   }
  //   if (experienceCertPath != null && experienceCertPath.isNotEmpty) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //         'experience_certificate', experienceCertPath,contentType: MediaType('image', 'jpg')));
  //   }
  //   request.files.add(await http.MultipartFile.fromPath(
  //         'id_proof', idproof,contentType: MediaType('image', 'jpeg')));
  //   Logger().i(request.headers);
  //   Logger().i(personalInfo);
  //   Logger().i(addressInfo);
  //   Logger().i(educationInfo);
  //   // Send the request
  //   return await request.send();
  // }
  static Future<http.StreamedResponse> submitAccountSetupEdit(
      {required String token,
      required Map<dynamic, dynamic> personalInfo,
      required Map<dynamic, dynamic> addressInfo,
      required Map<dynamic, dynamic> educationInfo,
      required String resumePath,
      required String educationCertPath,
      required String experienceCertPath,
      required String latitude,
      required String longitude,
      required String idproof,
      required String profileImage}) async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}user/accountSetup'));

    // Add form fields
    request.fields['personal_info'] = jsonEncode(personalInfo);
    request.fields['permanent_address'] = jsonEncode(addressInfo);
    request.fields['education_info'] = jsonEncode(educationInfo);
    request.fields['type'] = 'U';
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;

    request.headers.addAll(headers);

    // Function to handle file uploads
    Future<void> addFile(String fieldName, String filePath) async {
      if (filePath.isNotEmpty && !filePath.startsWith('http')) {
        // If filePath is NOT a URL, it's a new file → upload it
        request.files.add(await http.MultipartFile.fromPath(
          fieldName,
          filePath,
          contentType: MediaType('image', 'jpg'),
        ));
      } else {
        // If filePath is a URL, just send the existing file path in fields
        request.fields[fieldName] = filePath ?? '';
      }
    }

    // Upload only if it's a new file, otherwise send the existing URL
    await addFile('id_proof', idproof);
    await addFile('resume', resumePath);
    await addFile('education_certificate', educationCertPath);
    await addFile('experience_certificate', experienceCertPath);
    if (profileImage != null && profileImage.isNotEmpty) {
    request.files.add(await http.MultipartFile.fromPath(
      'profile_image', profileImage,
      contentType: MediaType('image', 'jpeg'),
    ));
  }
    Logger().i(request.fields);
    Logger().i(request.headers);

    return await request.send();
  }

  static Future<http.StreamedResponse> submitSetupEdit(
      {required String token,
      required Map<dynamic, dynamic> personalInfo,
      required Map<dynamic, dynamic> addressInfo,
      required String latitude,
      required String longitude,
      required String idproof,
      required String profileImage,
      required String parentId}) async {
         SharedPreferences prefs = await SharedPreferences.getInstance();
         final token = prefs.getString('Token') ?? "";
    final rolename = prefs.getString('Rolename') ?? "";
    final parentToken = prefs.getString('PrentToken') ?? "";
    String lastToken = "";
    if (rolename == 'Parent') {
      lastToken = parentToken;
    } else {
      lastToken = token;
    }
    var headers = {
      'Authorization': 'Bearer $lastToken', // Pass the token for authorization
      'Content-Type': 'application/json'
    };
    Logger().i(token);
    
    var request = 
        http.MultipartRequest('POST', Uri.parse('${baseUrl}user/accountSetup'));

    // Add personal info
    request.fields['personal_info'] = jsonEncode(personalInfo);

    // Add address info
    request.fields['permanent_address'] = jsonEncode(addressInfo);
    request.fields['type'] = 'U';
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    request.fields['parentId'] = parentId;
    request.files.add(await http.MultipartFile.fromPath('id_proof', idproof,
        contentType: MediaType('image', 'jpeg')));
    // Check if `profileImage` is provided before adding
  if (profileImage != null && profileImage.isNotEmpty) {
    request.files.add(await http.MultipartFile.fromPath(
      'profile_image', profileImage,
      contentType: MediaType('image', 'jpeg'),
    ));
  }  
  
    request.headers.addAll(headers);
    Logger().i(request.fields);
     Logger().i(request.headers);
    return await request.send();
  }

  static Future<UserProfileM?> fetchUserProfile() async {
    final box = GetStorage(); // Get an instance of GetStorage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final rolename = prefs.getString('Rolename') ?? "";
    final parentToken = prefs.getString('PrentToken') ?? "";
    String lastToken = "";
    if (rolename == 'Parent') {
      lastToken = parentToken;
    } else {
      lastToken = token;
    }
    try {
      var headers = {'Authorization': "Bearer $lastToken"};
      var url = Uri.parse("${baseUrl}user/getUserProfile");
      var response = await http.post(url, headers: headers);
      Logger().i(response.headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return UserProfileM.fromJson(data);
      } else if (response.statusCode == 401) {
        // Clear session data
        await prefs.clear();
        // Navigate to the login screen
        Get.to(() => LoginSignUp());
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<http.StreamedResponse> submitTuteeAccountSetup({
    required String parentId,
    required String token,
    required Map<dynamic, dynamic> personalInfo,
    required Map<dynamic, dynamic> addressInfo,
    required Map<dynamic, dynamic> educationInfo,
    required String latitude,
    required String longitude,
  }) async {
    var headers = {
      'Authorization': 'Bearer $token', // Pass the token for authorization
      'Content-Type': 'application/json'
    };
    Logger().i(personalInfo);

    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}user/accountSetup'));
    Logger().i(request);
    // Add personal info
    request.fields['personal_info'] = jsonEncode(personalInfo);

    // Add address info
    request.fields['permanent_address'] = jsonEncode(addressInfo);

    // Add education info
    request.fields['education_info'] = jsonEncode(educationInfo);
    request.fields['type'] = 'N';
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    request.fields['parentId'] = parentId;
    request.headers.addAll(headers);
    return await request.send();
  }

  static Future<http.StreamedResponse> submitTuteeAccountSetupEdit(
      {required String token,
      required Map<dynamic, dynamic> personalInfo,
      required Map<dynamic, dynamic> addressInfo,
      required Map<dynamic, dynamic> educationInfo,
      required String latitude,
      required String longitude,
      required String idproof,
      required String profileImage}) async {
    var headers = {
      'Authorization': 'Bearer $token', // Pass the token for authorization
      //'Content-Type': 'application/json'
    };
    Logger().i(token);

    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}user/accountSetup'));

    // Add personal info
    request.fields['personal_info'] = jsonEncode(personalInfo);

    // Add address info
    request.fields['permanent_address'] = jsonEncode(addressInfo);

    // Add education info
    request.fields['education_info'] = jsonEncode(educationInfo);
    request.fields['type'] = 'U';
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    request.files.add(await http.MultipartFile.fromPath('id_proof', idproof,
        contentType: MediaType('image', 'jpeg')));
    // Check if `profileImage` is provided before adding
  if (profileImage != null && profileImage.isNotEmpty) {
    request.files.add(await http.MultipartFile.fromPath(
      'profile_image', profileImage,
      contentType: MediaType('image', 'jpeg'),
    ));
  }
    request.headers.addAll(headers);
    Logger().i(request.fields);
    return await request.send();
  }

  static Future<getAddendanceCourseList> fetchAttendanceCourseList() async {
    final url = Uri.parse('${baseUrl}attendane/getAddendanceCourseList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
    Logger().d("api calling");
    final url = Uri.parse('${baseUrl}attendane/punchIn');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var data = {"courseId": courseId, "batchId": batchId};
    Logger().d("api calling ==>${token}");
    Logger().d("api calling ==>${data}");
    try {
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().d(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return getAttendancePunchInModel.fromJson(result);
      } else {
        Logger().d(response.reasonPhrase);
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  static Future<getAttendancePunchInModel?> getAttendancePunchOut(
      BuildContext context, String batchId) async {
    final url = Uri.parse('${baseUrl}attendane/punchOut');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = {"batchId": batchId};
    final token = prefs.getString('Token') ?? "";
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return getAttendancePunchInModel.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );
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
    final token = prefs.getString('Token') ?? "";
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
    } else if (response.statusCode == 401) {
      // Clear session data
      await prefs.clear();
      // Navigate to the login screen
      Get.to(() => LoginSignUp());
      return null;
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<GetGroupedEnrollmentByAttendanceTutorModel?>
      fetchGroupedEnrollmentByBatchList(
          String batchId, String selectedDate, selectedMonth) async {
    final url =
        Uri.parse('${baseUrl}attendane/getGroupedEnrollmentByAttendance');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var data = {
      "date": selectedDate,
      "batchId": batchId,
      "month": selectedMonth,
      "fromDate": '',
      "toDate": ''
    };
    print(data);
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
      Logger().i(result);
      return GetGroupedEnrollmentByAttendanceTutorModel.fromJson(result);
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
    final token = prefs.getString('Token') ?? "";
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
    final token = prefs.getString('Token') ?? "";
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
        var result = AddClassDataModel.fromJson(json.decode(response.body));
        Get.snackbar(
          '',
          icon: const Icon(Icons.info, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
         messageText: SizedBox(
            height: 30, // Set desired height here
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0,),
              child: Center(
                child: Text(
                  result.message.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        )
        );
        // Either return a default instance or throw an error
        return AddClassDataModel(message: result.message);
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getTuitionCourseListModel> fetchClassesList(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}tutor/getTuitionClasses');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
    final token = prefs.getString('Token') ?? "";
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
    final token = prefs.getString('Token') ?? "";
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

  static Future<GetClassTuteeByIdModel?> getClassTuteeById(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}tutee/getClassTuteeByIds"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        Logger().i("message${response.body}");
        return GetClassTuteeByIdModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<SubmitEnquiryHostelModel?> addEnquirsHostel(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}hostel/enquiry/submitEnquiry"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        return SubmitEnquiryHostelModel.fromJson(json.decode(response.body));
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
    final token = prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getQrcodeModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      // Clear session data
      await prefs.clear();
      // Navigate to the login screen
      Get.to(() => LoginSignUp());
      return null!;
    } else {
      throw Exception('Failed to load attendanceCourse list');
    }
  }

  static Future<GuestUserModal?> fetchGuestUser() async {
    final url = Uri.parse('${baseUrl}home/getGuestuserHomeDashboard');

    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
// Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GuestUserModal.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<getGroupedEnrollmentByAttendanceTutee?>
      fetchTutteAttendanceList(
          String batchId, String selectedDate, selectedMonth) async {
    final url =
        Uri.parse('${baseUrl}attendane/getGroupedEnrollmentByAttendanceTutee');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var data = {
      "date": selectedDate,
      "batchId": batchId,
      "month": selectedMonth,
      "fromDate": '',
      "toDate": ''
    };
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
       Logger().i(result);
      return getGroupedEnrollmentByAttendanceTutee.fromJson(result);
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<getEnquiryListModel> fetchEnquireList(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}attendane/getEnquiryList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
      Logger().i("getting val;uegegbjhgsdfjs");
      throw Exception('Failed to load Enquir list');
    }
  }

  static Future<UpdateEnquiryStatusModel?> updateEnquire(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}attendane/updateEnquiryStatus"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        return UpdateEnquiryStatusModel.fromJson(json.decode(response.body));
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
    final token = prefs.getString('Token') ?? "";

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

  static Future<getNotificationsModel> getNotifications(
      Map<String, dynamic> notificationData) async {
    final url = Uri.parse('${baseUrl}home/getNotifications');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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

  static Future<getMarkNotificationAsReadModel> FetchMarkedNotification(
      Map<String, dynamic> notificationData) async {
    final url = Uri.parse('${baseUrl}home/markNotificationAsRead');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(notificationData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getMarkNotificationAsReadModel
          .fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Notification list');
    }
  }

  static Future<addEnrollmentDataModel> addEnrollment(
      Map<String, dynamic> enrollmentData) async {
    final url = Uri.parse('${baseUrl}attendane/submitEnrollment');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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


  static Future<GetEnrollmentModel?> getEnrollment(
      Map<String, dynamic> batchData) async {
    try {
      final url = Uri.parse('${baseUrl}attendane/getEnrollment');
      final box = GetStorage(); // Get an instance of GetStorage
      // Retrieve the token from storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token') ?? "";
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

  static Future<UpdateEnrollmentStatusModel?> updateEnrollment(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}attendane/updateEnrollment"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        return UpdateEnrollmentStatusModel.fromJson(json.decode(response.body));
      } else {
        var result =
            UpdateEnrollmentStatusModel.fromJson(json.decode(response.body));
        Get.snackbar(
          '',
          icon: const Icon(Icons.info, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
          messageText: SizedBox(
            height: 30, // Set desired height here
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0,),
              child: Center(
                child: Text(
                  result.message.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        )
        );
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<ValidateTokenModel?> validateToken() async {
    final url = Uri.parse(
        "${baseUrl}user/validToken"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rolename = prefs.getString('Rolename') ?? '';
    final token = rolename == 'Parent'
        ? prefs.getString('PrentToken') ?? ""
        : prefs.getString('Token') ?? "";
    Logger().d("${rolename}message");
    Logger().d("${token}message");
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
        return ValidateTokenModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      Logger().e(e);
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
    try {
      final url = Uri.parse('${baseUrl}home/getHomeDashboardTutor');
      final box = GetStorage(); // Get an instance of GetStorage
      // Retrieve the token from storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token') ?? "";
      Logger().d("$token");
      final response = await http.post(
        url, // Replace with the actual API URL
        headers: {
          'Authorization': 'Bearer $token', // Add the authorization token here
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Logger().i("200yhasuvsagvfdsfjsfvd");
        return getHomeDashboardTutorModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load dashboard list');
      }
    } catch (e) {
      Logger().e(e);
      throw e;
    }
  }

  static Future<GetHomeDashboardParentModel>
      fetchHomeDashboardParentList() async {
    try {
      final url = Uri.parse('${baseUrl}home/getHomeDashboardTutor');
      final box = GetStorage(); // Get an instance of GetStorage
      // Retrieve the token from storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token') ?? "";
      Logger().d("$token");
      final response = await http.post(
        url, // Replace with the actual API URL
        headers: {
          'Authorization': 'Bearer $token', // Add the authorization token here
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Logger().i("200yhasuvsagvfdsfjsfvd");
        return GetHomeDashboardParentModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load dashboard list');
      }
    } catch (e) {
      Logger().e(e);
      throw e;
    }
  }

  static Future<getdashboardYearflowModel?> fetchHomeAttendanceList(
      String batchId) async {
    final url = Uri.parse('${baseUrl}attendane/dashboardYearflow');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
    } else if (response.statusCode == 401) {
      // Clear session data
      await prefs.clear();
      // Navigate to the login screen
      Get.to(() => LoginSignUp());
      return null;
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<deleteBatchDataModel> deleteBatch(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}batch/deleteBatch');

    // Retrieve the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";

    final response = await http.post(
      url,
      body: json.encode(batchData),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return deleteBatchDataModel.fromJson(json.decode(response.body));
    } else {
      var result = deleteBatchDataModel.fromJson(json.decode(response.body));
      Get.snackbar(
        '',
        icon: const Icon(Icons.info, color: Colors.white, size: 40),
        colorText: Colors.white,
        backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
        shouldIconPulse: false,
        messageText: SizedBox(
            height: 30, // Set desired height here
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0,),
              child: Center(
                child: Text(
                  result.message.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        )
      );
      // Either return a default instance or throw an error
      return deleteBatchDataModel(message: result.message);
    }
  }

  static Future<deleteBatchDataModel> deleteCourse(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}course/deleteCourse');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
      var result = deleteBatchDataModel.fromJson(json.decode(response.body));
      // Get.snackbar(result.message.toString());
      throw Exception(result.message.toString());
    }
  }

  static Future<getUserTokenListModel?> getUserTokenList(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}user/getUserTokenList"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final rolename = prefs.getString('Rolename') ?? "";
    final parentToken = prefs.getString('PrentToken') ?? "";
    String lastToken = "";
    if (rolename == 'Parent') {
      lastToken = parentToken;
    } else {
      lastToken = token;
    }
    // final token = prefs.getString('Token') ?? "";
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $lastToken',
        },
      );
      if (response.statusCode == 200) {
        return getUserTokenListModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getHolidayDataModel> fetchHoliDataList(
      String searchitems) async {
    final url = Uri.parse('${baseUrl}tutor/getHoliday');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
      return getHolidayDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load batch list');
    }
  }

  static Future<GetparentBatchLocation?> fetchBatchLocation(
      String batchId) async {
    final url = Uri.parse('${baseUrl}home/parentBatchLocation');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
      return GetparentBatchLocation.fromJson(result);
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<AddHolidayModel?> addHoliday(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}tutor/addHoliday"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        return AddHolidayModel.fromJson(json.decode(response.body));
      } else {
        var result = AddHolidayModel.fromJson(json.decode(response.body));
        Get.snackbar(
          '',
          icon: const Icon(Icons.info, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
          messageText: SizedBox(
            height: 30, // Set desired height here
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0,),
              child: Center(
                child: Text(
                  result.message.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        )
        );
        // Either return a default instance or throw an error
        return AddHolidayModel(message: result.message);
      }
    } catch (e) {
      return null;
    }
  }

  static Future<deleteHolidayModel> deleteHoliday(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}tutor/addHoliday');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(batchData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return deleteHolidayModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Notification list');
    }
  }

  static Future<getMspModel> fetchMSPDataList(String searchitems) async {
    final url = Uri.parse('${baseUrl}tutor/getMsp');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var data = {"searchKey": searchitems};
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(data),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );
    print(token);
    if (response.statusCode == 200) {
      return getMspModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load batch list');
    }
  }

  static Future<addMspModel?> addMSP(Map<String, dynamic> batchData) async {
    final url =
        Uri.parse("${baseUrl}tutor/addMsp"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        return addMspModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getLeaveListModel> fetchLeaveList(String searchitems) async {
    final url = Uri.parse('${baseUrl}leave/getLeaveList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
      return getLeaveListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load batch list');
    }
  }

  static Future<submitLeaveModel?> addLeave(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}leave/submitLeave"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        return submitLeaveModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getGroupedLeaveByBatch?>
      fetchGroupedEnrollmentLeaveByBatch() async {
    final url = Uri.parse('${baseUrl}leave/getGroupedLeaveByBatch');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
      return getGroupedLeaveByBatch.fromJson(result);
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<deleteBatchDataModel> deleteLeave(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}leave/submitLeave');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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

  static Future<updateLeaveModel?> updateLeave(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}leave/updateLeave"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        return updateLeaveModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getAnnouncementBatchListModel>
      fetchAnnounmentsBatchList() async {
    final url = Uri.parse('${baseUrl}home/getAnnouncementBatchList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";

    final reponse = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );
    if (reponse.statusCode == 200) {
      return getAnnouncementBatchListModel.fromJson(json.decode(reponse.body));
    } else {
      throw Exception('Failed to load course list');
      //  throw Exception('Failed to fetch course category list');
    }
  }

  static Future<getAnnouncementModel> fetchAnnounmentsList(
      String searchitems) async {
    final url = Uri.parse('$baseUrl/home/getGroupedAnnouncement');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
      return getAnnouncementModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load course list');
    }
  }

  static Future<getHolidayDataModel> fetchHoliDataTuteeList(
      String searchitems) async {
    final url = Uri.parse('${baseUrl}tutor/getHolidayTuteeList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
      return getHolidayDataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load batch list');
    }
  }

  static Future<addAnnouncementModel?> addAnnoument(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}home/addAnnouncement"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        return addAnnouncementModel.fromJson(json.decode(response.body));
      } else {
        var result = addAnnouncementModel.fromJson(json.decode(response.body));
        Get.snackbar(
          '',
          icon: const Icon(Icons.info, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
          messageText: SizedBox(
            height: 30, // Set desired height here
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0,),
              child: Center(
                child: Text(
                  result.message.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        )
        );
        // Either return a default instance or throw an error
        return addAnnouncementModel(message: result.message);
      }
    } catch (e) {
      return null;
    }
  }

  static Future<parentLoginModal?> parentLogin(
      String identifiers, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token') ?? "";
      final rolename = prefs.getString('Rolename') ?? "";
      final parentToken = prefs.getString('PrentToken') ?? "";
      String lastToken = "";
      if (rolename == 'Parent') {
        lastToken = parentToken;
      } else {
        lastToken = token;
      }
      // final token = prefs.getString('PrentToken') ?? "";
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $lastToken',
      };
      var data = {"phone_number": identifiers};
      var url = Uri.parse("${baseUrl}user/generateInvitationLink");

      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().i(response.bodyBytes);
      Logger().i(response.body);
      Logger().i("gEDGMmbpkoWDRB $token");
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return parentLoginModal.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  static Future<validateAndLoginParentModal?> otpParent(
      String otp, String accountverificationtoken, BuildContext context) async {
    try {
      var headers = {'Content-Type': 'application/json'};

      var data = {"encryptedCode": accountverificationtoken, "inputCode": otp};
      Logger().i(data);

      var url = Uri.parse("${baseUrl}user/validateAndLoginParent");
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().i(response.body);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return validateAndLoginParentModal.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<RegisterParentModel?> RegisterParent({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String dob,
    required String phNo,
    required String pincode,
    required String latitude,
    required String longitude,
    required String country,
    required String state,
    required String city,
    required String street,
    required String doorNo,
    required String idProof
  }) async {
    try {
      DateTime parsedDate1 = DateFormat('dd-MM-yyyy').parse(dob);
      String formattedDate1 = DateFormat('dd/MM/yyyy').format(parsedDate1);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token') ?? "";
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      Logger().i("fafgnkanfgaklj ${token ?? ''}");
      var data = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "dob": formattedDate1,
        "phone_number": phNo,
        "pincode": pincode,
        "longitude": longitude,
        "latitude": latitude,
        "country": country,
        "state": state,
        "city": city,
        "street": street,
        "door_no": doorNo,
        "id_proof_label": idProof,
      };

      var url = Uri.parse("${baseUrl}user/registerParent");
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return RegisterParentModel.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showErrorSnackBar(
          context,
          "${result["message"]}",
        );
        return null;
      }
    } catch (e) {
      SnackBarUtils.showErrorSnackBar(context, "An error occurred.");
      return null;
    }
  }

  static Future<getParentInviteCodeModel?> getParentInviteCode(
      String identifiers) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token') ?? "";
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var data = {"phone_number": identifiers};
      var url = Uri.parse("${baseUrl}user/getParentInviteCode");

      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().i(response.bodyBytes);
      Logger().i(response.body);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return getParentInviteCodeModel.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        // SnackBarUtils.showSuccessSnackBar(
        //   context,
        //   "${result["message"]}",
        // );
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<UpdateParentStausModel?> updateParentStatus(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}user/updateParentStaus"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('PrentToken') ?? "";
    print(token);
    try {
      final response = await http.post(
        url,
        body: jsonEncode(batchData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return UpdateParentStausModel.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  static Future<DeleteAnnouncementModel> deleteAnnouncement(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}home/addAnnouncement');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(batchData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return DeleteAnnouncementModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Notification list');
    }
  }

  static Future<GetRatingsListModel?> updateSelectedSubcategories(
      Map<String, dynamic> batchData) async {
    try {
      final url = Uri.parse('${baseUrl}rating/getRatingsList');
      final box = GetStorage(); // Get an instance of GetStorage
      // Retrieve the token from storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token') ?? "";
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
        return GetRatingsListModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Enquir list');
      }
    } catch (e) {
      return null;
    }
  }

  static Future<int> submitRatings(
      BuildContext context,
      String tutorId,
      String batchId,
      String courseId,
      String star,
      List<String> subCategoryId,
      String? reviews) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('Token')}'
    };
    var data = json.encode({
      "type": "N",
      "tutorId": tutorId,
      "batchId": batchId,
      "courseId": courseId,
      "star": star,
      "details": subCategoryId,
      "comments": reviews
    });

    print("data===getting as payload====>$data");

    try {
      final response = await http.post(
          Uri.parse('${baseUrl}rating/addUserRatings'),
          body: data,
          headers: headers);
      print('response================>${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // SnackBarUtils.showSuccessSnackBar(
        //     context, '${responseData["message"]}');
        return response.statusCode;
      } else {
        print('response================error');
        final Map<String, dynamic> responseData = json.decode(response.body);
        SnackBarUtils.showErrorSnackBar(context, '${responseData["message"]}');

        throw Exception("error");
      }
    } catch (e) {
      print(e);
      throw Exception("$e");
    }
  }

  //   static Future<GetRatingTutorListModel> getRatings( Map<String, dynamic> batchData) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var headers = {'Authorization': 'Bearer ${prefs.getString('Token')}'};
  //   print('response================>${headers}');

  //   try {
  //     final response = await http.post(Uri.parse('${baseUrl}rating/getRatingTutorList'),
  //      body: json.encode(batchData),
  //         headers: headers);

  //     if (response.statusCode == 200) {
  //       print('response================>${response.body}');
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       return GetRatingTutorListModel.fromJson(responseData);
  //     } else {
  //       print('response================error');
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       //  SnackBarUtils.showErrorSnackBar(context, '${responseData["message"]}');
  //       throw Exception("error");
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw Exception("$e");
  //   }
  // }
  static Future<GetRatingTutorListModel?> getRatings(
      Map<String, dynamic> batchData) async {
    try {
      final url = Uri.parse('${baseUrl}rating/getRatingTutorList');
      final box = GetStorage(); // Get an instance of GetStorage
      // Retrieve the token from storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token') ?? "";
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
        return GetRatingTutorListModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load Enquir list');
      }
    } catch (e) {
      return null;
    }
  }

  static Future<GetRatingDashboardListModel?> getMyRatings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {'Authorization': 'Bearer ${prefs.getString('Token')}'};
    print('response================>${headers}');

    try {
      final response = await http.post(
          Uri.parse('${baseUrl}rating/getRatingDashboardList'),
          headers: headers);

      if (response.statusCode == 200) {
        print('response================>${response.body}');
        final Map<String, dynamic> responseData = json.decode(response.body);
        return GetRatingDashboardListModel.fromJson(responseData);
      } else {
        print('response================error');
        final Map<String, dynamic> responseData = json.decode(response.body);
        //  SnackBarUtils.showErrorSnackBar(context, '${responseData["message"]}');
        // throw Exception("error");
        return null;
      }
    } catch (e) {
      // print(e);
      // throw Exception("$e");
      Logger().e(e);
      return null;
    }
  }

  static Future<GoogleSignInModel?> googleSignIn(
      String idToken, String type, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Content-Type': 'application/json'};
      var data = {"idToken": idToken, "type": type};
      Logger().i(data);

      var url = Uri.parse("${baseUrl}user/googleSignIn");
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().i(response.body);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return GoogleSignInModel.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );

        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<PhoneNumberVerifiedModel?> phoneNumberVerified(
      String identifiers, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString('Token')}',
        'Content-Type': 'application/json'
      };
      var data = {"phone_number": identifiers};
      var url = Uri.parse("${baseUrl}user/phoneNumberVerified");
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().i(response.bodyBytes);
      Logger().i(response.body);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return PhoneNumberVerifiedModel.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<GetBannerListModel?> fetchGuestUserBannerList() async {
    final url = Uri.parse('${baseUrl}guest/getBannerList');

    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
// Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GetBannerListModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<GetTestimonialsModel?> fetchGuestUserTestimonialsList() async {
    final url = Uri.parse('${baseUrl}guest/getTestimonials');

    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
// Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GetTestimonialsModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<GetGroupedEnrollmentByHostelModel?>
      fetchGroupedEnrollmentByHostel() async {
    final url =
        Uri.parse('${baseUrl}hostel_attendance/getGroupedEnrollmentByHostel');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
      return GetGroupedEnrollmentByHostelModel.fromJson(result);
    } else if (response.statusCode == 401) {
      // Clear session data
      await prefs.clear();
      // Navigate to the login screen
      Get.to(() => LoginSignUp());
      return null;
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<List<String>> fetchHostelcategory() async {
    final url = Uri.parse('${baseUrl}hostel/getHostelCategoryList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";

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

  static Future<GetHostelFilterListModel?> getHostelFilterListfetch(
      String type, searchTerm) async {
    final url = Uri.parse('${baseUrl}hostel/getHostelFilterList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var data = {"category": [], 
     "maxDistance": "",
    "price_min": "",
    "price_max": "",
    "searchKey": searchTerm,
    "userLatitude": prefs.getDouble('latitude'),
    "userLongitude": prefs.getDouble('longitude'),
    "pincode": "",
    "low_to_high": "",
    "high_to_low": ""};
    try {
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return GetHostelFilterListModel.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
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
    final token = prefs.getString('Token') ?? "";
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

  static Future<GetHostelEnquiryListModel> fetchHostelEnquireList(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}hostel/enquiry/getHostelEnquiryList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(batchData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GetHostelEnquiryListModel.fromJson(json.decode(response.body));
    } else {
      Logger().i("getting val;uegegbjhgsdfjs");
      throw Exception('Failed to load Enquir list');
    }
  }

  static Future<GetHostelEnrollmentListModel?> getHostelEnrollment(
      Map<String, dynamic> batchData) async {
    try {
      final url = Uri.parse('${baseUrl}hostel/enquiry/getEnrollment');
      final box = GetStorage(); // Get an instance of GetStorage
      // Retrieve the token from storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token') ?? "";
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
        return GetHostelEnrollmentListModel.fromJson(
            json.decode(response.body));
      } else {
        throw Exception('Failed to load Enquir list');
      }
    } catch (e) {
      return null;
    }
  }

  static Future<GetGroupedEnrollmentByAttendanceModel?>
      fetchgetGroupedEnrollmentByAttendance(
          String batchId, String selectedDate, selectedMonth, type,fromDate,toDate) async {
    final url = Uri.parse(
        '${baseUrl}hostel_attendance/getHostelAttendance');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var data = {
      //"date": selectedDate,
      "hostelId": batchId,
      //"month": selectedMonth,
      "fromDate": fromDate,
      "toDate": toDate,
      "roleType": type
    };
    print(data);
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
      Logger().i(result);
      return GetGroupedEnrollmentByAttendanceModel.fromJson(result);
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

  static Future<List<String>> fetchHostelNotificationsType() async {
    final url = Uri.parse('${baseUrl}hostelNotification/getNotificationsType');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";

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

  static Future<GetEnrollmentDataModel> fetchHomeDashboardHostelList() async {
     try {
      final url = Uri.parse('${baseUrl}hostel_attendance/getHomeDashboardTutor');
      final box = GetStorage(); // Get an instance of GetStorage
      // Retrieve the token from storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('Token') ?? "";
      Logger().d("$token");
      final response = await http.post(
        url, // Replace with the actual API URL
        headers: {
          'Authorization': 'Bearer $token', // Add the authorization token here
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Logger().i("200yhasuvsagvfdsfjsfvd");
        return GetEnrollmentDataModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load dashboard list');
      }
    } catch (e) {
      Logger().e(e);
      throw e;
    }
  }

   static Future<getNotificationsModel> getNotificationsHostel(
      Map<String, dynamic> notificationData) async {
    final url = Uri.parse('${baseUrl}hostelNotification/getNotifications');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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

  static Future<GetGroupedAnnouncementHostelModel> fetchHostelAnnounmentsList(
      String searchitems) async {
    final url = Uri.parse('$baseUrl/hostel/getGroupedAnnouncement');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var data = {"search": searchitems};
    final response = await http.post(
      url, // Replace with the actual API URL
      body: jsonEncode(data),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GetGroupedAnnouncementHostelModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load course list');
    }
  }

  static Future<getAttendancePunchInModel?> getHostelAttendancePunchIn(
      String hostelId, String hostelObjId, BuildContext context) async {
    Logger().d("api calling");
    final url = Uri.parse('${baseUrl}hostel_attendance/HostelPunchIn');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var data = {"hostelId": hostelId, "hostel_ObjectId": hostelObjId};
    Logger().d("api calling ==>${token}");
    Logger().d("api calling ==>${data}");
    try {
      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);
      Logger().d(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return getAttendancePunchInModel.fromJson(result);
      } else {
        Logger().d(response.reasonPhrase);
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  static Future<getAttendancePunchInModel?> getHostelAttendancePunchOut(
      BuildContext context, String hostelId,hostelObjId) async {
    final url = Uri.parse('${baseUrl}hostel_attendance/HostelPunchOut');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = {"hostelId": hostelId, "hostel_ObjectId": hostelObjId};
    final token = prefs.getString('Token') ?? "";
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return getAttendancePunchInModel.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        SnackBarUtils.showSuccessSnackBar(
          context,
          "${result["message"]}",
        );
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getMarkNotificationAsReadModel> FetchMarkedNotificationHostel(
      Map<String, dynamic> notificationData) async {
    final url = Uri.parse('${baseUrl}hostelNotification/markNotificationAsRead');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(notificationData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getMarkNotificationAsReadModel
          .fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Notification list');
    }
  }

  static Future<UpdateEnrollmentStatusModel?> updateEnrollmentHostel(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse(
        "${baseUrl}hostel/enquiry/updateEnrollment"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        return UpdateEnrollmentStatusModel.fromJson(json.decode(response.body));
      } else {
        var result =
            UpdateEnrollmentStatusModel.fromJson(json.decode(response.body));
        Get.snackbar(
          '',
          icon: const Icon(Icons.info, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
          messageText: SizedBox(
            height: 30, // Set desired height here
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0,),
              child: Center(
                child: Text(
                  result.message.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        );
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<getQrcodeModel> fetchHostelQrCode(String hostelId) async {
    final url = Uri.parse('${baseUrl}hostel_attendance/getQrcode');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var data = {"hostelId": hostelId};
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return getQrcodeModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      // Clear session data
      await prefs.clear();
      // Navigate to the login screen
      Get.to(() => LoginSignUp());
      return null!;
    } else {
      throw Exception('Failed to load attendanceCourse list');
    }
  }

  static Future<GetMspHostelModel> fetchHostelMSPDataList(String searchitems) async {
    final url = Uri.parse('${baseUrl}hostel/leave/getMsp');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    var data = {"searchKey": searchitems};
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(data),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );
    print(token);
    if (response.statusCode == 200) {
      return GetMspHostelModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load batch list');
    }
  }

  static Future<addMspModel?> addMSPHostel(Map<String, dynamic> batchData) async {
    final url =
        Uri.parse("${baseUrl}hostel/leave/addMsp"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
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
        return addMspModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<FetchGuestUserHostelListModel?> fetchGuestUserHostelList() async {
    final url = Uri.parse('${baseUrl}admin/userManagement/hostelAllList');
    var data = {"type": "Hostel"};
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
// Add the authorization token here
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return FetchGuestUserHostelListModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
  
  static Future<GetSubscriptionModel?> getSubscription(Map<String, dynamic> batchData) async {
    final url =
        Uri.parse("${baseUrl}guest/getSubscription"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return GetSubscriptionModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }



  static Future<GetSubscriptionByPlanModel?> getSubscriptionByPlan(Map<String, dynamic> batchData) async {
    final url =
        Uri.parse("${baseUrl}guest/getSubscriptionByPlan"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
          //'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return GetSubscriptionByPlanModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }


 static Future<Mypayments?> getMyPayments() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";

    try {
            var headers = {'Authorization': "Bearer $token"};
      var url = Uri.parse("${baseUrl}mysubscription/getallsubscription"); //?page=1&limit=3&status=1
      var response = await http.get(url, headers: headers);
       if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Mypayments.fromJson(data);
      }else{
        return null;
      }
      
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
      
    }
   

 }

  static Future<GetcurrentsubscriptionModel?> getcurrentsubscription() async {
    final box = GetStorage(); // Get an instance of GetStorage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    try {
      var headers = {'Authorization': "Bearer $token"};
      var url = Uri.parse("${baseUrl}mysubscription/getcurrentsubscription");
      var response = await http.get(url, headers: headers);
      Logger().i(response.headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return GetcurrentsubscriptionModel.fromJson(data);
      } else if (response.statusCode == 401) {
        // Clear session data
        await prefs.clear();
        // Navigate to the login screen
       // Get.to(() => LoginSignUp());
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<InstitudeTutorsListModel?> fetchGuestUserInstitudeTutorsList() async {
    final url = Uri.parse('${baseUrl}admin/userManagement/institudeTutorsList');
    var data = {"type": "Hostel"};
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
// Add the authorization token here
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return InstitudeTutorsListModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }


   static Future<PostPaymentModel?> postPayment(Map<String, dynamic> data) async {
    final url = Uri.parse('${baseUrl}mysubscription/updatesubscription');
      SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
// Add the authorization token here
         'Content-Type': 'application/json',
         'Authorization': "Bearer $token",
      },
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      return PostPaymentModel.fromJson(json.decode(response.body));
    } else {
      
      return null;
    }
// var headers = {
//   'Content-Type': 'application/json',
//   'Authorization': "Bearer $token",
// };
// var request = http.Request('POST', Uri.parse('https://api.hoveeattendance.com/dev/api/mysubscription/updatesubscription'));
// request.body = json.encode(data);
// request.headers.addAll(headers);

// http.StreamedResponse response = await request.send();

// if (response.statusCode == 200) {
//   print(await response.stream.bytesToString());
// }
// else {
//   print(response.reasonPhrase);
//   }
}

 static Future<GetsubscriptionPdfModel> getsubscriptionPdfInvoice(String id) async {
    final url = Uri.parse('${baseUrl}mysubscription/getsubscription/${id}');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final response = await http.get(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );
    print(token);
    if (response.statusCode == 200) {
      return GetsubscriptionPdfModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load batch list');
    }
  }

   static Future<GuestsearchModel?> fetchGuestUserSearch( Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}guest/search');
    final response = await http.post(
      url, // Replace with the actual API URL
      body: json.encode(batchData),
      headers: {
// Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return GuestsearchModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

    static Future<GetBatchtuteelistModel?> fetchBatchTuteeList(
      Map<String, dynamic> batchData) async {
    final url = Uri.parse('${baseUrl}guest/getBatchtuteelist');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final response = await http.post(
      url, // Replace with the actual API URL
      body: jsonEncode(batchData),
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );
    print(token);
    if (response.statusCode == 200) {
      return GetBatchtuteelistModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load batch list');
    }
  }

    static Future<GetHostelAttendanceCalendarReportModel?>
      getHostelAttendanceCalendarReport(
          String batchId, String selectedDate, selectedMonth, type,fromDate, toDate) async {
    final url = Uri.parse(
        '${baseUrl}hostel_attendance/getHostelAttendanceCalendarReport');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    final rolename = prefs.getString('Rolename') ?? "";
    var data = {
      //"date": selectedDate,
      "hostelId": batchId,
      //"month": selectedMonth,
      "fromDate": fromDate,
      "toDate": toDate,
      "roleType": rolename
    };
    print(data);
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
      Logger().i(result);
      return GetHostelAttendanceCalendarReportModel.fromJson(result);
    } else {
      Map<String, dynamic> result = jsonDecode(response.body);
      // SnackBarUtils.showErrorSnackBar(context, "${result["message"]}");
      return null;
    }
  }

}
