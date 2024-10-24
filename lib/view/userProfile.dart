import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/widget/addteacher_dropdown.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});
  UserProfileController accountController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    accountController.dobController.text = DateFormat('dd/MM/yyyy').format(
      DateTime.now().subtract(const Duration(days: 365 * 18)),
    );
    //  print("object")
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.back();
          },
        ),
        body: Obx(() {
          if (accountController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              ClipPath(
                clipper: HemisphereClipper(),
                child: Container(
                  height: 150,
                  width: MediaQuery.sizeOf(context).width,
                  color: Colors.purple,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Adjust as per your design
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 42,
                        // Optional: Set a background color
                        //backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons
                              .person, // Correct usage: provide IconData directly
                          size: 36, // Adjust the icon size as needed
                          color: Colors.black, // Set the icon color
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.14),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    child: Container(
                      height: accountController.currentTabIndex.value == 0
                          ? MediaQuery.of(context).size.height * 0.7
                          : MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Adjust as per your design
                    SizedBox(height: 10,),

                    Text(
                      '${accountController.userProfileResponse.value.data!.rolesId!.roleName ?? ""}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      '${accountController.userProfileResponse.value.data!.wowId!}',
                      style: TextStyle(
                        color: AppConstants.secondaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          TabBar(
                            //isScrollable: true, // Allow tabs to be scrollable to show the full text
                            dragStartBehavior: DragStartBehavior.down,
                            controller: accountController.tabController,
                            onTap: (int index) {
                              accountController.currentTabIndex.value = index;
                              accountController.isLoading.value = false;
                            },
                            tabs: const [
                              Tab(
                                text: 'Personal info',
                                // child: Text("Personal info",style: GoogleFonts.nunito(color: Colors.black),textAlign: TextAlign.center,),
                              ),
                              Tab(
                                text: 'Address',
                              ),
                              Tab(
                                text: 'Education',
                              ),
                            ],
                            unselectedLabelColor: Colors.grey,
                            unselectedLabelStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                              child: TabBarView(
                                  controller: accountController.tabController,
                                  children: [
                                //personal tab
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Name',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.grey.shade200),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: InputTextField(
                                                    suffix: false,
                                                    readonly: false,
                                                    hintText: 'First',
                                                    keyboardType:
                                                        TextInputType.name,
                                                    inputFormatter: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(
                                                          r"[a-zA-Z0-9\s@&_,-\.']",
                                                        ),
                                                      ),
                                                    ],
                                                    controller: accountController
                                                        .firstNameController),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 1,
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                              ),
                                              Expanded(
                                                child: InputTextField(
                                                  suffix: false,
                                                  readonly: false,
                                                  hintText: 'Last',
                                                  keyboardType:
                                                      TextInputType.name,
                                                  inputFormatter: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                      RegExp(
                                                        r"[a-zA-Z0-9\s@&_,-\.']",
                                                      ),
                                                    ),
                                                  ],
                                                  controller: accountController
                                                      .lastNameController,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Email',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InputTextField(
                                            suffix: false,
                                            readonly: false,
                                            inputFormatter: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(
                                                  r"[a-zA-Z0-9@&_,-\.']",
                                                ),
                                              ),
                                            ],
                                            hintText: 'Enter your email',
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller: accountController
                                                .emailController),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Date of birth',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        InputTextField(
                                            suffix: true,
                                            readonly: true,
                                            isDate: true,
                                            hintText: 'Enter your dob',
                                            initialDate:
                                                DateTime.now().subtract(
                                              const Duration(days: 365 * 18),
                                            ),
                                            lastDate: DateTime.now().subtract(
                                              const Duration(days: 365 * 18),
                                            ),
                                            keyboardType:
                                                TextInputType.datetime,
                                            controller: accountController
                                                .dobController),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Phone number',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        InputTextField(
                                            suffix: false,
                                            readonly: false,
                                            hintText: 'Enter your phone number',
                                            keyboardType: TextInputType.phone,
                                            inputFormatter: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(r"[0-9]"),
                                              ),
                                              LengthLimitingTextInputFormatter(
                                                  10), // Restrict to 10 digits
                                            ],
                                            controller:
                                                accountController.phController),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Pincode',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        InputTextField(
                                          suffix: false,
                                          readonly: false,
                                          hintText: 'Enter your pincode',
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                r"[0-9]",
                                              ),
                                            ),
                                            LengthLimitingTextInputFormatter(6),
                                          ],
                                          keyboardType: TextInputType.number,
                                          controller: accountController
                                              .pincodeController,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'ID Proof',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // print("gretting values==");
                                            // ModalService.openIDProofModalSheet(
                                            //     context,
                                            //     splashController,
                                            //     accountController);
                                          },
                                          child: Container(
                                            height: 55,
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10, left: 12),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: accountController
                                                    .selectedIDProof
                                                    .value
                                                    .isNotEmpty
                                                ? Text(accountController
                                                    .selectedIDProof.value)
                                                : Text(
                                                    "Tap to select the ID proof",
                                                    style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     // accountController.storePersonalInfo(
                                        //     //     context, roleId, roleTypeId);
                                        //   },
                                        //   child: Container(
                                        //     height: 48,
                                        //     padding: const EdgeInsets.symmetric(
                                        //       horizontal: 40,
                                        //       vertical: 12,
                                        //     ),
                                        //     decoration: const BoxDecoration(
                                        //       borderRadius: BorderRadius.all(
                                        //         Radius.circular(8),
                                        //       ),
                                        //       gradient: LinearGradient(
                                        //         colors: [
                                        //           Color(0xFFC13584),
                                        //           Color(0xFF833AB4)
                                        //         ],
                                        //         begin: Alignment.topCenter,
                                        //         end: Alignment.bottomCenter,
                                        //       ),
                                        //     ),
                                        //     child:
                                        //         accountController.isLoading.value
                                        //             ? const Center(
                                        //                 child:
                                        //                     CircularProgressIndicator(),
                                        //               )
                                        //             : const Center(
                                        //                 child: Text(
                                        //                   'Next',
                                        //                   style: TextStyle(
                                        //                     fontSize: 16,
                                        //                     fontWeight:
                                        //                         FontWeight.w600,
                                        //                     color: Colors.white,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //   ),
                                        // ),
                                        // const SizedBox(
                                        //   height: 16,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),

                                //address info
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Door no',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InputTextField(
                                            suffix: false,
                                            readonly: false,
                                            hintText: 'Enter your door no',
                                            keyboardType: TextInputType.name,
                                            controller: accountController
                                                .address1Controller),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Street/Area',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InputTextField(
                                            suffix: false,
                                            readonly: false,
                                            hintText: 'Enter your address',
                                            keyboardType: TextInputType.name,
                                            controller: accountController
                                                .address2Controller),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'City',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InputTextField(
                                            suffix: false,
                                            readonly: false,
                                            hintText: 'Enter your city',
                                            keyboardType: TextInputType.name,
                                            controller: accountController
                                                .cityController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'State',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InputTextField(
                                            suffix: false,
                                            readonly: false,
                                            hintText: 'Enter your state',
                                            keyboardType: TextInputType.text,
                                            controller: accountController
                                                .stateController),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Country',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InputTextField(
                                          suffix: false,
                                          readonly: false,
                                          hintText: 'Enter your country',
                                          keyboardType: TextInputType.name,
                                          controller: accountController
                                              .countryController,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Pincode',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '*',
                                              style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    Colors.red.withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InputTextField(
                                          suffix: false,
                                          readonly: false,
                                          hintText: 'Enter pincode',
                                          keyboardType: TextInputType.number,
                                          controller: accountController
                                              .pincodesController,
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                r"[0-9]",
                                              ),
                                            ),
                                            LengthLimitingTextInputFormatter(6),
                                          ],
                                        ),
                                        // const SizedBox(
                                        //   height: 16,
                                        // ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     // accountController
                                        //     //     .storeAddressInfo(context);
                                        //   },
                                        //   child: Container(
                                        //     height: 48,
                                        //     padding: const EdgeInsets.symmetric(
                                        //       horizontal: 40,
                                        //       vertical: 12,
                                        //     ),
                                        //     decoration: const BoxDecoration(
                                        //       borderRadius: BorderRadius.all(
                                        //         Radius.circular(8),
                                        //       ),
                                        //       gradient: LinearGradient(
                                        //         colors: [
                                        //           Color(0xFFC13584),
                                        //           Color(0xFF833AB4)
                                        //         ],
                                        //         begin: Alignment.topCenter,
                                        //         end: Alignment.bottomCenter,
                                        //       ),
                                        //     ),
                                        //     child:
                                        //         accountController.isLoading.value
                                        //             ? const Center(
                                        //                 child:
                                        //                     CircularProgressIndicator(),
                                        //               )
                                        //             : const Center(
                                        //                 child: Text(
                                        //                   'Next',
                                        //                   style: TextStyle(
                                        //                     fontSize: 16,
                                        //                     fontWeight:
                                        //                         FontWeight.w600,
                                        //                     color: Colors.white,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // if (accountController
                                        //         .userProfileResponse
                                        //         .value
                                        //         .data!
                                        //         .rolesId!
                                        //         .roleName ==
                                        //     "Tutor")
                                          ..._buildDropdowns(),
                                        // else
                                        //   //  if(accountController.userProfileResponse.value.data!.rolesId!.roleName == "Tutee")

                                        //   ..._buildDropdowns(),
                                           if (accountController
                                                .userProfileResponse
                                                .value
                                                .data!
                                                .rolesId!
                                                .roleName ==
                                            "Tutor")
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Additional Info',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              CommonInputField(
                                                title: 'Additional Info',
                                                controllerValue:
                                                    accountController
                                                        .additionalInfo,
                                                selectedValue: accountController
                                                    .additionalInfo,
                                                onTap: () {},
                                              ),
                                            ],
                                          ),
                                        ),
                                        // _buildFileUploadSection(
                                        //     'Attach Resume', 'resume'),
                                        // _buildFileUploadSection(
                                        //     'Attach Education Certificate',
                                        //     'education'),
                                        // _buildFileUploadSection(
                                        //     'Attach Experience Certificate',
                                        //     'experience'),
                                        // if (accountController
                                        //     .validationMessages.isNotEmpty)
                                        //   Column(
                                        //     children: accountController
                                        //         .validationMessages
                                        //         .map((msg) => Text(
                                        //               msg,
                                        //               style: TextStyle(
                                        //                   color: Colors.red),
                                        //             ))
                                        //         .toList(),
                                        //   ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     // accountController.storeEducationInfo(
                                        //     //     context, roleId, roleTypeId);
                                        //   },
                                        //   child: Container(
                                        //     height: 48,
                                        //     padding: const EdgeInsets.symmetric(
                                        //       horizontal: 40,
                                        //       vertical: 12,
                                        //     ),
                                        //     decoration: const BoxDecoration(
                                        //       borderRadius: BorderRadius.all(
                                        //         Radius.circular(8),
                                        //       ),
                                        //       gradient: LinearGradient(
                                        //         colors: [
                                        //           Color(0xFFC13584),
                                        //           Color(0xFF833AB4)
                                        //         ],
                                        //         begin: Alignment.topCenter,
                                        //         end: Alignment.bottomCenter,
                                        //       ),
                                        //     ),
                                        //     child:
                                        //         accountController.isLoading.value
                                        //             ? const Center(
                                        //                 child:
                                        //                     CircularProgressIndicator(),
                                        //               )
                                        //             : const Center(
                                        //                 child: Text(
                                        //                   'Next',
                                        //                   style: TextStyle(
                                        //                     fontSize: 16,
                                        //                     fontWeight:
                                        //                         FontWeight.w600,
                                        //                     color: Colors.white,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        // SingleButton(
                                        //   btnName: 'Add',
                                        //   onTap: () {
                                        // accountController
                                        //     .storeEducationInfo(context);

                                        //   },
                                        // )
                                      ],
                                    ),
                                  ),
                                )
                              ]))
                        ],
                      ),
                    ),
                    //             child: Obx(() {
                    //               return Container(
                    //                 height: accountController.currentTabIndex.value == 0
                    //                     ? MediaQuery.of(context).size.height * 0.7
                    //                     : MediaQuery.of(context).size.height * 0.7,
                    //                 width: MediaQuery.sizeOf(context).width,
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(8.0),
                    //                   color: Colors.white,
                    //                 ),
                    //                 child: Column(
                    //                   mainAxisAlignment: MainAxisAlignment.start,
                    //                   children: [
                    //                     SizedBox(
                    //                       height: MediaQuery.of(context).size.height * 0.05,
                    //                     ),
                    //                     TabBar(
                    //                       //isScrollable: true, // Allow tabs to be scrollable to show the full text
                    //                       dragStartBehavior: DragStartBehavior.down,
                    //                       controller: accountController.tabController,
                    //                       onTap: (int index) {
                    //                         accountController.currentTabIndex.value = index;
                    //                         accountController.isLoading.value = false;
                    //                       },
                    //                       tabs: const [
                    //                         Tab(
                    //                           text: 'Personal info',
                    //                         ),
                    //                         Tab(
                    //                           text: 'Address info',
                    //                         ),
                    //                         Tab(
                    //                           text: 'Education info',
                    //                         ),
                    //                       ],
                    //                       unselectedLabelColor: Colors.grey,
                    //                       unselectedLabelStyle: const TextStyle(
                    //                         fontSize: 14,
                    //                         fontWeight: FontWeight.w500,
                    //                       ),
                    //                       labelStyle: const TextStyle(
                    //                         fontSize: 14,
                    //                         fontWeight: FontWeight.w500,
                    //                         color: Colors.black,
                    //                       ),
                    //                     ),
                    //                        const SizedBox(height: 20),
                    //                        Expanded(child:

                    //                        TabBarView(

                    //                            controller: accountController.tabController,
                    //                         children: [
                    //                         //personal tab
                    //                           Container(
                    //                             padding:
                    //                                 const EdgeInsets.symmetric(horizontal: 12),
                    //                             child: SingleChildScrollView(
                    //                               child: Column(
                    //                                 mainAxisAlignment: MainAxisAlignment.start,
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment.start,
                    //                                 children: [
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'Name',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Container(
                    //                                     decoration: BoxDecoration(
                    //                                         borderRadius:
                    //                                             BorderRadius.circular(12),
                    //                                         color: Colors.grey.shade200),
                    //                                     child: Row(
                    //                                       children: [
                    //                                         Expanded(
                    //                                           child: InputTextField(
                    //                                               suffix: false,
                    //                                               readonly: false,
                    //                                               hintText: 'First',
                    //                                               keyboardType:
                    //                                                   TextInputType.name,
                    //                                               inputFormatter: [
                    //                                                 FilteringTextInputFormatter
                    //                                                     .allow(
                    //                                                   RegExp(
                    //                                                     r"[a-zA-Z0-9\s@&_,-\.']",
                    //                                                   ),
                    //                                                 ),
                    //                                               ],
                    //                                               controller: accountController
                    //                                                   .firstNameController),
                    //                                         ),
                    //                                         Container(
                    //                                           height: 30,
                    //                                           width: 1,
                    //                                           color:
                    //                                               Colors.black.withOpacity(0.2),
                    //                                         ),
                    //                                         Expanded(
                    //                                           child: InputTextField(
                    //                                             suffix: false,
                    //                                             readonly: false,
                    //                                             hintText: 'Last',
                    //                                             keyboardType:
                    //                                                 TextInputType.name,
                    //                                             inputFormatter: [
                    //                                               FilteringTextInputFormatter
                    //                                                   .allow(
                    //                                                 RegExp(
                    //                                                   r"[a-zA-Z0-9\s@&_,-\.']",
                    //                                                 ),
                    //                                               ),
                    //                                             ],
                    //                                             controller: accountController
                    //                                                 .lastNameController,
                    //                                           ),
                    //                                         ),
                    //                                       ],
                    //                                     ),
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'Email',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   InputTextField(
                    //                                       suffix: false,
                    //                                       readonly: false,
                    //                                       inputFormatter: [
                    //                                         FilteringTextInputFormatter.allow(
                    //                                           RegExp(
                    //                                             r"[a-zA-Z0-9@&_,-\.']",
                    //                                           ),
                    //                                         ),
                    //                                       ],
                    //                                       hintText: 'Enter your email',
                    //                                       keyboardType:
                    //                                           TextInputType.emailAddress,
                    //                                       controller: accountController
                    //                                           .emailController),
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'Date of birth',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   InputTextField(
                    //                                       suffix: true,
                    //                                       readonly: true,
                    //                                       isDate: true,
                    //                                       hintText: 'Enter your dob',
                    //                                       initialDate: DateTime.now().subtract(
                    //                                         const Duration(days: 365 * 18),
                    //                                       ),
                    //                                       lastDate: DateTime.now().subtract(
                    //                                         const Duration(days: 365 * 18),
                    //                                       ),
                    //                                       keyboardType: TextInputType.datetime,
                    //                                       controller:
                    //                                           accountController.dobController),
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'Phone number',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   InputTextField(
                    //                                       suffix: false,
                    //                                       readonly: false,
                    //                                       hintText: 'Enter your phone number',
                    //                                       keyboardType: TextInputType.phone,
                    //                                       inputFormatter: [
                    //                                         FilteringTextInputFormatter.allow(
                    //                                           RegExp(r"[0-9]"),
                    //                                         ),
                    //                                         LengthLimitingTextInputFormatter(
                    //                                             10), // Restrict to 10 digits
                    //                                       ],
                    //                                       controller:
                    //                                           accountController.phController),
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'Pincode',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   InputTextField(
                    //                                     suffix: false,
                    //                                     readonly: false,
                    //                                     hintText: 'Enter your pincode',
                    //                                     inputFormatter: [
                    //                                       FilteringTextInputFormatter.allow(
                    //                                         RegExp(
                    //                                           r"[0-9]",
                    //                                         ),
                    //                                       ),
                    //                                       LengthLimitingTextInputFormatter(6),
                    //                                     ],
                    //                                     keyboardType: TextInputType.number,
                    //                                     controller:
                    //                                         accountController.pincodeController,
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'ID Proof',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   InkWell(
                    //                                     onTap: () {
                    //                                       // print("gretting values==");
                    //                                       // ModalService.openIDProofModalSheet(
                    //                                       //     context,
                    //                                       //     splashController,
                    //                                       //     accountController);
                    //                                     },
                    //                                     child: Container(
                    //                                       height: 55,
                    //                                       alignment: Alignment.centerLeft,
                    //                                       padding: const EdgeInsets.only(
                    //                                           top: 10, bottom: 10, left: 12),
                    //                                       decoration: BoxDecoration(
                    //                                           color: Colors.grey[200],
                    //                                           borderRadius:
                    //                                               BorderRadius.circular(15)),
                    //                                       child: accountController
                    //                                               .selectedIDProof
                    //                                               .value
                    //                                               .isNotEmpty
                    //                                           ? Text(accountController
                    //                                               .selectedIDProof.value)
                    //                                           : Text(
                    //                                               "Tap to select the ID proof",
                    //                                               style: TextStyle(
                    //                                                   color: Colors.grey[400],
                    //                                                   fontWeight:
                    //                                                       FontWeight.w400)),
                    //                                     ),
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 16,
                    //                                   ),
                    //                                   // InkWell(
                    //                                   //   onTap: () {
                    //                                   //     // accountController.storePersonalInfo(
                    //                                   //     //     context, roleId, roleTypeId);
                    //                                   //   },
                    //                                   //   child: Container(
                    //                                   //     height: 48,
                    //                                   //     padding: const EdgeInsets.symmetric(
                    //                                   //       horizontal: 40,
                    //                                   //       vertical: 12,
                    //                                   //     ),
                    //                                   //     decoration: const BoxDecoration(
                    //                                   //       borderRadius: BorderRadius.all(
                    //                                   //         Radius.circular(8),
                    //                                   //       ),
                    //                                   //       gradient: LinearGradient(
                    //                                   //         colors: [
                    //                                   //           Color(0xFFC13584),
                    //                                   //           Color(0xFF833AB4)
                    //                                   //         ],
                    //                                   //         begin: Alignment.topCenter,
                    //                                   //         end: Alignment.bottomCenter,
                    //                                   //       ),
                    //                                   //     ),
                    //                                   //     child:
                    //                                   //         accountController.isLoading.value
                    //                                   //             ? const Center(
                    //                                   //                 child:
                    //                                   //                     CircularProgressIndicator(),
                    //                                   //               )
                    //                                   //             : const Center(
                    //                                   //                 child: Text(
                    //                                   //                   'Next',
                    //                                   //                   style: TextStyle(
                    //                                   //                     fontSize: 16,
                    //                                   //                     fontWeight:
                    //                                   //                         FontWeight.w600,
                    //                                   //                     color: Colors.white,
                    //                                   //                   ),
                    //                                   //                 ),
                    //                                   //               ),
                    //                                   //   ),
                    //                                   // ),
                    //                                   // const SizedBox(
                    //                                   //   height: 16,
                    //                                   // ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ),

                    // //address info
                    //                           Container(
                    //                             padding:
                    //                                 const EdgeInsets.symmetric(horizontal: 12),
                    //                             child: SingleChildScrollView(
                    //                               child: Column(
                    //                                 mainAxisAlignment: MainAxisAlignment.start,
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment.start,
                    //                                 children: [
                    //                                   const SizedBox(
                    //                                     height: 5,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'Address1',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   InputTextField(
                    //                                       suffix: false,
                    //                                       readonly: false,
                    //                                       hintText: 'Enter your address',
                    //                                       keyboardType: TextInputType.name,
                    //                                       controller: accountController
                    //                                           .address1Controller),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'Address2',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   InputTextField(
                    //                                       suffix: false,
                    //                                       readonly: false,
                    //                                       hintText: 'Enter your address',
                    //                                       keyboardType: TextInputType.name,
                    //                                       controller: accountController
                    //                                           .address2Controller),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'City',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   InputTextField(
                    //                                       suffix: false,
                    //                                       readonly: false,
                    //                                       hintText: 'Enter your city',
                    //                                       keyboardType: TextInputType.name,
                    //                                       controller:
                    //                                           accountController.cityController),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'State',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   InputTextField(
                    //                                       suffix: false,
                    //                                       readonly: false,
                    //                                       hintText: 'Enter your state',
                    //                                       keyboardType: TextInputType.text,
                    //                                       controller: accountController
                    //                                           .stateController),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'Country',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   InputTextField(
                    //                                     suffix: false,
                    //                                     readonly: false,
                    //                                     hintText: 'Enter your country',
                    //                                     keyboardType: TextInputType.name,
                    //                                     controller:
                    //                                         accountController.countryController,
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   Row(
                    //                                     children: [
                    //                                       const Text(
                    //                                         'Pincode',
                    //                                         style: TextStyle(
                    //                                           fontSize: 14,
                    //                                           fontWeight: FontWeight.w500,
                    //                                           color: Colors.black,
                    //                                         ),
                    //                                       ),
                    //                                       Text(
                    //                                         '*',
                    //                                         style: GoogleFonts.nunito(
                    //                                           fontSize: 18,
                    //                                           fontWeight: FontWeight.w600,
                    //                                           color:
                    //                                               Colors.red.withOpacity(0.6),
                    //                                         ),
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                   const SizedBox(
                    //                                     height: 10,
                    //                                   ),
                    //                                   InputTextField(
                    //                                     suffix: false,
                    //                                     readonly: false,
                    //                                     hintText: 'Enter pincode',
                    //                                     keyboardType: TextInputType.number,
                    //                                     controller: accountController
                    //                                         .pincodesController,
                    //                                     inputFormatter: [
                    //                                       FilteringTextInputFormatter.allow(
                    //                                         RegExp(
                    //                                           r"[0-9]",
                    //                                         ),
                    //                                       ),
                    //                                       LengthLimitingTextInputFormatter(6),
                    //                                     ],
                    //                                   ),
                    //                                   // const SizedBox(
                    //                                   //   height: 16,
                    //                                   // ),
                    //                                   // InkWell(
                    //                                   //   onTap: () {
                    //                                   //     // accountController
                    //                                   //     //     .storeAddressInfo(context);
                    //                                   //   },
                    //                                   //   child: Container(
                    //                                   //     height: 48,
                    //                                   //     padding: const EdgeInsets.symmetric(
                    //                                   //       horizontal: 40,
                    //                                   //       vertical: 12,
                    //                                   //     ),
                    //                                   //     decoration: const BoxDecoration(
                    //                                   //       borderRadius: BorderRadius.all(
                    //                                   //         Radius.circular(8),
                    //                                   //       ),
                    //                                   //       gradient: LinearGradient(
                    //                                   //         colors: [
                    //                                   //           Color(0xFFC13584),
                    //                                   //           Color(0xFF833AB4)
                    //                                   //         ],
                    //                                   //         begin: Alignment.topCenter,
                    //                                   //         end: Alignment.bottomCenter,
                    //                                   //       ),
                    //                                   //     ),
                    //                                   //     child:
                    //                                   //         accountController.isLoading.value
                    //                                   //             ? const Center(
                    //                                   //                 child:
                    //                                   //                     CircularProgressIndicator(),
                    //                                   //               )
                    //                                   //             : const Center(
                    //                                   //                 child: Text(
                    //                                   //                   'Next',
                    //                                   //                   style: TextStyle(
                    //                                   //                     fontSize: 16,
                    //                                   //                     fontWeight:
                    //                                   //                         FontWeight.w600,
                    //                                   //                     color: Colors.white,
                    //                                   //                   ),
                    //                                   //                 ),
                    //                                   //               ),
                    //                                   //   ),
                    //                                   // ),
                    //                                   const SizedBox(
                    //                                     height: 16,
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ),

                    //                             Container(
                    //                             padding: EdgeInsets.symmetric(horizontal: 12),
                    //                             child: SingleChildScrollView(
                    //                               child: Column(
                    //                                 mainAxisAlignment: MainAxisAlignment.start,
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment.start,
                    //                                 children: [
                    //                                   ..._buildDropdowns(),
                    //                                   Padding(
                    //                                     padding:
                    //                                         EdgeInsets.symmetric(vertical: 10),
                    //                                     child: Column(
                    //                                       crossAxisAlignment:
                    //                                           CrossAxisAlignment.start,
                    //                                       children: [
                    //                                         const Text(
                    //                                           'Additional Info',
                    //                                           style: TextStyle(
                    //                                             fontSize: 14,
                    //                                             fontWeight: FontWeight.w500,
                    //                                             color: Colors.black,
                    //                                           ),
                    //                                         ),
                    //                                         const SizedBox(
                    //                                           height: 5,
                    //                                         ),
                    //                                         CommonInputField(
                    //                                           label: 'Additional Info',
                    //                                           controllerValue: accountController
                    //                                               .additionalInfo,
                    //                                           onTap: () {},
                    //                                         ),
                    //                                       ],
                    //                                     ),
                    //                                   ),
                    //                                   // _buildFileUploadSection(
                    //                                   //     'Attach Resume', 'resume'),
                    //                                   // _buildFileUploadSection(
                    //                                   //     'Attach Education Certificate',
                    //                                   //     'education'),
                    //                                   // _buildFileUploadSection(
                    //                                   //     'Attach Experience Certificate',
                    //                                   //     'experience'),
                    //                                   // if (accountController
                    //                                   //     .validationMessages.isNotEmpty)
                    //                                   //   Column(
                    //                                   //     children: accountController
                    //                                   //         .validationMessages
                    //                                   //         .map((msg) => Text(
                    //                                   //               msg,
                    //                                   //               style: TextStyle(
                    //                                   //                   color: Colors.red),
                    //                                   //             ))
                    //                                   //         .toList(),
                    //                                   //   ),
                    //                                   // InkWell(
                    //                                   //   onTap: () {
                    //                                   //     // accountController.storeEducationInfo(
                    //                                   //     //     context, roleId, roleTypeId);
                    //                                   //   },
                    //                                   //   child: Container(
                    //                                   //     height: 48,
                    //                                   //     padding: const EdgeInsets.symmetric(
                    //                                   //       horizontal: 40,
                    //                                   //       vertical: 12,
                    //                                   //     ),
                    //                                   //     decoration: const BoxDecoration(
                    //                                   //       borderRadius: BorderRadius.all(
                    //                                   //         Radius.circular(8),
                    //                                   //       ),
                    //                                   //       gradient: LinearGradient(
                    //                                   //         colors: [
                    //                                   //           Color(0xFFC13584),
                    //                                   //           Color(0xFF833AB4)
                    //                                   //         ],
                    //                                   //         begin: Alignment.topCenter,
                    //                                   //         end: Alignment.bottomCenter,
                    //                                   //       ),
                    //                                   //     ),
                    //                                   //     child:
                    //                                   //         accountController.isLoading.value
                    //                                   //             ? const Center(
                    //                                   //                 child:
                    //                                   //                     CircularProgressIndicator(),
                    //                                   //               )
                    //                                   //             : const Center(
                    //                                   //                 child: Text(
                    //                                   //                   'Next',
                    //                                   //                   style: TextStyle(
                    //                                   //                     fontSize: 16,
                    //                                   //                     fontWeight:
                    //                                   //                         FontWeight.w600,
                    //                                   //                     color: Colors.white,
                    //                                   //                   ),
                    //                                   //                 ),
                    //                                   //               ),
                    //                                   //   ),
                    //                                   // ),
                    //                                   const SizedBox(
                    //                                     height: 16,
                    //                                   ),
                    //                                   // SingleButton(
                    //                                   //   btnName: 'Add',
                    //                                   //   onTap: () {
                    //                                   // accountController
                    //                                   //     .storeEducationInfo(context);

                    //                                   //   },
                    //                                   // )
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           )

                    //                        ]))
                    //                   ],
                    //                 ),
                    //               );
                    //             }

                    //             ),
                  ),
                ),
              ),
              // Positioned(
              //   top: MediaQuery.of(context).size.height *
              //       0.14, // Adjust as per your design
              //   left: (MediaQuery.of(context).size.width / 2) - 30,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       // Adjust as per your design
              //       Text(
              //         '${accountController.userProfileResponse.value.data!.rolesId!.roleName ?? ""}',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),

              //       Text(
              //         '${accountController.userProfileResponse.value.data!.wowId!}',
              //         style: TextStyle(
              //           color: AppConstants.secondaryColor,
              //           fontSize: 16,
              //         ),
              //       ),
              //     ],
              //   ),

              //   // ),
              // ),
            ],
          );
        })

        //    Stack(
        //     children: [
        //       ClipPath(
        //         clipper: HemisphereClipper(),
        //         child: Container(
        //           height: 150,
        //           width: MediaQuery.sizeOf(context).width,
        //           color: Colors.purple,
        //           child: const Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               // Adjust as per your design
        //               Text(
        //                 'John Deo,',
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 24,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //               Text(
        //                 'Wow ID: TS91000145269',
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 16,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding:
        //             EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 12),
        //           child: Card(
        //             elevation: 10,
        //             shadowColor: Colors.black,
        //             surfaceTintColor: Colors.white,
        //             color: Colors.white,
        //             child: Container(
        //                 height: accountController.currentTabIndex.value == 0
        //                     ? MediaQuery.of(context).size.height * 0.7
        //                     : MediaQuery.of(context).size.height * 0.7,
        //                 width: MediaQuery.sizeOf(context).width,
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(8.0),
        //                   color: Colors.white,
        //                 ),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     SizedBox(
        //                       height: MediaQuery.of(context).size.height * 0.05,
        //                     ),
        //                     TabBar(
        //                       //isScrollable: true, // Allow tabs to be scrollable to show the full text
        //                       dragStartBehavior: DragStartBehavior.down,
        //                       controller: accountController.tabController,
        //                       onTap: (int index) {
        //                         accountController.currentTabIndex.value = index;
        //                         accountController.isLoading.value = false;
        //                       },
        //                       tabs: const [
        //                         Tab(
        //                           text: 'Personal info',
        //                         ),
        //                         Tab(
        //                           text: 'Address info',
        //                         ),
        //                         Tab(
        //                           text: 'Education info',
        //                         ),
        //                       ],
        //                       unselectedLabelColor: Colors.grey,
        //                       unselectedLabelStyle: const TextStyle(
        //                         fontSize: 14,
        //                         fontWeight: FontWeight.w500,
        //                       ),
        //                       labelStyle: const TextStyle(
        //                         fontSize: 14,
        //                         fontWeight: FontWeight.w500,
        //                         color: Colors.black,
        //                       ),
        //                     ),
        //                        const SizedBox(height: 20),
        //                        Expanded(child:

        //                        TabBarView(

        //                            controller: accountController.tabController,
        //                         children: [
        //                         //personal tab
        //                           Container(
        //                             padding:
        //                                 const EdgeInsets.symmetric(horizontal: 12),
        //                             child: SingleChildScrollView(
        //                               child: Column(
        //                                 mainAxisAlignment: MainAxisAlignment.start,
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: [
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'Name',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   Container(
        //                                     decoration: BoxDecoration(
        //                                         borderRadius:
        //                                             BorderRadius.circular(12),
        //                                         color: Colors.grey.shade200),
        //                                     child: Row(
        //                                       children: [
        //                                         Expanded(
        //                                           child: InputTextField(
        //                                               suffix: false,
        //                                               readonly: false,
        //                                               hintText: 'First',
        //                                               keyboardType:
        //                                                   TextInputType.name,
        //                                               inputFormatter: [
        //                                                 FilteringTextInputFormatter
        //                                                     .allow(
        //                                                   RegExp(
        //                                                     r"[a-zA-Z0-9\s@&_,-\.']",
        //                                                   ),
        //                                                 ),
        //                                               ],
        //                                               controller: accountController
        //                                                   .firstNameController),
        //                                         ),
        //                                         Container(
        //                                           height: 30,
        //                                           width: 1,
        //                                           color:
        //                                               Colors.black.withOpacity(0.2),
        //                                         ),
        //                                         Expanded(
        //                                           child: InputTextField(
        //                                             suffix: false,
        //                                             readonly: false,
        //                                             hintText: 'Last',
        //                                             keyboardType:
        //                                                 TextInputType.name,
        //                                             inputFormatter: [
        //                                               FilteringTextInputFormatter
        //                                                   .allow(
        //                                                 RegExp(
        //                                                   r"[a-zA-Z0-9\s@&_,-\.']",
        //                                                 ),
        //                                               ),
        //                                             ],
        //                                             controller: accountController
        //                                                 .lastNameController,
        //                                           ),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'Email',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   InputTextField(
        //                                       suffix: false,
        //                                       readonly: false,
        //                                       inputFormatter: [
        //                                         FilteringTextInputFormatter.allow(
        //                                           RegExp(
        //                                             r"[a-zA-Z0-9@&_,-\.']",
        //                                           ),
        //                                         ),
        //                                       ],
        //                                       hintText: 'Enter your email',
        //                                       keyboardType:
        //                                           TextInputType.emailAddress,
        //                                       controller: accountController
        //                                           .emailController),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'Date of birth',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   InputTextField(
        //                                       suffix: true,
        //                                       readonly: true,
        //                                       isDate: true,
        //                                       hintText: 'Enter your dob',
        //                                       initialDate: DateTime.now().subtract(
        //                                         const Duration(days: 365 * 18),
        //                                       ),
        //                                       lastDate: DateTime.now().subtract(
        //                                         const Duration(days: 365 * 18),
        //                                       ),
        //                                       keyboardType: TextInputType.datetime,
        //                                       controller:
        //                                           accountController.dobController),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'Phone number',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   InputTextField(
        //                                       suffix: false,
        //                                       readonly: false,
        //                                       hintText: 'Enter your phone number',
        //                                       keyboardType: TextInputType.phone,
        //                                       inputFormatter: [
        //                                         FilteringTextInputFormatter.allow(
        //                                           RegExp(r"[0-9]"),
        //                                         ),
        //                                         LengthLimitingTextInputFormatter(
        //                                             10), // Restrict to 10 digits
        //                                       ],
        //                                       controller:
        //                                           accountController.phController),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'Pincode',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   InputTextField(
        //                                     suffix: false,
        //                                     readonly: false,
        //                                     hintText: 'Enter your pincode',
        //                                     inputFormatter: [
        //                                       FilteringTextInputFormatter.allow(
        //                                         RegExp(
        //                                           r"[0-9]",
        //                                         ),
        //                                       ),
        //                                       LengthLimitingTextInputFormatter(6),
        //                                     ],
        //                                     keyboardType: TextInputType.number,
        //                                     controller:
        //                                         accountController.pincodeController,
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'ID Proof',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   InkWell(
        //                                     onTap: () {
        //                                       // print("gretting values==");
        //                                       // ModalService.openIDProofModalSheet(
        //                                       //     context,
        //                                       //     splashController,
        //                                       //     accountController);
        //                                     },
        //                                     child: Container(
        //                                       height: 55,
        //                                       alignment: Alignment.centerLeft,
        //                                       padding: const EdgeInsets.only(
        //                                           top: 10, bottom: 10, left: 12),
        //                                       decoration: BoxDecoration(
        //                                           color: Colors.grey[200],
        //                                           borderRadius:
        //                                               BorderRadius.circular(15)),
        //                                       child: accountController
        //                                               .selectedIDProof
        //                                               .value
        //                                               .isNotEmpty
        //                                           ? Text(accountController
        //                                               .selectedIDProof.value)
        //                                           : Text(
        //                                               "Tap to select the ID proof",
        //                                               style: TextStyle(
        //                                                   color: Colors.grey[400],
        //                                                   fontWeight:
        //                                                       FontWeight.w400)),
        //                                     ),
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 16,
        //                                   ),
        //                                   // InkWell(
        //                                   //   onTap: () {
        //                                   //     // accountController.storePersonalInfo(
        //                                   //     //     context, roleId, roleTypeId);
        //                                   //   },
        //                                   //   child: Container(
        //                                   //     height: 48,
        //                                   //     padding: const EdgeInsets.symmetric(
        //                                   //       horizontal: 40,
        //                                   //       vertical: 12,
        //                                   //     ),
        //                                   //     decoration: const BoxDecoration(
        //                                   //       borderRadius: BorderRadius.all(
        //                                   //         Radius.circular(8),
        //                                   //       ),
        //                                   //       gradient: LinearGradient(
        //                                   //         colors: [
        //                                   //           Color(0xFFC13584),
        //                                   //           Color(0xFF833AB4)
        //                                   //         ],
        //                                   //         begin: Alignment.topCenter,
        //                                   //         end: Alignment.bottomCenter,
        //                                   //       ),
        //                                   //     ),
        //                                   //     child:
        //                                   //         accountController.isLoading.value
        //                                   //             ? const Center(
        //                                   //                 child:
        //                                   //                     CircularProgressIndicator(),
        //                                   //               )
        //                                   //             : const Center(
        //                                   //                 child: Text(
        //                                   //                   'Next',
        //                                   //                   style: TextStyle(
        //                                   //                     fontSize: 16,
        //                                   //                     fontWeight:
        //                                   //                         FontWeight.w600,
        //                                   //                     color: Colors.white,
        //                                   //                   ),
        //                                   //                 ),
        //                                   //               ),
        //                                   //   ),
        //                                   // ),
        //                                   // const SizedBox(
        //                                   //   height: 16,
        //                                   // ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ),

        // //address info
        //                           Container(
        //                             padding:
        //                                 const EdgeInsets.symmetric(horizontal: 12),
        //                             child: SingleChildScrollView(
        //                               child: Column(
        //                                 mainAxisAlignment: MainAxisAlignment.start,
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: [
        //                                   const SizedBox(
        //                                     height: 5,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'Address1',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   InputTextField(
        //                                       suffix: false,
        //                                       readonly: false,
        //                                       hintText: 'Enter your address',
        //                                       keyboardType: TextInputType.name,
        //                                       controller: accountController
        //                                           .address1Controller),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'Address2',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   InputTextField(
        //                                       suffix: false,
        //                                       readonly: false,
        //                                       hintText: 'Enter your address',
        //                                       keyboardType: TextInputType.name,
        //                                       controller: accountController
        //                                           .address2Controller),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'City',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   InputTextField(
        //                                       suffix: false,
        //                                       readonly: false,
        //                                       hintText: 'Enter your city',
        //                                       keyboardType: TextInputType.name,
        //                                       controller:
        //                                           accountController.cityController),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'State',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   InputTextField(
        //                                       suffix: false,
        //                                       readonly: false,
        //                                       hintText: 'Enter your state',
        //                                       keyboardType: TextInputType.text,
        //                                       controller: accountController
        //                                           .stateController),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'Country',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   InputTextField(
        //                                     suffix: false,
        //                                     readonly: false,
        //                                     hintText: 'Enter your country',
        //                                     keyboardType: TextInputType.name,
        //                                     controller:
        //                                         accountController.countryController,
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   Row(
        //                                     children: [
        //                                       const Text(
        //                                         'Pincode',
        //                                         style: TextStyle(
        //                                           fontSize: 14,
        //                                           fontWeight: FontWeight.w500,
        //                                           color: Colors.black,
        //                                         ),
        //                                       ),
        //                                       Text(
        //                                         '*',
        //                                         style: GoogleFonts.nunito(
        //                                           fontSize: 18,
        //                                           fontWeight: FontWeight.w600,
        //                                           color:
        //                                               Colors.red.withOpacity(0.6),
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   const SizedBox(
        //                                     height: 10,
        //                                   ),
        //                                   InputTextField(
        //                                     suffix: false,
        //                                     readonly: false,
        //                                     hintText: 'Enter pincode',
        //                                     keyboardType: TextInputType.number,
        //                                     controller: accountController
        //                                         .pincodesController,
        //                                     inputFormatter: [
        //                                       FilteringTextInputFormatter.allow(
        //                                         RegExp(
        //                                           r"[0-9]",
        //                                         ),
        //                                       ),
        //                                       LengthLimitingTextInputFormatter(6),
        //                                     ],
        //                                   ),
        //                                   // const SizedBox(
        //                                   //   height: 16,
        //                                   // ),
        //                                   // InkWell(
        //                                   //   onTap: () {
        //                                   //     // accountController
        //                                   //     //     .storeAddressInfo(context);
        //                                   //   },
        //                                   //   child: Container(
        //                                   //     height: 48,
        //                                   //     padding: const EdgeInsets.symmetric(
        //                                   //       horizontal: 40,
        //                                   //       vertical: 12,
        //                                   //     ),
        //                                   //     decoration: const BoxDecoration(
        //                                   //       borderRadius: BorderRadius.all(
        //                                   //         Radius.circular(8),
        //                                   //       ),
        //                                   //       gradient: LinearGradient(
        //                                   //         colors: [
        //                                   //           Color(0xFFC13584),
        //                                   //           Color(0xFF833AB4)
        //                                   //         ],
        //                                   //         begin: Alignment.topCenter,
        //                                   //         end: Alignment.bottomCenter,
        //                                   //       ),
        //                                   //     ),
        //                                   //     child:
        //                                   //         accountController.isLoading.value
        //                                   //             ? const Center(
        //                                   //                 child:
        //                                   //                     CircularProgressIndicator(),
        //                                   //               )
        //                                   //             : const Center(
        //                                   //                 child: Text(
        //                                   //                   'Next',
        //                                   //                   style: TextStyle(
        //                                   //                     fontSize: 16,
        //                                   //                     fontWeight:
        //                                   //                         FontWeight.w600,
        //                                   //                     color: Colors.white,
        //                                   //                   ),
        //                                   //                 ),
        //                                   //               ),
        //                                   //   ),
        //                                   // ),
        //                                   const SizedBox(
        //                                     height: 16,
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ),

        //                             Container(
        //                             padding: EdgeInsets.symmetric(horizontal: 12),
        //                             child: SingleChildScrollView(
        //                               child: Column(
        //                                 mainAxisAlignment: MainAxisAlignment.start,
        //                                 crossAxisAlignment:
        //                                     CrossAxisAlignment.start,
        //                                 children: [
        //                                   ..._buildDropdowns(),
        //                                   Padding(
        //                                     padding:
        //                                         EdgeInsets.symmetric(vertical: 10),
        //                                     child: Column(
        //                                       crossAxisAlignment:
        //                                           CrossAxisAlignment.start,
        //                                       children: [
        //                                         const Text(
        //                                           'Additional Info',
        //                                           style: TextStyle(
        //                                             fontSize: 14,
        //                                             fontWeight: FontWeight.w500,
        //                                             color: Colors.black,
        //                                           ),
        //                                         ),
        //                                         const SizedBox(
        //                                           height: 5,
        //                                         ),
        //                                         CommonInputField(
        //                                           label: 'Additional Info',
        //                                           controllerValue: accountController
        //                                               .additionalInfo,
        //                                           onTap: () {},
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                   // _buildFileUploadSection(
        //                                   //     'Attach Resume', 'resume'),
        //                                   // _buildFileUploadSection(
        //                                   //     'Attach Education Certificate',
        //                                   //     'education'),
        //                                   // _buildFileUploadSection(
        //                                   //     'Attach Experience Certificate',
        //                                   //     'experience'),
        //                                   // if (accountController
        //                                   //     .validationMessages.isNotEmpty)
        //                                   //   Column(
        //                                   //     children: accountController
        //                                   //         .validationMessages
        //                                   //         .map((msg) => Text(
        //                                   //               msg,
        //                                   //               style: TextStyle(
        //                                   //                   color: Colors.red),
        //                                   //             ))
        //                                   //         .toList(),
        //                                   //   ),
        //                                   // InkWell(
        //                                   //   onTap: () {
        //                                   //     // accountController.storeEducationInfo(
        //                                   //     //     context, roleId, roleTypeId);
        //                                   //   },
        //                                   //   child: Container(
        //                                   //     height: 48,
        //                                   //     padding: const EdgeInsets.symmetric(
        //                                   //       horizontal: 40,
        //                                   //       vertical: 12,
        //                                   //     ),
        //                                   //     decoration: const BoxDecoration(
        //                                   //       borderRadius: BorderRadius.all(
        //                                   //         Radius.circular(8),
        //                                   //       ),
        //                                   //       gradient: LinearGradient(
        //                                   //         colors: [
        //                                   //           Color(0xFFC13584),
        //                                   //           Color(0xFF833AB4)
        //                                   //         ],
        //                                   //         begin: Alignment.topCenter,
        //                                   //         end: Alignment.bottomCenter,
        //                                   //       ),
        //                                   //     ),
        //                                   //     child:
        //                                   //         accountController.isLoading.value
        //                                   //             ? const Center(
        //                                   //                 child:
        //                                   //                     CircularProgressIndicator(),
        //                                   //               )
        //                                   //             : const Center(
        //                                   //                 child: Text(
        //                                   //                   'Next',
        //                                   //                   style: TextStyle(
        //                                   //                     fontSize: 16,
        //                                   //                     fontWeight:
        //                                   //                         FontWeight.w600,
        //                                   //                     color: Colors.white,
        //                                   //                   ),
        //                                   //                 ),
        //                                   //               ),
        //                                   //   ),
        //                                   // ),
        //                                   const SizedBox(
        //                                     height: 16,
        //                                   ),
        //                                   // SingleButton(
        //                                   //   btnName: 'Add',
        //                                   //   onTap: () {
        //                                   // accountController
        //                                   //     .storeEducationInfo(context);

        //                                   //   },
        //                                   // )
        //                                 ],
        //                               ),
        //                             ),
        //                           )

        //                        ]))
        //                   ],
        //                 ),
        //               ),
        // //             child: Obx(() {
        // //               return Container(
        // //                 height: accountController.currentTabIndex.value == 0
        // //                     ? MediaQuery.of(context).size.height * 0.7
        // //                     : MediaQuery.of(context).size.height * 0.7,
        // //                 width: MediaQuery.sizeOf(context).width,
        // //                 decoration: BoxDecoration(
        // //                   borderRadius: BorderRadius.circular(8.0),
        // //                   color: Colors.white,
        // //                 ),
        // //                 child: Column(
        // //                   mainAxisAlignment: MainAxisAlignment.start,
        // //                   children: [
        // //                     SizedBox(
        // //                       height: MediaQuery.of(context).size.height * 0.05,
        // //                     ),
        // //                     TabBar(
        // //                       //isScrollable: true, // Allow tabs to be scrollable to show the full text
        // //                       dragStartBehavior: DragStartBehavior.down,
        // //                       controller: accountController.tabController,
        // //                       onTap: (int index) {
        // //                         accountController.currentTabIndex.value = index;
        // //                         accountController.isLoading.value = false;
        // //                       },
        // //                       tabs: const [
        // //                         Tab(
        // //                           text: 'Personal info',
        // //                         ),
        // //                         Tab(
        // //                           text: 'Address info',
        // //                         ),
        // //                         Tab(
        // //                           text: 'Education info',
        // //                         ),
        // //                       ],
        // //                       unselectedLabelColor: Colors.grey,
        // //                       unselectedLabelStyle: const TextStyle(
        // //                         fontSize: 14,
        // //                         fontWeight: FontWeight.w500,
        // //                       ),
        // //                       labelStyle: const TextStyle(
        // //                         fontSize: 14,
        // //                         fontWeight: FontWeight.w500,
        // //                         color: Colors.black,
        // //                       ),
        // //                     ),
        // //                        const SizedBox(height: 20),
        // //                        Expanded(child:

        // //                        TabBarView(

        // //                            controller: accountController.tabController,
        // //                         children: [
        // //                         //personal tab
        // //                           Container(
        // //                             padding:
        // //                                 const EdgeInsets.symmetric(horizontal: 12),
        // //                             child: SingleChildScrollView(
        // //                               child: Column(
        // //                                 mainAxisAlignment: MainAxisAlignment.start,
        // //                                 crossAxisAlignment:
        // //                                     CrossAxisAlignment.start,
        // //                                 children: [
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'Name',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   Container(
        // //                                     decoration: BoxDecoration(
        // //                                         borderRadius:
        // //                                             BorderRadius.circular(12),
        // //                                         color: Colors.grey.shade200),
        // //                                     child: Row(
        // //                                       children: [
        // //                                         Expanded(
        // //                                           child: InputTextField(
        // //                                               suffix: false,
        // //                                               readonly: false,
        // //                                               hintText: 'First',
        // //                                               keyboardType:
        // //                                                   TextInputType.name,
        // //                                               inputFormatter: [
        // //                                                 FilteringTextInputFormatter
        // //                                                     .allow(
        // //                                                   RegExp(
        // //                                                     r"[a-zA-Z0-9\s@&_,-\.']",
        // //                                                   ),
        // //                                                 ),
        // //                                               ],
        // //                                               controller: accountController
        // //                                                   .firstNameController),
        // //                                         ),
        // //                                         Container(
        // //                                           height: 30,
        // //                                           width: 1,
        // //                                           color:
        // //                                               Colors.black.withOpacity(0.2),
        // //                                         ),
        // //                                         Expanded(
        // //                                           child: InputTextField(
        // //                                             suffix: false,
        // //                                             readonly: false,
        // //                                             hintText: 'Last',
        // //                                             keyboardType:
        // //                                                 TextInputType.name,
        // //                                             inputFormatter: [
        // //                                               FilteringTextInputFormatter
        // //                                                   .allow(
        // //                                                 RegExp(
        // //                                                   r"[a-zA-Z0-9\s@&_,-\.']",
        // //                                                 ),
        // //                                               ),
        // //                                             ],
        // //                                             controller: accountController
        // //                                                 .lastNameController,
        // //                                           ),
        // //                                         ),
        // //                                       ],
        // //                                     ),
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'Email',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   InputTextField(
        // //                                       suffix: false,
        // //                                       readonly: false,
        // //                                       inputFormatter: [
        // //                                         FilteringTextInputFormatter.allow(
        // //                                           RegExp(
        // //                                             r"[a-zA-Z0-9@&_,-\.']",
        // //                                           ),
        // //                                         ),
        // //                                       ],
        // //                                       hintText: 'Enter your email',
        // //                                       keyboardType:
        // //                                           TextInputType.emailAddress,
        // //                                       controller: accountController
        // //                                           .emailController),
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'Date of birth',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   InputTextField(
        // //                                       suffix: true,
        // //                                       readonly: true,
        // //                                       isDate: true,
        // //                                       hintText: 'Enter your dob',
        // //                                       initialDate: DateTime.now().subtract(
        // //                                         const Duration(days: 365 * 18),
        // //                                       ),
        // //                                       lastDate: DateTime.now().subtract(
        // //                                         const Duration(days: 365 * 18),
        // //                                       ),
        // //                                       keyboardType: TextInputType.datetime,
        // //                                       controller:
        // //                                           accountController.dobController),
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'Phone number',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   InputTextField(
        // //                                       suffix: false,
        // //                                       readonly: false,
        // //                                       hintText: 'Enter your phone number',
        // //                                       keyboardType: TextInputType.phone,
        // //                                       inputFormatter: [
        // //                                         FilteringTextInputFormatter.allow(
        // //                                           RegExp(r"[0-9]"),
        // //                                         ),
        // //                                         LengthLimitingTextInputFormatter(
        // //                                             10), // Restrict to 10 digits
        // //                                       ],
        // //                                       controller:
        // //                                           accountController.phController),
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'Pincode',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   InputTextField(
        // //                                     suffix: false,
        // //                                     readonly: false,
        // //                                     hintText: 'Enter your pincode',
        // //                                     inputFormatter: [
        // //                                       FilteringTextInputFormatter.allow(
        // //                                         RegExp(
        // //                                           r"[0-9]",
        // //                                         ),
        // //                                       ),
        // //                                       LengthLimitingTextInputFormatter(6),
        // //                                     ],
        // //                                     keyboardType: TextInputType.number,
        // //                                     controller:
        // //                                         accountController.pincodeController,
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'ID Proof',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   InkWell(
        // //                                     onTap: () {
        // //                                       // print("gretting values==");
        // //                                       // ModalService.openIDProofModalSheet(
        // //                                       //     context,
        // //                                       //     splashController,
        // //                                       //     accountController);
        // //                                     },
        // //                                     child: Container(
        // //                                       height: 55,
        // //                                       alignment: Alignment.centerLeft,
        // //                                       padding: const EdgeInsets.only(
        // //                                           top: 10, bottom: 10, left: 12),
        // //                                       decoration: BoxDecoration(
        // //                                           color: Colors.grey[200],
        // //                                           borderRadius:
        // //                                               BorderRadius.circular(15)),
        // //                                       child: accountController
        // //                                               .selectedIDProof
        // //                                               .value
        // //                                               .isNotEmpty
        // //                                           ? Text(accountController
        // //                                               .selectedIDProof.value)
        // //                                           : Text(
        // //                                               "Tap to select the ID proof",
        // //                                               style: TextStyle(
        // //                                                   color: Colors.grey[400],
        // //                                                   fontWeight:
        // //                                                       FontWeight.w400)),
        // //                                     ),
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 16,
        // //                                   ),
        // //                                   // InkWell(
        // //                                   //   onTap: () {
        // //                                   //     // accountController.storePersonalInfo(
        // //                                   //     //     context, roleId, roleTypeId);
        // //                                   //   },
        // //                                   //   child: Container(
        // //                                   //     height: 48,
        // //                                   //     padding: const EdgeInsets.symmetric(
        // //                                   //       horizontal: 40,
        // //                                   //       vertical: 12,
        // //                                   //     ),
        // //                                   //     decoration: const BoxDecoration(
        // //                                   //       borderRadius: BorderRadius.all(
        // //                                   //         Radius.circular(8),
        // //                                   //       ),
        // //                                   //       gradient: LinearGradient(
        // //                                   //         colors: [
        // //                                   //           Color(0xFFC13584),
        // //                                   //           Color(0xFF833AB4)
        // //                                   //         ],
        // //                                   //         begin: Alignment.topCenter,
        // //                                   //         end: Alignment.bottomCenter,
        // //                                   //       ),
        // //                                   //     ),
        // //                                   //     child:
        // //                                   //         accountController.isLoading.value
        // //                                   //             ? const Center(
        // //                                   //                 child:
        // //                                   //                     CircularProgressIndicator(),
        // //                                   //               )
        // //                                   //             : const Center(
        // //                                   //                 child: Text(
        // //                                   //                   'Next',
        // //                                   //                   style: TextStyle(
        // //                                   //                     fontSize: 16,
        // //                                   //                     fontWeight:
        // //                                   //                         FontWeight.w600,
        // //                                   //                     color: Colors.white,
        // //                                   //                   ),
        // //                                   //                 ),
        // //                                   //               ),
        // //                                   //   ),
        // //                                   // ),
        // //                                   // const SizedBox(
        // //                                   //   height: 16,
        // //                                   // ),
        // //                                 ],
        // //                               ),
        // //                             ),
        // //                           ),

        // // //address info
        // //                           Container(
        // //                             padding:
        // //                                 const EdgeInsets.symmetric(horizontal: 12),
        // //                             child: SingleChildScrollView(
        // //                               child: Column(
        // //                                 mainAxisAlignment: MainAxisAlignment.start,
        // //                                 crossAxisAlignment:
        // //                                     CrossAxisAlignment.start,
        // //                                 children: [
        // //                                   const SizedBox(
        // //                                     height: 5,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'Address1',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   InputTextField(
        // //                                       suffix: false,
        // //                                       readonly: false,
        // //                                       hintText: 'Enter your address',
        // //                                       keyboardType: TextInputType.name,
        // //                                       controller: accountController
        // //                                           .address1Controller),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'Address2',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   InputTextField(
        // //                                       suffix: false,
        // //                                       readonly: false,
        // //                                       hintText: 'Enter your address',
        // //                                       keyboardType: TextInputType.name,
        // //                                       controller: accountController
        // //                                           .address2Controller),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'City',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   InputTextField(
        // //                                       suffix: false,
        // //                                       readonly: false,
        // //                                       hintText: 'Enter your city',
        // //                                       keyboardType: TextInputType.name,
        // //                                       controller:
        // //                                           accountController.cityController),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'State',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   InputTextField(
        // //                                       suffix: false,
        // //                                       readonly: false,
        // //                                       hintText: 'Enter your state',
        // //                                       keyboardType: TextInputType.text,
        // //                                       controller: accountController
        // //                                           .stateController),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'Country',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   InputTextField(
        // //                                     suffix: false,
        // //                                     readonly: false,
        // //                                     hintText: 'Enter your country',
        // //                                     keyboardType: TextInputType.name,
        // //                                     controller:
        // //                                         accountController.countryController,
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   Row(
        // //                                     children: [
        // //                                       const Text(
        // //                                         'Pincode',
        // //                                         style: TextStyle(
        // //                                           fontSize: 14,
        // //                                           fontWeight: FontWeight.w500,
        // //                                           color: Colors.black,
        // //                                         ),
        // //                                       ),
        // //                                       Text(
        // //                                         '*',
        // //                                         style: GoogleFonts.nunito(
        // //                                           fontSize: 18,
        // //                                           fontWeight: FontWeight.w600,
        // //                                           color:
        // //                                               Colors.red.withOpacity(0.6),
        // //                                         ),
        // //                                       ),
        // //                                     ],
        // //                                   ),
        // //                                   const SizedBox(
        // //                                     height: 10,
        // //                                   ),
        // //                                   InputTextField(
        // //                                     suffix: false,
        // //                                     readonly: false,
        // //                                     hintText: 'Enter pincode',
        // //                                     keyboardType: TextInputType.number,
        // //                                     controller: accountController
        // //                                         .pincodesController,
        // //                                     inputFormatter: [
        // //                                       FilteringTextInputFormatter.allow(
        // //                                         RegExp(
        // //                                           r"[0-9]",
        // //                                         ),
        // //                                       ),
        // //                                       LengthLimitingTextInputFormatter(6),
        // //                                     ],
        // //                                   ),
        // //                                   // const SizedBox(
        // //                                   //   height: 16,
        // //                                   // ),
        // //                                   // InkWell(
        // //                                   //   onTap: () {
        // //                                   //     // accountController
        // //                                   //     //     .storeAddressInfo(context);
        // //                                   //   },
        // //                                   //   child: Container(
        // //                                   //     height: 48,
        // //                                   //     padding: const EdgeInsets.symmetric(
        // //                                   //       horizontal: 40,
        // //                                   //       vertical: 12,
        // //                                   //     ),
        // //                                   //     decoration: const BoxDecoration(
        // //                                   //       borderRadius: BorderRadius.all(
        // //                                   //         Radius.circular(8),
        // //                                   //       ),
        // //                                   //       gradient: LinearGradient(
        // //                                   //         colors: [
        // //                                   //           Color(0xFFC13584),
        // //                                   //           Color(0xFF833AB4)
        // //                                   //         ],
        // //                                   //         begin: Alignment.topCenter,
        // //                                   //         end: Alignment.bottomCenter,
        // //                                   //       ),
        // //                                   //     ),
        // //                                   //     child:
        // //                                   //         accountController.isLoading.value
        // //                                   //             ? const Center(
        // //                                   //                 child:
        // //                                   //                     CircularProgressIndicator(),
        // //                                   //               )
        // //                                   //             : const Center(
        // //                                   //                 child: Text(
        // //                                   //                   'Next',
        // //                                   //                   style: TextStyle(
        // //                                   //                     fontSize: 16,
        // //                                   //                     fontWeight:
        // //                                   //                         FontWeight.w600,
        // //                                   //                     color: Colors.white,
        // //                                   //                   ),
        // //                                   //                 ),
        // //                                   //               ),
        // //                                   //   ),
        // //                                   // ),
        // //                                   const SizedBox(
        // //                                     height: 16,
        // //                                   ),
        // //                                 ],
        // //                               ),
        // //                             ),
        // //                           ),

        // //                             Container(
        // //                             padding: EdgeInsets.symmetric(horizontal: 12),
        // //                             child: SingleChildScrollView(
        // //                               child: Column(
        // //                                 mainAxisAlignment: MainAxisAlignment.start,
        // //                                 crossAxisAlignment:
        // //                                     CrossAxisAlignment.start,
        // //                                 children: [
        // //                                   ..._buildDropdowns(),
        // //                                   Padding(
        // //                                     padding:
        // //                                         EdgeInsets.symmetric(vertical: 10),
        // //                                     child: Column(
        // //                                       crossAxisAlignment:
        // //                                           CrossAxisAlignment.start,
        // //                                       children: [
        // //                                         const Text(
        // //                                           'Additional Info',
        // //                                           style: TextStyle(
        // //                                             fontSize: 14,
        // //                                             fontWeight: FontWeight.w500,
        // //                                             color: Colors.black,
        // //                                           ),
        // //                                         ),
        // //                                         const SizedBox(
        // //                                           height: 5,
        // //                                         ),
        // //                                         CommonInputField(
        // //                                           label: 'Additional Info',
        // //                                           controllerValue: accountController
        // //                                               .additionalInfo,
        // //                                           onTap: () {},
        // //                                         ),
        // //                                       ],
        // //                                     ),
        // //                                   ),
        // //                                   // _buildFileUploadSection(
        // //                                   //     'Attach Resume', 'resume'),
        // //                                   // _buildFileUploadSection(
        // //                                   //     'Attach Education Certificate',
        // //                                   //     'education'),
        // //                                   // _buildFileUploadSection(
        // //                                   //     'Attach Experience Certificate',
        // //                                   //     'experience'),
        // //                                   // if (accountController
        // //                                   //     .validationMessages.isNotEmpty)
        // //                                   //   Column(
        // //                                   //     children: accountController
        // //                                   //         .validationMessages
        // //                                   //         .map((msg) => Text(
        // //                                   //               msg,
        // //                                   //               style: TextStyle(
        // //                                   //                   color: Colors.red),
        // //                                   //             ))
        // //                                   //         .toList(),
        // //                                   //   ),
        // //                                   // InkWell(
        // //                                   //   onTap: () {
        // //                                   //     // accountController.storeEducationInfo(
        // //                                   //     //     context, roleId, roleTypeId);
        // //                                   //   },
        // //                                   //   child: Container(
        // //                                   //     height: 48,
        // //                                   //     padding: const EdgeInsets.symmetric(
        // //                                   //       horizontal: 40,
        // //                                   //       vertical: 12,
        // //                                   //     ),
        // //                                   //     decoration: const BoxDecoration(
        // //                                   //       borderRadius: BorderRadius.all(
        // //                                   //         Radius.circular(8),
        // //                                   //       ),
        // //                                   //       gradient: LinearGradient(
        // //                                   //         colors: [
        // //                                   //           Color(0xFFC13584),
        // //                                   //           Color(0xFF833AB4)
        // //                                   //         ],
        // //                                   //         begin: Alignment.topCenter,
        // //                                   //         end: Alignment.bottomCenter,
        // //                                   //       ),
        // //                                   //     ),
        // //                                   //     child:
        // //                                   //         accountController.isLoading.value
        // //                                   //             ? const Center(
        // //                                   //                 child:
        // //                                   //                     CircularProgressIndicator(),
        // //                                   //               )
        // //                                   //             : const Center(
        // //                                   //                 child: Text(
        // //                                   //                   'Next',
        // //                                   //                   style: TextStyle(
        // //                                   //                     fontSize: 16,
        // //                                   //                     fontWeight:
        // //                                   //                         FontWeight.w600,
        // //                                   //                     color: Colors.white,
        // //                                   //                   ),
        // //                                   //                 ),
        // //                                   //               ),
        // //                                   //   ),
        // //                                   // ),
        // //                                   const SizedBox(
        // //                                     height: 16,
        // //                                   ),
        // //                                   // SingleButton(
        // //                                   //   btnName: 'Add',
        // //                                   //   onTap: () {
        // //                                   // accountController
        // //                                   //     .storeEducationInfo(context);

        // //                                   //   },
        // //                                   // )
        // //                                 ],
        // //                               ),
        // //                             ),
        // //                           )

        // //                        ]))
        // //                   ],
        // //                 ),
        // //               );
        // //             }

        // //             ),
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         top: MediaQuery.of(context).size.height *
        //             0.08, // Adjust as per your design
        //         left: (MediaQuery.of(context).size.width / 2) - 50,
        //         child: const CircleAvatar(
        //           radius: 50,
        //           backgroundImage: AssetImage(
        //             'assets/sidemenu/Ellipse 261.png', // Replace with your image URL
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        );
  }

  List<Widget> _buildDropdowns() {
    print(
        "getting role==>${accountController.userProfileResponse.value.data!.rolesId!.roleName}");
    return [
      if (accountController.userProfileResponse.value.data!.rolesId!.roleName ==
          "Tutee")
        Column(
          children: [..._buildDropdownss()],
        )
      else
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Highest Qualification',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '*',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonDropdownInputField(
                    title: 'Highest qualification',
                    controllerValue: accountController.highestQualification,
                    selectedValue: accountController.highestQualification,
                    items: accountController.qualifications,
                    onChanged: accountController.setHighestQualification,
                    onTap: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Teaching Skill Set',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '*',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonDropdownInputField(
                    title: 'Teaching skill set',
                    controllerValue: accountController.teachingSkills,
                    selectedValue: accountController.teachingSkills,
                    items: accountController.skills,
                    onChanged: accountController.setTeachingSkills,
                    onTap: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Work Type',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '*',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonDropdownInputField(
                    title: 'Work type',
                    controllerValue: accountController.workingTech,
                    selectedValue: accountController.workingTech,
                    items: accountController.techs,
                    onChanged: accountController.setWorkingTech,
                    onTap: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Teaching Experience',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '*',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonDropdownInputField(
                    title: 'Teaching experience',
                    controllerValue: accountController.teachingExperience,
                    selectedValue: accountController.teachingExperience,
                    items: accountController.techsExperience,
                    onChanged: accountController.setTeachingExperience,
                    onTap: false,
                  ),
                ],
              ),
            ),
          ],
        )
    ];
  }

  List<Widget> _buildDropdownss() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Highest Qualification',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '*',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // CommonDropdownInputField(
            //   title: 'Highest qualification',
            //   controllerValue: accountController.highestQualification,
            //   selectedValue: accountController.highestQualification,
            //   items: accountController.qualifications,
            //   onChanged: accountController.setHighestQualification,
            // ),
            InkWell(
                                            onTap: () {
                                               
                                            },
                                            child: Container(
                                              height: 55,
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 12),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: accountController
                                                      .highestQualification
                                                      .value
                                                      .isNotEmpty
                                                  ? Text(accountController
                                                      .highestQualification.value)
                                                  : Text(
                                                      "Tap to select the ID proof",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontWeight:
                                                              FontWeight.w400)),
                                            ),
                                          ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Class/Specialization',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '*',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // CommonDropdownInputField(
            //   title: 'Teaching skill set',
            //   controllerValue: accountController.teachingSkills,
            //   selectedValue: accountController.teachingSkills,
            //   items: accountController.skills,
            //   onChanged: accountController.setTeachingSkills,
            // ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 55,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15)),
                child: accountController.QualificationClass.value.isNotEmpty
                    ? Text(accountController.QualificationClass.value)
                    : Text("Tap to select the ID proof",
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 10),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Row(
      //         children: [
      //           const Text(
      //             'Board',
      //             style: TextStyle(
      //               fontSize: 14,
      //               fontWeight: FontWeight.w500,
      //               color: Colors.black,
      //             ),
      //           ),
      //           Text(
      //             '*',
      //             style: GoogleFonts.nunito(
      //               fontSize: 18,
      //               fontWeight: FontWeight.w600,
      //               color: Colors.red.withOpacity(0.6),
      //             ),
      //           ),
      //         ],
      //       ),
      //       const SizedBox(
      //         height: 5,
      //       ),
      //       // CommonDropdownInputField(
      //       //   title: 'Work type',
      //       //   controllerValue: accountController.workingTech,
      //       //   selectedValue: accountController.workingTech,
      //       //   items: accountController.techs,
      //       //   onChanged: accountController.setWorkingTech,
      //       // ),
      //       InkWell(
      //         onTap: () {},
      //         child: Container(
      //           height: 55,
      //           alignment: Alignment.centerLeft,
      //           padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12),
      //           decoration: BoxDecoration(
      //               color: Colors.grey[200],
      //               borderRadius: BorderRadius.circular(15)),
      //           child: accountController.board.value.isNotEmpty
      //               ? Text(accountController.board.value)
      //               : Text("Tap to select the ID proof",
      //                   style: TextStyle(
      //                       color: Colors.grey[400],
      //                       fontWeight: FontWeight.w400)),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Name of school/college/other',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '*',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // CommonDropdownInputField(
            //   title: 'Teaching experience',
            //   controllerValue: accountController.teachingExperience,
            //   selectedValue: accountController.teachingExperience,
            //   items: accountController.techsExperience,
            //   onChanged: accountController.setTeachingExperience,
            // ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 55,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15)),
                child: accountController.organizationName.value.isNotEmpty
                    ? Text(accountController.organizationName.value)
                    : Text("Tap to select the ID proof",
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    ];
  }
  
}

class HemisphereClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.55);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
