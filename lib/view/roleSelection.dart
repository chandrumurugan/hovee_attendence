import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/accountSetup_controller.dart';
import 'package:hovee_attendence/controllers/role_controller.dart';
import 'package:hovee_attendence/modals/role_modal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/accountsetup_screen.dart';
import 'package:hovee_attendence/view/dashBoard.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({Key? key}) : super(key: key);

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  final RoleController roleController = Get.put(RoleController());
   final splashController = Get.find<AccountSetupController>();

  String? selectedRoleId, selectedRole, selectedRoleTypeName;
  String? selectedRoleTypeId;
  List<Role>? roles;
  List<RoleType> roleTypes = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRoles();
  }

  void fetchRoles() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<Role>? fetchedRoles = await WebService.getRoles();
      if (fetchedRoles != null) {
        setState(() {
          roles = fetchedRoles;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching roles: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return await splashController.handleBackButton(context);
      },
      child: Scaffold(
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFC13584),
                          Color(0xFF833AB4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Image.asset(
                        //   'assets/appConstantImg/colorlogoword.png',
                        //   height: 30,
                        // ),
                        SizedBox(
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              const Text(
                                'hovee',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 28,
                                ),
                              ),
                              Positioned(
                                bottom: 22, // Adjust this value as needed
                                left: 70, // Align with the start of "hovee"
                                child: Text(
                                  'e-attendance',
                                  style: GoogleFonts.nunito(
                                      fontSize: 18.0, color: Color(0xffFFA012)),
                                ),
                              ),
                            ],
                          ),
                        ),
      
                        const Text(
                          'Select your role',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 24),
                        ),
                        // Roles ListView.builder
                        Card(
                          elevation: 20,
                          shadowColor: Colors.black,
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 8),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: roles?.length ?? 0,
                              itemBuilder: (context, index) {
                                var role = roles![index];
                                bool isSelected = selectedRoleId == role.id &&
                                    selectedRole == role.roleName;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRoleId = role.id;
                                      roleTypes = role.roleTypes;
                                      selectedRoleTypeId = null;
                                      selectedRoleTypeName =
                                          null; // Reset selected role type
                                      selectedRole = role.roleName;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Card(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          gradient: isSelected
                                              ? const LinearGradient(
                                                  colors: [
                                                    Color(0xFFBA0161),
                                                    Color(0xFF510270),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                )
                                              : null,
                                        ),
                                        child: Center(
                                          child: Text(
                                            role.roleName,
                                            style: GoogleFonts.nunito(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Role Types ListView.builder
                        if (roleTypes.isNotEmpty)
                          Card(
                            elevation: 20,
                            shadowColor: Colors.black,
                            child: Container(
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 8),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: roleTypes.length,
                                itemBuilder: (context, index) {
                                  var roleType = roleTypes[index];
                                  bool isSelected =
                                      selectedRoleTypeId == roleType.id &&
                                          selectedRoleTypeName ==
                                              roleType.roleTypeName;
      
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedRoleTypeId = roleType.id;
                                        selectedRoleTypeName =
                                            roleType.roleTypeName;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Card(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            gradient: isSelected
                                                ? const LinearGradient(
                                                    colors: [
                                                      Color(0xFFBA0161),
                                                      Color(0xFF510270),
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  )
                                                : null,
                                          ),
                                          child: Center(
                                            child: Text(
                                              roleType.roleTypeName,
                                              style: GoogleFonts.nunito(
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        // Get It Button
                        InkWell(
                          onTap: () {
                            // Check if selectedRoleId is null
                            if (selectedRoleId == null) {
                              SnackBarUtils.showErrorSnackBar(
                                  context, 'Please select a role.');
                              return; // Exit early if no role is selected
                            }
      
                            // Check if the selected role is 'tutor' and ensure a role type is selected
                            if (selectedRole == 'Tutor' &&
                                selectedRoleTypeId == null) {
                              SnackBarUtils.showErrorSnackBar(context,
                                  'Please select a role type for tutor.');
                              return; // Exit early if tutor is selected but no role type is selected
                            }
      
                            // If we reach here, either a role is selected and it's not 'tutor', or it's 'tuttee' (which doesn't require a role type)
                            Get.to(() => AccountSetup(
                                  roleId: selectedRoleId!,
                                  roleTypeId: selectedRoleTypeId ?? '',
                                  selectedRoleTypeName:
                                      selectedRoleTypeName ?? '',
                                  selectedRole: selectedRole ?? '',
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 8),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(18)),
                              color: Colors.white,
                            ),
                            child: const Text(
                              'Get it',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('assets/image 204.png'),
                ],
              ),
      ),
    );
  }
}
