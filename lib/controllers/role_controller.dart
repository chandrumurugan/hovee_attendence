import 'package:get/get.dart';
import 'package:hovee_attendence/modals/role_modal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:logger/logger.dart';

class RoleController extends GetxController {
  var roles = <Role>[].obs;
  var roleTypes = <RoleType>[].obs;
  var selectedRole = ''.obs;
  var selectedRoleType = ''.obs;
  

  WebService webService = WebService();

  @override
  void onInit() {
    fetchRoles();
    super.onInit();
  }

  void fetchRoles() async {
    try {
      List<Role>? fetchedRoles = await WebService.getRoles();
      if(fetchedRoles != null){
    roles.value = fetchedRoles;     
      }
     
    } catch (e) {
      // Handle errors
      print("Error fetching roles: $e");
    }
  }

  void setSelectedRole(String roleId) {
    selectedRole.value = roleId;
    selectedRole.value;
      var selectedRoleData = roles.firstWhere((role) => role.id == roleId);
  if (selectedRoleData.roleTypes.isNotEmpty) {
    // Update the role types list based on selected role
    roleTypes.value = selectedRoleData.roleTypes;
    
  } else {
    roleTypes.clear(); // Clear if no role types
  }
    // update();
    // onInit();
      print('Selected role ID: ${selectedRole.value}');
  }

  void setSelectedRoleType(String roleTypeId) {
    selectedRoleType.value = roleTypeId;

  // update();
  
  }
}
