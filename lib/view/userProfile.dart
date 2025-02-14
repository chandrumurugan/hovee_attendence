// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/accountSetup_controller.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/widget/addteacher_dropdown.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/custom_textfield.dart';
import 'package:hovee_attendence/widget/fileUpload.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class UserProfile extends StatelessWidget {
  final String? type;
  UserProfile({super.key, this.type});
  UserProfileController accountController = Get.put(UserProfileController());
  //  final splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    // accountController.dobController.text = DateFormat('dd/MM/yyyy').format(
    //   DateTime.now().subtract(const Duration(days: 365 * 18)),
    // );
    final splashController = Get.find<SplashController>();
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
            return const Center(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 05,
                              ),
                              // Adjust as per your design
                              Text(
                                '${accountController.userProfileResponse.value.data!.rolesId!.roleName!}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: accountController
                                                  .userProfileResponse
                                                  .value
                                                  .data!
                                                  .institudeId !=
                                              null
                                          ? 'Reg no :'
                                          : 'ID : ',
                                      style: const TextStyle(
                                        color: AppConstants.secondaryColor,
                                        fontWeight:
                                            FontWeight.bold, // Bold for "ID"
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${accountController.userProfileResponse.value.data!.wowId!}',
                                      style: const TextStyle(
                                        color: AppConstants
                                            .secondaryColor, // Same color
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
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
                            tabs: [
                              const Tab(
                                text: 'Personal info',
                                // child: Text("Personal info",style: GoogleFonts.nunito(color: Colors.black),textAlign: TextAlign.center,),
                              ),
                              const Tab(
                                text: 'Address info',
                              ),
                              if (accountController.userProfileResponse.value
                                          .data!.rolesId!.roleName !=
                                      "Parent" &&
                                  accountController.userProfileResponse.value
                                          .data!.rolesId!.roleName !=
                                      "Hosteller")
                                Tab(
                                  text: accountController.userProfileResponse
                                              .value.data!.rolesId!.roleName! ==
                                          'Tutee'
                                      ? 'Education info'
                                      : 'Professional info',
                                ),
                            ],
                            unselectedLabelColor: Colors.grey,
                            unselectedLabelStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.030,
                              fontWeight: FontWeight.w500,
                            ),
                            labelStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.030,
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
                                                    readonly: true,
                                                    hintText: 'First',
                                                    keyboardType:
                                                        TextInputType.name,
                                                    inputFormatter: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(
                                                          r"[a-zA-Z0-9\s@&_,-\/.']",
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
                                                  readonly: true,
                                                  hintText: 'Last',
                                                  keyboardType:
                                                      TextInputType.name,
                                                  inputFormatter: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                      RegExp(
                                                        r"[a-zA-Z0-9\s@&_,-\/.']",
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
                                            readonly: accountController
                                                    .isNonEdit.value
                                                ? true
                                                : false,
                                            inputFormatter: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(
                                                  r"[a-zA-Z0-9@&_,-\/.']",
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
                                            suffix:accountController.isNonEdit.value ? false : true,
                                            readonly: accountController.isNonEdit.value ? true :false,
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

                                        SizedBox(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    width: 70,
                                                    height: 53,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xffD9D9D9)
                                                          .withOpacity(0.4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  Text(
                                                    '+91',
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  41,
                                                                  41,
                                                                  41)
                                                              .withOpacity(0.4),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Expanded(
                                                child:
                                                    //  InputTextField(
                                                    //     suffix: false,
                                                    //     readonly: false,
                                                    //     hintText:
                                                    //         'Enter your phone number',
                                                    //     keyboardType:
                                                    //         TextInputType.phone,
                                                    //     inputFormatter: [
                                                    //       FilteringTextInputFormatter
                                                    //           .allow(
                                                    //         RegExp(r"[0-9]"),
                                                    //       ),
                                                    //       LengthLimitingTextInputFormatter(
                                                    //           10), // Restrict to 10 digits
                                                    //     ],
                                                    //     controller:
                                                    //         accountController
                                                    //             .phController),
                                                    InputTextFieldEdit(
                                                  showVerifiedIcon: true,
                                                  isDate: false,
                                                  suffix: accountController
                                                          .isNonEdit.value
                                                      ? false
                                                      : false,
                                                  readonly: true,
                                                  hintText: 'Enter here...',
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  inputFormatter: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r"[0-9]")),
                                                    LengthLimitingTextInputFormatter(
                                                        10), // Restrict to 10 digits
                                                  ],
                                                  controller: accountController
                                                      .phController,
                                                  accountVerified:
                                                      accountController
                                                              .accountVerified ==
                                                          true,
                                                  onVerifiedIconPressed: () {
                                                    showPhoneNumberDialog(
                                                        context);
                                                  },
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
                                          readonly:
                                              accountController.isNonEdit.value
                                                  ? true
                                                  : false,
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
                                        Container(
                                          height: 55,
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10, left: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Text(
                                            accountController.selectedIDProof
                                                    .value.isNotEmpty
                                                ? accountController
                                                    .selectedIDProof.value
                                                : "Tap to select the ID proof",
                                            style: TextStyle(
                                              color: accountController
                                                      .selectedIDProof
                                                      .value
                                                      .isNotEmpty
                                                  ? Colors.black
                                                  : Colors.grey[400],
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     accountController
                                        //         .storePersonalInfo(context);
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
                                        //     child: accountController
                                        //             .isLoading.value
                                        //         ? const Center(
                                        //             child:
                                        //                 CircularProgressIndicator(),
                                        //           )
                                        //         : const Center(
                                        //             child: Text(
                                        //               'Next',
                                        //               style: TextStyle(
                                        //                 fontSize: 16,
                                        //                 fontWeight:
                                        //                     FontWeight.w600,
                                        //                 color: Colors.white,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                //address info
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: CustomScrollView(
                                      slivers: [
                                        SliverToBoxAdapter(
                                          child: Visibility(
                                              visible: accountController
                                                      .isNonEdit.value ==
                                                  false,
                                              child:
                                                  placesAutoCompleteTextField(
                                                      accountController)),
                                        ),
                                        SliverList(
                                            delegate: SliverChildListDelegate([
                                          const SizedBox(height: 10),
                                          Visibility(
                                            visible: accountController
                                                    .isNonEdit.value ==
                                                false,
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              child: GoogleMap(
                                                scrollGesturesEnabled: true,
                                                mapType: MapType.normal,
                                                initialCameraPosition:
                                                    CameraPosition(
                                                  target: LatLng(
                                                      accountController
                                                              .latitudeL
                                                              .value ??
                                                          0.0,
                                                      accountController
                                                              .longitudeL
                                                              .value ??
                                                          0.0),
                                                  zoom: 10,
                                                ),
                                                onMapCreated: accountController
                                                    .onMapCreated,
                                                markers: accountController
                                                            .marker.value !=
                                                        null
                                                    ? {
                                                        accountController
                                                            .marker.value!
                                                      }
                                                    : {},
                                                onTap: (position) {
                                                  accountController
                                                      .setMarker(position);
                                                },
                                                zoomControlsEnabled: false,
                                                gestureRecognizers: Set()
                                                  ..add(Factory<
                                                          EagerGestureRecognizer>(
                                                      () =>
                                                          EagerGestureRecognizer())),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          //                     const SizedBox(
                                          //                                               height: 5,
                                          //                                             ),
                                          //                                               const SizedBox(
                                          //   height: 5,
                                          // ),
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
                                                  color: Colors.red
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InputTextField(
                                              suffix: false,
                                              readonly: accountController
                                                      .isNonEdit.value
                                                  ? true
                                                  : false,
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
                                                'Street/area',
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
                                                  color: Colors.red
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InputTextField(
                                              suffix: false,
                                              readonly: accountController
                                                      .isNonEdit.value
                                                  ? true
                                                  : false,
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
                                                  color: Colors.red
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InputTextField(
                                              suffix: false,
                                              readonly: accountController
                                                      .isNonEdit.value
                                                  ? true
                                                  : false,
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
                                                  color: Colors.red
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InputTextField(
                                              suffix: false,
                                              readonly: accountController
                                                      .isNonEdit.value
                                                  ? true
                                                  : false,
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
                                                  color: Colors.red
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InputTextField(
                                            suffix: false,
                                            readonly: accountController
                                                    .isNonEdit.value
                                                ? true
                                                : false,
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
                                                  color: Colors.red
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InputTextField(
                                            suffix: false,
                                            readonly: accountController
                                                    .isNonEdit.value
                                                ? true
                                                : false,
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
                                              LengthLimitingTextInputFormatter(
                                                  6),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),

                                          const SizedBox(
                                            height: 16,
                                          ),
                                        ]))
                                      ],
                                    )
                                    // SingleChildScrollView(
                                    //   child: Column(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.start,
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     children: [
                                    //       const SizedBox(
                                    //         height: 5,
                                    //       ),
                                    //       Row(
                                    //         children: [
                                    //           const Text(
                                    //             'Door no',
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
                                    //               color:
                                    //                   Colors.red.withOpacity(0.6),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       InputTextField(
                                    //           suffix: false,
                                    //           readonly:
                                    //               accountController.isNonEdit
                                    //                   ? true
                                    //                   : false,
                                    //           hintText: 'Enter your door no',
                                    //           keyboardType: TextInputType.name,
                                    //           controller: accountController
                                    //               .address1Controller),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       Row(
                                    //         children: [
                                    //           const Text(
                                    //             'Street/area',
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
                                    //               color:
                                    //                   Colors.red.withOpacity(0.6),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       InputTextField(
                                    //           suffix: false,
                                    //           readonly:
                                    //               accountController.isNonEdit
                                    //                   ? true
                                    //                   : false,
                                    //           hintText: 'Enter your address',
                                    //           keyboardType: TextInputType.name,
                                    //           controller: accountController
                                    //               .address2Controller),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       Row(
                                    //         children: [
                                    //           const Text(
                                    //             'City',
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
                                    //               color:
                                    //                   Colors.red.withOpacity(0.6),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       InputTextField(
                                    //           suffix: false,
                                    //           readonly:
                                    //               accountController.isNonEdit
                                    //                   ? true
                                    //                   : false,
                                    //           hintText: 'Enter your city',
                                    //           keyboardType: TextInputType.name,
                                    //           controller: accountController
                                    //               .cityController),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       Row(
                                    //         children: [
                                    //           const Text(
                                    //             'State',
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
                                    //               color:
                                    //                   Colors.red.withOpacity(0.6),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       InputTextField(
                                    //           suffix: false,
                                    //           readonly:
                                    //               accountController.isNonEdit
                                    //                   ? true
                                    //                   : false,
                                    //           hintText: 'Enter your state',
                                    //           keyboardType: TextInputType.text,
                                    //           controller: accountController
                                    //               .stateController),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       Row(
                                    //         children: [
                                    //           const Text(
                                    //             'Country',
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
                                    //               color:
                                    //                   Colors.red.withOpacity(0.6),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       InputTextField(
                                    //         suffix: false,
                                    //         readonly: accountController.isNonEdit
                                    //             ? true
                                    //             : false,
                                    //         hintText: 'Enter your country',
                                    //         keyboardType: TextInputType.name,
                                    //         controller: accountController
                                    //             .countryController,
                                    //       ),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       Row(
                                    //         children: [
                                    //           const Text(
                                    //             'Pincode',
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
                                    //               color:
                                    //                   Colors.red.withOpacity(0.6),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       const SizedBox(
                                    //         height: 10,
                                    //       ),
                                    //       InputTextField(
                                    //         suffix: false,
                                    //         readonly: accountController.isNonEdit
                                    //             ? true
                                    //             : false,
                                    //         hintText: 'Enter pincode',
                                    //         keyboardType: TextInputType.number,
                                    //         controller: accountController
                                    //             .pincodesController,
                                    //         inputFormatter: [
                                    //           FilteringTextInputFormatter.allow(
                                    //             RegExp(
                                    //               r"[0-9]",
                                    //             ),
                                    //           ),
                                    //           LengthLimitingTextInputFormatter(6),
                                    //         ],
                                    //       ),
                                    //       const SizedBox(
                                    //         height: 16,
                                    //       ),
                                    //       // InkWell(
                                    //       //   onTap: () {
                                    //       //     accountController.storeAddressInfo(
                                    //       //       context,
                                    //       //       accountController
                                    //       //           .userProfileResponse
                                    //       //           .value
                                    //       //           .data!
                                    //       //           .rolesId!
                                    //       //           .roleName!,
                                    //       //     );
                                    //       //   },
                                    //       //   child: Container(
                                    //       //     height: 48,
                                    //       //     padding: const EdgeInsets.symmetric(
                                    //       //       horizontal: 40,
                                    //       //       vertical: 12,
                                    //       //     ),
                                    //       //     decoration: const BoxDecoration(
                                    //       //       borderRadius: BorderRadius.all(
                                    //       //         Radius.circular(8),
                                    //       //       ),
                                    //       //       gradient: LinearGradient(
                                    //       //         colors: [
                                    //       //           Color(0xFFC13584),
                                    //       //           Color(0xFF833AB4)
                                    //       //         ],
                                    //       //         begin: Alignment.topCenter,
                                    //       //         end: Alignment.bottomCenter,
                                    //       //       ),
                                    //       //     ),
                                    //       //     child: accountController
                                    //       //             .isLoading.value
                                    //       //         ? const Center(
                                    //       //             child:
                                    //       //                 CircularProgressIndicator(),
                                    //       //           )
                                    //       //         : const Center(
                                    //       //             child: Text(
                                    //       //               'Next',
                                    //       //               style: TextStyle(
                                    //       //                 fontSize: 16,
                                    //       //                 fontWeight:
                                    //       //                     FontWeight.w600,
                                    //       //                 color: Colors.white,
                                    //       //               ),
                                    //       //             ),
                                    //       //           ),
                                    //       //   ),
                                    //       // ),
                                    //       const SizedBox(
                                    //         height: 16,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    ),
                                if (type == null && type != "Parent")
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
                                          accountController
                                                      .userProfileResponse
                                                      .value
                                                      .data!
                                                      .rolesId!
                                                      .roleName !=
                                                  'Tutor'
                                              ? _buildDropdowns(context)
                                              : _buildTutor(context),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ]))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
        bottomNavigationBar: GetBuilder<UserProfileController>(
  builder: (controller) {
    return
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              accountController.isNonEdit.value
                  ? _fileUploadBottomModal(context)
                  : _navigationPage(context);
            },
            child: Container(
              height: 48,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: accountController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: Text(
                        accountController.isNonEdit.value ? 'Edit' : 'Update',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
            ),
          ),
        );}));
  }

  Widget _buildDropdowns(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Highest qualification',
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
                items: accountController.tuteeQualifications,
                onChanged: accountController.setHighestQualification,
                isNonEdit: accountController.isNonEdit.value,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                const Text(
                  'Choose a board',
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
            Obx(() => CommonDropdownInputField(
                  title: 'board',
                  controllerValue: accountController.boardController.value.obs,
                  selectedValue: accountController.boardController.value.obs,
                  items: accountController.board1,
                  onChanged: accountController.setBoard,
                  isNonEdit: accountController.isNonEdit.value,
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Select a class',
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
              Obx(() => CommonDropdownInputField(
                    title: 'Class',
                    controllerValue:
                        accountController.classController.value.obs,
                    selectedValue: accountController.classController.value.obs,
                    items: accountController.classList,
                    onChanged: accountController.setClass,
                    isNonEdit: accountController.isNonEdit.value,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Choose a subject',
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
              Obx(() => CommonDropdownInputField(
                    title: 'subject',
                    controllerValue:
                        accountController.subjectController.value.obs,
                    selectedValue:
                        accountController.subjectController.value.obs,
                    items: accountController.subject,
                    onChanged: accountController.setSubject,
                    isNonEdit: accountController.isNonEdit.value,
                  )),
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
                    'Name of school/college',
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
              InputTextField(
                suffix: false,
                readonly: accountController.isNonEdit.value ? true : false,
                hintText: 'Enter your country',
                keyboardType: TextInputType.name,
                controller: accountController.tuteorganizationController,
              ),
              const SizedBox(
                height: 25,
              ),
              // Comm
              // InkWell(
              //   onTap: () {
              //     accountController.storeTuteeeducationInfo(context);
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
              //         colors: [Color(0xFFC13584), Color(0xFF833AB4)],
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //       ),
              //     ),
              //     child: accountController.isLoading.value
              //         ? const Center(
              //             child: CircularProgressIndicator(),
              //           )
              //         : const Center(
              //             child: Text(
              //               'Next',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTutor(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Highest qualification',
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
                isNonEdit: accountController.isNonEdit.value,
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
                    'Teaching skill set',
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
                isNonEdit: accountController.isNonEdit.value,
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
                    'Work type',
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
                isNonEdit: accountController.isNonEdit.value,
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
                    'Teaching experience',
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
                isNonEdit: accountController.isNonEdit.value,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tution name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              if (accountController.validationMessages.isNotEmpty)
                Column(
                  children: accountController.validationMessages
                      .map((msg) => Text(
                            msg,
                            style: const TextStyle(color: Colors.red),
                          ))
                      .toList(),
                ),
              InputTextField(
                suffix: false,
                readonly: accountController.isNonEdit.value ? true : false,
                hintText: 'Enter your country',
                keyboardType: TextInputType.name,
                controller: accountController.tutionController,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Additional info',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              if (accountController.validationMessages.isNotEmpty)
                Column(
                  children: accountController.validationMessages
                      .map((msg) => Text(
                            msg,
                            style: const TextStyle(color: Colors.red),
                          ))
                      .toList(),
                ),
              InputTextField(
                suffix: false,
                readonly: accountController.isNonEdit.value ? true : false,
                hintText: 'Enter your country',
                keyboardType: TextInputType.name,
                controller: accountController.additionalInfoController,
              ),
            ],
          ),
        ),
        _buildFileUploadSection('Attach resume', 'resume'),
        _buildFileUploadSection('Attach education certificate', 'education'),
        _buildFileUploadSection('Attach experience certificate', 'experience'),
        // InkWell(
        //   onTap: () {
        //     accountController.storeEducationInfo(
        //       context,
        //     );
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
        //         colors: [Color(0xFFC13584), Color(0xFF833AB4)],
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //       ),
        //     ),
        //     child: accountController.isLoading.value
        //         ? const Center(
        //             child: CircularProgressIndicator(),
        //           )
        //         : const Center(
        //             child: Text(
        //               'Next',
        //               style: TextStyle(
        //                 fontSize: 16,
        //                 fontWeight: FontWeight.w600,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildFileUploadSection(String title, String type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              // Display the asterisk (*) only for types other than 'education'
              if (type != 'education')
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
          InkWell(
            onTap: () {
              print("Greeting values==");
             accountController.isNonEdit.value?
              null
              :accountController.pickFile(type);
            },
            child: Container(
              height: 55,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: (type == 'resume' &&
                          accountController.resumePath.value.isNotEmpty) ||
                      (type == 'education' &&
                          accountController
                              .educationCertPath.value.isNotEmpty) ||
                      (type == 'experience' &&
                          accountController.experienceCertPath.value.isNotEmpty)
                  ? Text(
                      path.basename(
                        type == 'resume'
                            ? accountController.resumePath.value
                            : type == 'education'
                                ? accountController.educationCertPath.value
                                : accountController.experienceCertPath.value,
                      ),
                    )
                  : Text(
                      "Upload document",
                      style: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w400),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _fileUploadBottomModal(BuildContext context) {
    showModalBottomSheet(
        // useRootNavigator: true,
        barrierColor: Colors.black.withOpacity(0.8),
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(0.0)), // Set border radius
        ),
        builder: (BuildContext context) {
          return FileUpload(
            onFilePicked: (file) {
              accountController.uploadFile(file);
            },
            isProfile: true,
            title:
                'Upload the ID proof you have selected \nduring registration process',
          );
        });
  }

  void _navigationPage(BuildContext context) {
    // if (accountController.currentTabIndex.value == 0) {
    //   accountController.storePersonalInfo(context);
    // } else if (accountController.currentTabIndex.value == 1) {
    //   accountController.storeAddressInfo(context,
    //       accountController.userProfileResponse.value.data!.rolesId!.roleName!);
    // } else
    if (accountController.userProfileResponse.value.data!.rolesId!.roleName ==
        'Tutor') {
      accountController.storePersonalInfo(context);
      accountController.storeAddressInfo(context,
          accountController.userProfileResponse.value.data!.rolesId!.roleName!);
      accountController.storeEducationInfo(context);
    } else {
      accountController.storePersonalInfo(context);
      accountController.storeAddressInfo(context,
          accountController.userProfileResponse.value.data!.rolesId!.roleName!);
      accountController.storeTuteeeducationInfo(context);
    }
  }

  void showPhoneNumberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text('Update phone number'),
          content: CustomTextField(
              placeholder: 'enter phone number',
              title: 'Please enter the new number',
              showSurfix: false,
              texttype: TextInputType.phone,
              maxLength: 10,
              isMobile: false,
              textEditingController: accountController.updatePhController),
          actions: <Widget>[
            InkWell(
              onTap: () {
                accountController.updatePhController.clear();
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: AppConstants.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'Cancel',
                    style:
                        GoogleFonts.nunito(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                if (accountController.updatePhController.text.isEmpty) {
                  SnackBarUtils.showErrorSnackBar(
                      context, "Please enter the new number");
                } else {
                  //
                  final response = await accountController.phoneNumberVerified(
                      accountController.updatePhController.text, context);
                  if (response) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: AppConstants.secondaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'Submit',
                    style:
                        GoogleFonts.nunito(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget placesAutoCompleteTextField(UserProfileController accountController) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: accountController.autoCompleteController,
        googleAPIKey: "AIzaSyCe2-5wVLxW2xSeQpqVzVCEt9n3ppUAwXA",
        inputDecoration: InputDecoration(
          hintText: "Search your location",
          filled: false,
          fillColor: Colors.grey.withOpacity(0.2),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide.none),
          suffixIcon: const Icon(Icons.search),
        ),
        debounceTime: 800,
        countries: const ["in", "QA"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          accountController.handleAutoCompleteSelection(prediction);
        },
        itemClick: (Prediction prediction) {
          accountController.autoCompleteController.text =
              prediction.description!;
          accountController.focusNode.unfocus();
        },
        focusNode: accountController.focusNode,
      ),
    );
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
