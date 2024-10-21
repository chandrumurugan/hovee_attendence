// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hovee_attendence/controllers/role_controller.dart';

// class RoleSelection extends StatelessWidget {
//   RoleSelection({super.key});

//   final RoleController roleController = Get.put(RoleController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.5,
//             padding: const EdgeInsets.all(20),
//             width: MediaQuery.sizeOf(context).width,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFFC13584),
//                   Color(0xFF833AB4),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Image.asset(
//                   'assets/appConstantImg/colorlogoword.png',
//                   height: 30,
//                 ),
//                 const Text(
//                   'Select your role',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 24),
//                 ),
//                 // Roles List Displayed Using GetX and ListView.builder
//                 Card(
//                   elevation: 20,
//                   shadowColor: Colors.black,
//                   child: Container(
//                     height: 60, // Adjust height as needed
//                     padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
//                     child: GetX<RoleController>( // Change Obx to GetX
//                     init: Get.put<RoleController>(RoleController()),
//                       builder: (controller) {
//                         if (controller.roles.isEmpty) {
//                           // Display loading or empty state
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }

//                         return ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: controller.roles.length,
//                           itemBuilder: (context, index) {
//                             var role = controller.roles[index];

//                             // Check if this role is selected using reactive variable
//                             bool isSelected = controller.selectedRole.value == role.id;

//                             return GestureDetector(
//                               onTap: () {

//                                 controller.setSelectedRole(role.id); // Set selected role
//                              controller.update();
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: Card(
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10.0, vertical: 5),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                       gradient: isSelected
//                                           ? const LinearGradient(
//                                               colors: [
//                                                 Color(0xFFBA0161),
//                                                 Color(0xFF510270),
//                                               ],
//                                               begin: Alignment.topCenter,
//                                               end: Alignment.bottomCenter,
//                                             )
//                                           : null, // No gradient if not selected
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         role.roleName,
//                                         style: GoogleFonts.nunito(
//                                           color: isSelected ? Colors.white : Colors.black,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                     GetX<RoleController>(
//                   builder: (controller) {
//                     if (controller.roleTypes.isEmpty) {
//                       return const SizedBox.shrink(); // Hide if no role types are available
//                     }

//                     return Card(
//                          elevation: 20,
//                   shadowColor: Colors.black,

//                       child: Container(
//                        height: 60, // Adjust height as needed
//                     padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: controller.roleTypes.length,
//                           itemBuilder: (context, index) {
//                             var roleType = controller.roleTypes[index];
//                                bool isSelected = controller.selectedRoleType.value == roleType.id;
//                                  return GestureDetector(
//                               onTap: () {

//                                 controller.selectedRoleType(roleType.id); // Set selected role
//                                  controller.update();
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: Card(
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10.0, vertical: 5),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                       gradient: isSelected
//                                           ? const LinearGradient(
//                                               colors: [
//                                                 Color(0xFFBA0161),
//                                                 Color(0xFF510270),
//                                               ],
//                                               begin: Alignment.topCenter,
//                                               end: Alignment.bottomCenter,
//                                             )
//                                           : null, // No gradient if not selected
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         roleType.roleTypeName,
//                                         style: GoogleFonts.nunito(
//                                           color: isSelected ? Colors.white : Colors.black,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                             // return Padding(
//                             //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                             //   child: Chip(
//                             //     label: Text(roleType.roleTypeName),
//                             //   ),
//                             // );
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 // Get It Button
//                 InkWell(
//                   onTap: () {

//                     // Handle button press
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
//                     decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(18)),
//                         color: Colors.white),
//                     child: const Text(
//                       'Get it',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Image.asset('assets/image 204.png')
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/role_controller.dart';
import 'package:hovee_attendence/modals/role_modal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/accountsetup_screen.dart';
import 'package:hovee_attendence/view/dashBoard.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({Key? key}) : super(key: key);

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  final RoleController roleController = Get.put(RoleController());

  // Local state for selected role and role type
  String? selectedRoleId;
  String? selectedRoleTypeId;
  List<Role>? roles;
  List<RoleType> roleType = [];
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
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
        roles = fetchedRoles;
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle errors
      setState(() {
        _isLoading = false;
      });
      print("Error fetching roles: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
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
                      Image.asset(
                        'assets/appConstantImg/colorlogoword.png',
                        height: 30,
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
                          height: 60, // Adjust height as needed
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 8),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: roles!.length,
                            itemBuilder: (context, index) {
                              var role = roles![index];
                              bool isSelected = selectedRoleId == role.id;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedRoleId = role.id;
                                  });
                                  var selectedRoleData = roles!.firstWhere(
                                      (role) => role.id == selectedRoleId);

                                  if (selectedRoleData.roleTypes.isNotEmpty) {
                                    // Update the role types list based on selected role
                                    roleType = selectedRoleData.roleTypes;
                                  } else {
                                    roleType.clear(); // Clear if no role types
                                  }

                                  // Store selected roleId in GetX for use across other screens
                                  // roleController.setSelectedRole(role.id);
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
                                            : null, // No gradient if not selected
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
                      if (roleType.isNotEmpty)
                        Card(
                          elevation: 20,
                          shadowColor: Colors.black,
                          child: Container(
                            height: 60, // Adjust height as needed
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 8),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: roleType.length,
                              itemBuilder: (context, index) {
                                var roleTypes = roleType[index];
                                bool isSelected =
                                    selectedRoleTypeId == roleTypes.id;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRoleTypeId = roleTypes.id;
                                    });

                                    // Store selected roleTypeId in GetX for use across other screens
                                    // roleController.setSelectedRoleType(roleType.id);
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
                                              : null, // No gradient if not selected
                                        ),
                                        child: Center(
                                          child: Text(
                                            roleTypes.roleTypeName,
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
                          // Handle button press
                          // You can access selectedRoleId and selectedRoleTypeId here

                          Get.to(()=> AccountSetup(roleId:selectedRoleId! , roleTypeId: selectedRoleTypeId!,));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 8),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              color: Colors.white),
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
                Image.asset('assets/image 204.png')
              ],
            ),
    );
  }
}
