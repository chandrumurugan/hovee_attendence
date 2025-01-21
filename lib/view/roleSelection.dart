import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/role_controller.dart';
import 'package:hovee_attendence/modals/role_modal.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/accountsetup_screen.dart';
import 'package:hovee_attendence/view/parent_account_setup_screen.dart';
import 'package:hovee_attendence/widget/gifController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleSelection extends StatefulWidget {
  final bool isFromParentOtp;
  final String? parentId;
  final bool isGoogleSignIn;
  const RoleSelection(
      {Key? key,
      required this.isFromParentOtp,
      this.parentId,
      required this.isGoogleSignIn})
      : super(key: key);

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  final RoleController roleController = Get.put(RoleController());

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
        setState(() async {
          roles = fetchedRoles;

          if (widget.parentId != null && widget.parentId!.isNotEmpty) {
            // Default select "Tutee" role when parentId is not null or empty
            var tuteeRole = fetchedRoles.firstWhere(
              (role) => role.roleName.toLowerCase() == 'tutee',
              orElse: () => fetchedRoles[
                  0], // Default to the first role if "Tutee" not found
            );

            selectedRoleId = tuteeRole.id;
            selectedRole = tuteeRole.roleName;
            roleTypes = tuteeRole.roleTypes;

            // Set default role type if available
            if (roleTypes.isNotEmpty) {
              selectedRoleTypeId = roleTypes.first.id;
              selectedRoleTypeName = roleTypes.first.roleTypeName;
            }

            // Save the "Tutee" role in SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('Rolename', selectedRole ?? '');
          } else if (widget.isFromParentOtp) {
            // Default select "Parent" role for ParentOtpScreen
            var parentRole = fetchedRoles.firstWhere(
              (role) => role.roleName.toLowerCase() == 'parent',
              orElse: () =>
                  fetchedRoles[2], // Default to index 2 if "Parent" not found
            );

            selectedRoleId = parentRole.id;
            selectedRole = parentRole.roleName;
            roleTypes = parentRole.roleTypes;

            // Set default role type if available
            if (roleTypes.isNotEmpty) {
              selectedRoleTypeId = roleTypes.first.id;
              selectedRoleTypeName = roleTypes.first.roleTypeName;
            }

            // Save the "Parent" role in SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('Rolename', selectedRole ?? '');
          }

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
      onWillPop: () async {
        return await ModalService.handleBackButtonN(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const LogoGif(),
            centerTitle: true,
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
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
                            const SizedBox(
                              height: 30,
                            ),

                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Select your role',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 24),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // Roles ListView.builder
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Card(
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
                                      bool isSelected =
                                          selectedRoleId == role.id &&
                                              selectedRole == role.roleName;

                                      return GestureDetector(
                                        onTap: () async {
                                          // Condition to restrict access to roles other than 'Tutee'
                                          if (widget.parentId != null &&
                                              widget.parentId!.isNotEmpty &&
                                              role.roleName != 'Tutee') {
                                            // SnackBarUtils.showSuccessSnackBar(
                                            //   context,
                                            //   'Only Tutee role is allowed in this scenario.',
                                            // );
                                            return; // Exit early, prevent selection
                                          }

                                          // Allow interaction only with the initially selected role
                                          if (!widget.isFromParentOtp ||
                                              isSelected) {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setString('Rolename',
                                                role.roleName ?? '');
                                            setState(() {
                                              selectedRoleId = role.id;
                                              roleTypes = role.roleTypes;
                                              selectedRoleTypeId = null;
                                              selectedRoleTypeName =
                                                  null; // Reset selected role type
                                              selectedRole = role.roleName;
                                            });
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Card(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                gradient: isSelected
                                                    ? const LinearGradient(
                                                        colors: [
                                                          Color(0xFFBA0161),
                                                          Color(0xFF510270),
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
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
                            ),
                            // Role Types ListView.builder
                            if (roleTypes.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Card(
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  gradient: isSelected
                                                      ? const LinearGradient(
                                                          colors: [
                                                            Color(0xFFBA0161),
                                                            Color(0xFF510270),
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                              ),
                            // Get It Button

                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: InkWell(
                                onTap: () {
                                  // Check if selectedRoleId is null
                                  if (selectedRoleId == null) {
                                    SnackBarUtils.showSuccessSnackBar(
                                      context,
                                      'Please select a role.',
                                    );
                                    return; // Exit early if no role is selected
                                  }

                                  // Check if the selected role is 'tutor' and ensure a role type is selected
                                  if (selectedRole == 'Tutor' &&
                                      selectedRoleTypeId == null) {
                                    SnackBarUtils.showSuccessSnackBar(
                                      context,
                                      'Please select the role type.',
                                    );
                                    return; // Exit early if tutor is selected but no role type is selected
                                  }

                                  if (selectedRole == 'Tutor' &&
                                      selectedRoleTypeName == 'Institute') {
                                    SnackBarUtils.showSuccessSnackBar(
                                      context,
                                      'Feature under development.',
                                    );
                                    return; // Exit early if tutor is selected but no role type is selected
                                  }
                                  // Handle Parent role navigation based on isFromParentOtp
                                  if (selectedRole == 'Parent') {
                                    if (widget.isFromParentOtp) {
                                      // Navigate to ParentAccountSetupScreen
                                      Get.to(() => ParentAccountSetupScreen());
                                    } else {
                                      // Navigate to AccountSetup
                                      Get.to(
                                        () => AccountSetup(
                                            roleId: selectedRoleId!,
                                            roleTypeId:
                                                selectedRoleTypeId ?? '',
                                            selectedRoleTypeName:
                                                selectedRoleTypeName ?? '',
                                            selectedRole: selectedRole ?? '',
                                            parentId: widget.parentId ?? '',
                                            isGoogleSignIn:
                                                widget.isGoogleSignIn),
                                        arguments: {
                                          'parentId': widget.parentId ?? null,
                                          'isGoogleSignIn': widget
                                              .isGoogleSignIn, // or false, based on your logic
                                        },
                                      );
                                    }
                                    return; // Exit after handling Parent role
                                  }
                                  if (selectedRole == 'Hostel') {
                                    SnackBarUtils.showSuccessSnackBar(
                                      context,
                                      'Feature under development.',
                                    );
                                    return;
                                  }
                                   if (selectedRole == 'Hosteller') {
                                    SnackBarUtils.showSuccessSnackBar(
                                      context,
                                      'Feature under development.',
                                    );
                                    return;
                                  }
                                  // If we reach here, either a role is selected and it's not 'tutor', or it's 'tuttee' (which doesn't require a role type)
                                  Get.to(
                                    () => AccountSetup(
                                        roleId: selectedRoleId!,
                                        roleTypeId: selectedRoleTypeId ?? '',
                                        selectedRoleTypeName:
                                            selectedRoleTypeName ?? '',
                                        selectedRole: selectedRole ?? '',
                                        parentId: widget.parentId ?? '',
                                        isGoogleSignIn: widget.isGoogleSignIn),
                                    arguments: {
                                      'parentId': widget.parentId ?? null,
                                      'isGoogleSignIn': widget
                                          .isGoogleSignIn, // or false, based on your logic
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 8),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
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
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/image 204.png',
                        height: 250,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
