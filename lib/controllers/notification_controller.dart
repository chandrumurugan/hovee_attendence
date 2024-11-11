import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getNotification_model.dart';
import 'package:hovee_attendence/modals/getmarkedNotification_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var categories =<String>[].obs;
  var selectedIndex = 0.obs;
  var notificationList =[].obs;
 var  notificationData
 = getMarkNotificationAsReadModel().data.obs;
  final UserProfileController controller =
      Get.put(UserProfileController());

       String? role;

  @override
  void onInit() {
    super.onInit();
    // Initialize TabController with three tabs
    fetchNotificationsType();
    
  }

  void fetchNotificationsType() async {
    isLoading(true);

    var response = await WebService.fetchNotificationsType();

    if (response.isNotEmpty) {
      categories.value= response;
      isLoading(false); 
       final storage = GetStorage();
      role =storage.read('role');
      filteredNotifications('Enquiry',role!,false);
    } else {
      isLoading(false);
    }
  }

 

  void filteredNotifications(String type, String role, bool isRead) async {
    isLoading(true);
    var batchData = {"role": role, "type": type, "isRead ": false};
    var response = await WebService.getNotifications(batchData);
    if (response != null && response!.statusCode == 200) {
      notificationList.value =response.data!;
      isLoading(false);
    } else {
      notificationList.clear();
      isLoading(false);
    }
  }

    void fetchMarkedNotification(String notificationId,String type,String msgtype) async {
    isLoading(true);
    var batchData = {"notificationId": notificationId,};
    var response = await WebService.FetchMarkedNotification(batchData);
    if (response != null && response.statusCode == 200) {
      notificationData.value =response.data!;
      isLoading(false);
      if(msgtype=='Enquiry'){
         Get.to(()=> Tutorenquirlist(type:role!));
      }
      
    } else {
      notificationList.clear();
      isLoading(false);
    }
  }


    void setSelectedIndex(int index) {
    selectedIndex.value = index; // Update selected index
  }

}
