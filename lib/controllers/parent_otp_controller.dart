import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/modals/parentLoginDataModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentOtpController extends GetxController {
var deepLink =''.obs;
 var code =''.obs;

 var isLoading = false.obs;

 final SplashController parentController = Get.put(SplashController(parentId: '', phoneNumber: ''));
 

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getValidateLink(Get.arguments['phoneNumber'] ?? '');
  }

  
void getValidateLink(String identifiers) async {
              var parentresponse = await WebService.getParentInviteCode(identifiers);
        if (parentresponse != null) {
            deepLink.value=parentresponse.data!.invitationLink!;
           code.value= parentresponse.data!.parentCode!;
          //  prefs.setString('deepLink',parentresponse.data!.invitationLink!);
          //   prefs.setString('OtpCode',parentresponse.data!.parentCode!);
          //   code.value =prefs.getString('OtpCode')??'';
          //   prefs.setString('Token','');
          //   print(' ${prefs.setString('deepLink',parentresponse.data!.invitationLink!)}');
             print(' ${code.value}');
         //print(code);
           print(deepLink);
        } else {
          Logger().e('Failed to load AppConfig');
          isLoading.value = false;
        }
  }

  
}