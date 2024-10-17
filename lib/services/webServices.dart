import 'package:get/get.dart';
import 'package:hovee_attendence/config/appConfig.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/loginModal.dart';
import 'package:hovee_attendence/modals/otpModal.dart';
import 'package:hovee_attendence/modals/regiasterModal.dart';
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

  static Future<LoginModal?> login(String identifiers) async {
    try {
       var headers = {'Content-Type': 'application/json'};
      var data = {"identifier": identifiers};
      var url = Uri.parse("${baseUrl}user/auth/login");
      var response = await http.post(url, body: jsonEncode(data),headers:headers );
         Logger().i(response.bodyBytes);
      Logger().i(response.body);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return LoginModal.fromJson(result);
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        Get.snackbar("Error", "${result["message"]}");
        print("Failed to load login");
        return null;
      }
    } catch (e) {
      print("Error in fetching login: $e");
      return null;
    }
  }

  static Future<RegisterModal?> Register(
      {required String firstName,
      required String lastName,
      required String email,
      required String dob,
      required String phNo,
      required String pincode,
      required String idProof}) async {
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
        Get.snackbar("Error", "${result["message"]}");

        return null;
      }
    } catch (e) {
      print("Error in fetching register: $e");
      return null;
    }
  }

  static Future<OtpModal?> otp(
      String otp, String accountverificationtoken) async {
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
        Get.snackbar("", "${result["message"]}");

        return null;
      }
    } catch (e) {
      print("Error in fetching login: $e");
      return null;
    }
  }
}
