import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/config/appConfig.dart';
import 'package:hovee_attendence/modals/addbatch_model.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/getCouseList_model.dart';
import 'package:hovee_attendence/modals/getbatchlist_model.dart';
import 'package:hovee_attendence/modals/loginModal.dart';
import 'package:hovee_attendence/modals/otpModal.dart';
import 'package:hovee_attendence/modals/regiasterModal.dart';
import 'package:hovee_attendence/modals/role_modal.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

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
        print("Failed to load app config");
        return null;
      }
    } catch (e) {
      print("Error in fetching app config: $e");
      return null;
    }
  }

  static Future<LoginModal?> login(String identifiers,BuildContext context) async {
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
        SnackBarUtils.showErrorSnackBar(context,"${result["message"]}");
        print("Failed to load login");
        return null;
      }
    } catch (e) {
      print("Error in fetching login: $e");
      return null;
    }
  }

  static Future<RegisterModal?> Register(
      {required BuildContext context,
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
        SnackBarUtils.showErrorSnackBar(context,"${result["message"]}");

        return null;
      }
    } catch (e) {
      print("Error in fetching register: $e");
      return null;
    }
  }

  static Future<OtpModal?> otp(
      String otp, String accountverificationtoken,BuildContext context) async {
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
        SnackBarUtils.showErrorSnackBar(context,"${result["message"]}");

        return null;
      }
    } catch (e) {
      print("Error in fetching login: $e");
      return null;
    }
  }

  static Future<AddBatchDataModel?> addBatch(Map<String, dynamic> batchData) async {
    final url = Uri.parse("${baseUrl}batch/addBatch"); // Replace with the actual endpoint
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    final token = box.read('Token') ?? '';
    try {
      final response = await http.post(
        url,
        body: json.encode(batchData),
        headers: {
          'Content-Type': 'application/json',
           'Authorization': 'Bearer $token',
        },
      );
        print(response.body);
      if (response.statusCode == 200) {
        return AddBatchDataModel.fromJson(json.decode(response.body));
      } else {
        print('Failed to add batch: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error adding batch: $e');
      return null;
    }
  }

   static Future<getBatchListModel> fetchBatchList() async {
    final url = Uri.parse('${baseUrl}batch/getBatchList');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    final token = box.read('Token') ?? '';
    print(token);
    final response = await http.post(
      url, // Replace with the actual API URL
      headers: {
        'Authorization': 'Bearer $token', // Add the authorization token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return getBatchListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load batch list');
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
      print(e);
      return null;
    }
  }

  static Future<GetCourseDataModel> fetchCourseList() async {
    final url = Uri.parse('$baseUrl/course/getCourse');
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    final token = box.read('Token') ?? '';
    final response = await http.post(
      url, // Replace with the actual API URL
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
  }) async {
    var headers = {
      'Authorization': 'Bearer $token', // Pass the token for authorization
      'Content-Type': 'application/json'
    };

    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}user/accountSetup'));

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
}
