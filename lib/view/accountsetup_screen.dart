import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hovee_attendence/controllers/accountSetup_controller.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDropDownInputField.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/utils/keyboardUtils.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSetup extends StatelessWidget {
  final String roleId;
  final String roleTypeId;
  final String selectedRoleTypeName;
  final String? selectedRole;
  final String? parentId;
  final bool? isGoogleSignIn;
  AccountSetup(
      {Key? key,
      required this.roleId,
      required this.roleTypeId,
      required this.selectedRoleTypeName,
      this.selectedRole,
      this.parentId,
      this.isGoogleSignIn});

  @override
  Widget build(BuildContext context) {
    final AccountSetupController accountController =
        Get.put(AccountSetupController(isGoogleSignIn: isGoogleSignIn));
    final splashController = Get.find<SplashController>();
    final authController = Get.find<AuthControllers>();
    final args = Get.arguments;
    // Load shared preferences data and set it to controllers
    Future<void> loadSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? firstName = prefs.getString('UserName') ?? '';
      String? lastName = prefs.getString('UserLastName') ?? '';
      String? email = prefs.getString('UserEmail') ?? '';

      isGoogleSignIn!
          ? accountController.firstNameController.text = firstName
          : accountController.firstNameController.text;
      isGoogleSignIn!
          ? accountController.lastNameController.text = lastName
          : accountController.lastNameController.text;
      isGoogleSignIn!
          ? accountController.emailController.text = email
          : accountController.emailController.text;
    }

    // Call loadSharedPreferences when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSharedPreferences();
    });
    return WillPopScope(
      onWillPop: () async {
        return await ModalService.handleBackButtonN(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () async {
            bool isBack = await ModalService.handleBackButtonN(context);
            // Navigator.pop(context);
          },
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image 194.png'),
                        fit: BoxFit.cover),
                    gradient: LinearGradient(
                      colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Account setup',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: Obx(() {
                    return Container(
                      height: selectedRole == 'Tutee'
                          ? accountController.currentTabIndex.value == 2
                              ? MediaQuery.of(context).size.height * 0.7
                              : MediaQuery.of(context).size.height * 0.7
                          : accountController.currentTabIndex.value == 2
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
                          const SizedBox(
                            height: 10,
                          ),
                          TabBar(
                            dragStartBehavior: DragStartBehavior.down,
                            controller: accountController.tabController,
                            onTap: (int index) {
                              // if (index == 1) {
                              //   accountController.storePersonalInfo(
                              //       context, roleId, roleTypeId);
                              // }
                              // if (index == 2) {
                              //   accountController.storeAddressInfo(
                              //       context,
                              //       selectedRoleTypeName,
                              //       roleId,
                              //       roleTypeId,
                              //       selectedRole);
                              // }
                              // accountController.currentTabIndex.value = index;
                              // accountController.isLoading.value = false;
                              // KeyboardUtil.hideKeyboard(context);

                              // Perform actions based on tab index
                              if (index == 1) {
                                accountController.storePersonalInfo(
                                    context, roleId, roleTypeId);
                              }
                              if (index == 2) {
                                accountController.storeAddressInfo(
                                    context,
                                    selectedRoleTypeName,
                                    roleId,
                                    roleTypeId,
                                    selectedRole);
                              }

                              // if (index == 1 || index == 2) {
                              //   // Check if a location has been searched
                              //   Logger().d(accountController
                              //       .isLocationSearched.value);
                              //   if (accountController
                              //       .isLocationSearched.value) {
                              //              Logger().d( LatLng(
                              //             accountController.latitudeL.value,
                              //             accountController.longitudeL.value),);
                              //     accountController.mapController
                              //         .animateCamera(
                              //       CameraUpdate.newLatLng(
                              //         LatLng(
                              //             accountController.latitudeL.value,
                              //             accountController.longitudeL.value),
                              //       ),
                              //     );
                              //     accountController.setMarker(
                              //       LatLng(accountController.latitudeL.value,
                              //           accountController.longitudeL.value),
                              //     );
                              //   }else{
                              //     Logger().d("Location already searched");
                              //   }
                              // }

                              // Update the current tab index and hide the keyboard
                              accountController.currentTabIndex.value = index;
                              accountController.isLoading.value = false;
                              KeyboardUtil.hideKeyboard(context);
                            },
                            tabs: [
                              const Tab(
                                text: 'Personal info',
                              ),
                              const Tab(
                                text: 'Address info',
                              ),
                              // Show this tab only if selectedRole is not "Parent"
                              if (selectedRole != 'Parent' && selectedRole != 'Hosteller')
                                Tab(
                                  text: selectedRole == 'Tutee'
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
                              // physics:
                              //     accountController.isMapInteracting.value
                              //         ? const NeverScrollableScrollPhysics()
                              //         : const AlwaysScrollableScrollPhysics(),
                              children: [
                                //personal info
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
                                                  readonly:  false,
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
                                            readonly:
                                                isGoogleSignIn! ? true : false,
                                            inputFormatter: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(
                                                  r"[a-zA-Z0-9@&_,-\/.']",
                                                ),
                                              ),
                                            ],
                                            hintText: 'Enter here...',
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
                                        parentId == ""
                                            ? InputTextField(
                                                suffix: true,
                                                readonly: true,
                                                isDate: true,
                                                hintText: 'Select',
                                                initialDate:
                                                    DateTime.now().subtract(
                                                  const Duration(
                                                      days: 365 * 18),
                                                ),
                                                lastDate:
                                                    DateTime.now().subtract(
                                                  const Duration(
                                                      days: 365 * 18),
                                                ),
                                                keyboardType:
                                                    TextInputType.datetime,
                                                controller: accountController
                                                    .dobController)
                                            : InputTextField(
                                                suffix: true,
                                                readonly: true,
                                                isDate: true,
                                                hintText: 'Select',
                                                initialDate: DateTime
                                                    .now(), // No restriction for initial date
                                                lastDate: DateTime
                                                    .now(), // Allows any date up to today
                                                keyboardType:
                                                    TextInputType.datetime,
                                                controller: accountController
                                                    .dobController,
                                              ),
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
                                          showVerifiedIcon:
                                              isGoogleSignIn! ? true : false,
                                          isDate: false,
                                          suffix:
                                              isGoogleSignIn! ? false : false,
                                          readonly:
                                              isGoogleSignIn! 
      ? (accountController.accountVerified == true ? true : false) 
      : true,
                                          hintText: 'Enter here...',
                                          keyboardType: TextInputType.phone,
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r"[0-9]")),
                                            LengthLimitingTextInputFormatter(
                                                10), // Restrict to 10 digits
                                          ],
                                          controller:
                                              accountController.phController,
                                          accountVerified: accountController
                                                  .accountVerified ==
                                              true,
                                          onVerifiedIconPressed: () {
                                            if (accountController
                                                    .accountVerified ==
                                                false) {
                                              // Allow function execution only if not verified
                                              print("Verified icon clicked");
                                              accountController
                                                  .phoneNumberVerified(
                                                      accountController
                                                          .phController.text,
                                                      context);
                                            } else {
                                              print(
                                                  "Account already verified, action not allowed.");
                                            }
                                          },
                                        ),

                                        // InputTextField(
                                        //    showVerifiedIcon: true,
                                        //   isDate: false,
                                        //     suffix: isGoogleSignIn!? false:true,
                                        //     readonly: isGoogleSignIn!? false:true,
                                        //     hintText: 'Enter here...',
                                        //     keyboardType: TextInputType.phone,
                                        //     inputFormatter: [
                                        //       FilteringTextInputFormatter
                                        //           .allow(
                                        //         RegExp(r"[0-9]"),
                                        //       ),
                                        //       LengthLimitingTextInputFormatter(
                                        //           10), // Restrict to 10 digits
                                        //     ],
                                        //     controller: accountController
                                        //         .phController),
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
                                          hintText: 'Enter here...',
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                r"[0-9]",
                                              ),
                                            ),
                                            LengthLimitingTextInputFormatter(
                                                10),
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
                                            print("gretting values==");
                                            ModalService.openIDProofModalSheet(
                                                context,
                                                splashController,
                                                accountController);
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
                                        InkWell(
                                          onTap: () {
                                            // Hide the keyboard when tapping
                                            KeyboardUtil.hideKeyboard(context);

                                            // Check the GoogleSignIn status and account verification status
                                            if (isGoogleSignIn == true &&
                                                accountController
                                                    .accountVerified.value) {
                                              // If GoogleSignIn is true and account is verified, store personal info
                                              accountController
                                                  .storePersonalInfo(context,
                                                      roleId, roleTypeId);
                                            } else if (isGoogleSignIn == true &&
                                                !accountController
                                                    .accountVerified.value) {
                                              // If GoogleSignIn is true but account is not verified, show verification message
                                              SnackBarUtils.showErrorSnackBar(
                                                context,
                                                "Please verify your phone number",
                                              );
                                            } else if (isGoogleSignIn ==
                                                    false &&
                                                !accountController
                                                    .accountVerified.value) {
                                              // If GoogleSignIn is false and account is not verified, store personal info
                                              accountController
                                                  .storePersonalInfo(context,
                                                      roleId, roleTypeId);
                                            }
                                          },
                                          child: Container(
                                            height: 48,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 40,
                                              vertical: 12,
                                            ),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFFC13584),
                                                  Color(0xFF833AB4),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                            child: accountController
                                                    .isLoading.value
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : const Center(
                                                    child: Text(
                                                      'Next',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),

                                        // InkWell(
                                        //   onTap: () {
                                        //     KeyboardUtil.hideKeyboard(context);
                                        //     accountController.storePersonalInfo(
                                        //         context, roleId, roleTypeId);
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Expanded(
                                                child: CustomScrollView(
                                                  slivers: [
                                                    SliverToBoxAdapter(
                                                      child: placesAutoCompleteTextField(accountController),
                                                    ),
                                                    SliverList(
                                                      delegate: SliverChildListDelegate(
                                                        [
                                                          const SizedBox(height: 10),
                                                          SizedBox(
                                                        height: MediaQuery.of(context).size.height * 0.25,
                                                        child: GoogleMap(
                                                          scrollGesturesEnabled: true,
                                                          mapType: MapType.normal,
                                                          initialCameraPosition: CameraPosition(
                                                            target: LatLng(accountController.latitudeL.value ?? 0.0,
                                                                accountController.longitudeL.value ?? 0.0),
                                                            zoom: 10,
                                                          ),
                                                          onMapCreated: accountController.onMapCreated,
                                                          markers: accountController.marker.value != null
                                                              ? {accountController.marker.value!}
                                                              : {},
                                                          onTap: (position) {
                                                            accountController.setMarker(position);
                                                          },
                                                          zoomControlsEnabled: false,
                                                          gestureRecognizers: Set()
                                                            ..add(Factory<EagerGestureRecognizer>(
                                                                () => EagerGestureRecognizer())),
                                                        ),
                                                      ),
                                                          
                                                          const SizedBox(height: 10),
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
                                                readonly: false,
                                                hintText: 'Enter here...',
                                                keyboardType: TextInputType.name,
                                                inputFormatter: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                      r"[a-zA-Z0-9\s@&_,-\./']",
                                                    ),
                                                  ),
                                                ],
                                                controller: accountController
                                                    .address1Controller),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Street & Area',
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
                                                readonly: false,
                                                hintText: 'Enter here...',
                                                keyboardType: TextInputType.name,
                                                inputFormatter: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                        r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                                  ),
                                                ],
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
                                                readonly: false,
                                                hintText: 'Enter here...',
                                                keyboardType: TextInputType.name,
                                                inputFormatter: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                        r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                                  ),
                                                ],
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
                                                readonly: false,
                                                hintText: 'Enter here...',
                                                keyboardType: TextInputType.text,
                                                inputFormatter: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                        r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                                  ),
                                                ],
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
                                              readonly: false,
                                              hintText: 'Enter here...',
                                              keyboardType: TextInputType.name,
                                              inputFormatter: [
                                                FilteringTextInputFormatter.allow(
                                                  RegExp(
                                                      r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                                ),
                                              ],
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
                                              readonly: false,
                                              hintText: 'Enter here...',
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
                                                    10),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                                          InkWell(
                                                            onTap: () {
                                                              KeyboardUtil.hideKeyboard(context);
                                                              if (isGoogleSignIn == true &&
                                                                  accountController.accountVerified.value) {
                                                                accountController.storeAddressInfo(
                                                                    context, selectedRoleTypeName, roleId, roleTypeId, selectedRole);
                                                              } else if (isGoogleSignIn == true &&
                                                                  !accountController.accountVerified.value) {
                                                                SnackBarUtils.showErrorSnackBar(
                                                                  context,
                                                                  "Please verify your phone number",
                                                                );
                                                              } else if (isGoogleSignIn == false &&
                                                                  !accountController.accountVerified.value) {
                                                                accountController.storeAddressInfo(
                                                                    context, selectedRoleTypeName, roleId, roleTypeId, selectedRole);
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 48,
                                                              padding: const EdgeInsets.symmetric(
                                                                horizontal: 40,
                                                                vertical: 12,
                                                              ),
                                                              decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.all(
                                                                  Radius.circular(8),
                                                                ),
                                                                gradient: LinearGradient(
                                                                  colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                                                                  begin: Alignment.topCenter,
                                                                  end: Alignment.bottomCenter,
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  selectedRole != 'Parent' &&
                                                                          selectedRole != 'Hosteller' &&
                                                                          selectedRoleTypeName != 'Institute' &&
                                                                          selectedRole == 'Tutor'
                                                                      ? 'Next'
                                                                      : 'Submit',
                                                                  style: const TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 16),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                //address info
                                // Container(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 12),
                                //   child: GestureDetector(
                                //     onVerticalDragUpdate: (details) {
                                //       // Detect dragging on the map

                                //       if (details.localPosition.dy <=
                                //           accountController.mapHeight.value) {
                                //         // setState(() {
                                //         //   _isMapInteracting = true;
                                //         // });
                                //         accountController
                                //             .isMapInteracting.value = true;
                                //       }
                                //     },
                                //     onVerticalDragEnd: (details) {
                                //       // Reset the interaction flag when the drag ends
                                //       // setState(() {
                                //       //   _isMapInteracting = false;
                                //       // });
                                //       accountController.isMapInteracting.value =
                                //           true;
                                //     },
                                //     child: SingleChildScrollView(
                                //       physics: accountController
                                //               .isMapInteracting.value
                                //           ? const NeverScrollableScrollPhysics()
                                //           : const AlwaysScrollableScrollPhysics(),
                                //       child: Column(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.start,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           placesAutoCompleteTextField(
                                //               accountController),
                                //           const SizedBox(
                                //             height: 10,
                                //           ),
                                //           Obx(() => Stack(
                                //                 children: [
                                //                   Container(
                                //                     height:
                                //                         MediaQuery.of(context)
                                //                                 .size
                                //                                 .height *
                                //                             0.25,
                                //                     width:
                                //                         MediaQuery.of(context)
                                //                             .size
                                //                             .width,
                                //                     decoration: BoxDecoration(
                                //                       color: Colors.white,
                                //                       border: Border.all(
                                //                         color: Colors.grey
                                //                             .withOpacity(0.3),
                                //                         width: 1,
                                //                       ),
                                //                       borderRadius:
                                //                           const BorderRadius
                                //                               .all(
                                //                               Radius.circular(
                                //                                   8.0)),
                                //                     ),
                                //                     child: ClipRRect(
                                //                       borderRadius:
                                //                           const BorderRadius
                                //                               .all(
                                //                               Radius.circular(
                                //                                   8.0)),
                                //                       child: GoogleMap(
                                //                         scrollGesturesEnabled:
                                //                             true,
                                //                         mapType: MapType.normal,
                                //                         initialCameraPosition:
                                //                             CameraPosition(
                                //                           target: LatLng(
                                //                               accountController
                                //                                       .latitudeL
                                //                                       .value ??
                                //                                   0.0,
                                //                               accountController
                                //                                       .longitudeL
                                //                                       .value ??
                                //                                   0.0),
                                //                           zoom: 10,
                                //                         ),
                                //                         onMapCreated:
                                //                             accountController
                                //                                 .onMapCreated,
                                //                         markers:
                                //                             accountController
                                //                                         .marker
                                //                                         .value !=
                                //                                     null
                                //                                 ? {
                                //                                     accountController
                                //                                         .marker
                                //                                         .value!
                                //                                   }
                                //                                 : {},
                                //                         onTap: (position) {
                                //                           accountController
                                //                               .setMarker(
                                //                                   position);
                                //                         },
                                //                         zoomControlsEnabled:
                                //                             false,
                                //                         gestureRecognizers: Set()
                                //                           ..add(Factory<
                                //                                   EagerGestureRecognizer>(
                                //                               () =>
                                //                                   EagerGestureRecognizer())),
                                //                       ),
                                //                     ),
                                //                   ),
                                //                   if (accountController
                                //                       .isLoading.value)
                                //                     Positioned.fill(
                                //                       child: Container(
                                //                         color: Colors.black
                                //                             .withOpacity(0.5),
                                //                         child: const Center(
                                //                           child:
                                //                               CircularProgressIndicator(),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   Positioned(
                                //                     top: 10,
                                //                     right: 10,
                                //                     child: Column(
                                //                       children: [
                                //                         FloatingActionButton(
                                //                           backgroundColor:
                                //                               Colors.blue,
                                //                           onPressed: () =>
                                //                               accountController
                                //                                   .zoomIn(),
                                //                           mini: true,
                                //                           child: const Icon(
                                //                               Icons.zoom_in,
                                //                               color:
                                //                                   Colors.white),
                                //                         ),
                                //                         const SizedBox(
                                //                             height: 10),
                                //                         FloatingActionButton(
                                //                           backgroundColor:
                                //                               Colors.blue,
                                //                           onPressed: () =>
                                //                               accountController
                                //                                   .zoomOut(),
                                //                           mini: true,
                                //                           child: const Icon(
                                //                               Icons.zoom_out,
                                //                               color:
                                //                                   Colors.white),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ),
                                //                 ],
                                //               )),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     const Text(
                                          //       'Door no',
                                          //       style: TextStyle(
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w500,
                                          //         color: Colors.black,
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       '*',
                                          //       style: GoogleFonts.nunito(
                                          //         fontSize: 18,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Colors.red
                                          //             .withOpacity(0.6),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // InputTextField(
                                          //     suffix: false,
                                          //     readonly: false,
                                          //     hintText: 'Enter here...',
                                          //     keyboardType: TextInputType.name,
                                          //     inputFormatter: [
                                          //       FilteringTextInputFormatter
                                          //           .allow(
                                          //         RegExp(
                                          //           r"[a-zA-Z0-9\s@&_,-\./']",
                                          //         ),
                                          //       ),
                                          //     ],
                                          //     controller: accountController
                                          //         .address1Controller),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     const Text(
                                          //       'Street & Area',
                                          //       style: TextStyle(
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w500,
                                          //         color: Colors.black,
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       '*',
                                          //       style: GoogleFonts.nunito(
                                          //         fontSize: 18,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Colors.red
                                          //             .withOpacity(0.6),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // InputTextField(
                                          //     suffix: false,
                                          //     readonly: false,
                                          //     hintText: 'Enter here...',
                                          //     keyboardType: TextInputType.name,
                                          //     inputFormatter: [
                                          //       FilteringTextInputFormatter
                                          //           .allow(
                                          //         RegExp(
                                          //             r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                          //       ),
                                          //     ],
                                          //     controller: accountController
                                          //         .address2Controller),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     const Text(
                                          //       'City',
                                          //       style: TextStyle(
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w500,
                                          //         color: Colors.black,
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       '*',
                                          //       style: GoogleFonts.nunito(
                                          //         fontSize: 18,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Colors.red
                                          //             .withOpacity(0.6),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // InputTextField(
                                          //     suffix: false,
                                          //     readonly: false,
                                          //     hintText: 'Enter here...',
                                          //     keyboardType: TextInputType.name,
                                          //     inputFormatter: [
                                          //       FilteringTextInputFormatter
                                          //           .allow(
                                          //         RegExp(
                                          //             r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                          //       ),
                                          //     ],
                                          //     controller: accountController
                                          //         .cityController),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     const Text(
                                          //       'State',
                                          //       style: TextStyle(
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w500,
                                          //         color: Colors.black,
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       '*',
                                          //       style: GoogleFonts.nunito(
                                          //         fontSize: 18,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Colors.red
                                          //             .withOpacity(0.6),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // InputTextField(
                                          //     suffix: false,
                                          //     readonly: false,
                                          //     hintText: 'Enter here...',
                                          //     keyboardType: TextInputType.text,
                                          //     inputFormatter: [
                                          //       FilteringTextInputFormatter
                                          //           .allow(
                                          //         RegExp(
                                          //             r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                          //       ),
                                          //     ],
                                          //     controller: accountController
                                          //         .stateController),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     const Text(
                                          //       'Country',
                                          //       style: TextStyle(
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w500,
                                          //         color: Colors.black,
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       '*',
                                          //       style: GoogleFonts.nunito(
                                          //         fontSize: 18,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Colors.red
                                          //             .withOpacity(0.6),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // InputTextField(
                                          //   suffix: false,
                                          //   readonly: false,
                                          //   hintText: 'Enter here...',
                                          //   keyboardType: TextInputType.name,
                                          //   inputFormatter: [
                                          //     FilteringTextInputFormatter.allow(
                                          //       RegExp(
                                          //           r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                          //     ),
                                          //   ],
                                          //   controller: accountController
                                          //       .countryController,
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Row(
                                          //   children: [
                                          //     const Text(
                                          //       'Pincode',
                                          //       style: TextStyle(
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w500,
                                          //         color: Colors.black,
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       '*',
                                          //       style: GoogleFonts.nunito(
                                          //         fontSize: 18,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Colors.red
                                          //             .withOpacity(0.6),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // InputTextField(
                                          //   suffix: false,
                                          //   readonly: false,
                                          //   hintText: 'Enter here...',
                                          //   keyboardType: TextInputType.number,
                                          //   controller: accountController
                                          //       .pincodesController,
                                          //   inputFormatter: [
                                          //     FilteringTextInputFormatter.allow(
                                          //       RegExp(
                                          //         r"[0-9]",
                                          //       ),
                                          //     ),
                                          //     LengthLimitingTextInputFormatter(
                                          //         10),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 16,
                                          // ),
                                //           InkWell(
                                //             onTap: () {
                                //               KeyboardUtil.hideKeyboard(
                                //                   context);                               // Check the GoogleSignIn status and account verification status
                                //             if (isGoogleSignIn == true &&
                                //                 accountController
                                //                     .accountVerified.value) {
                                //               // If GoogleSignIn is true and account is verified, store personal info
                                //              accountController
                                //                   .storeAddressInfo(
                                //                       context,
                                //                       selectedRoleTypeName,
                                //                       roleId,
                                //                       roleTypeId,
                                //                       selectedRole);
                                //             } else if (isGoogleSignIn == true &&
                                //                 !accountController
                                //                     .accountVerified.value) {
                                //               // If GoogleSignIn is true but account is not verified, show verification message
                                //               SnackBarUtils.showErrorSnackBar(
                                //                 context,
                                //                 "Please verify your phone number",
                                //               );
                                //             } else if (isGoogleSignIn ==
                                //                     false &&
                                //                 !accountController
                                //                     .accountVerified.value) {
                                //               // If GoogleSignIn is false and account is not verified, store personal info
                                //               accountController
                                //                   .storeAddressInfo(
                                //                       context,
                                //                       selectedRoleTypeName,
                                //                       roleId,
                                //                       roleTypeId,
                                //                       selectedRole);
                                //             }
                                //             },
                                //             child: Container(
                                //               height: 48,
                                //               padding:
                                //                   const EdgeInsets.symmetric(
                                //                 horizontal: 40,
                                //                 vertical: 12,
                                //               ),
                                //               decoration: const BoxDecoration(
                                //                 borderRadius: BorderRadius.all(
                                //                   Radius.circular(8),
                                //                 ),
                                //                 gradient: LinearGradient(
                                //                   colors: [
                                //                     Color(0xFFC13584),
                                //                     Color(0xFF833AB4)
                                //                   ],
                                //                   begin: Alignment.topCenter,
                                //                   end: Alignment.bottomCenter,
                                //                 ),
                                //               ),
                                //               child: accountController
                                //                       .isLoading.value
                                //                   ? const Center(
                                //                       child:
                                //                           CircularProgressIndicator(),
                                //                     )
                                //                   : Center(
                                //                       child: Text(
                                //                         selectedRole !=
                                //                                     'Parent' &&
                                //                                     selectedRole !=
                                //                                     'Hosteller' &&
                                //                                 selectedRoleTypeName !=
                                //                                     'Institute' &&
                                //                                 selectedRole ==
                                //                                     'Tutor'
                                //                             ? 'Next'
                                //                             : 'Submit',
                                //                         style: const TextStyle(
                                //                           fontSize: 16,
                                //                           fontWeight:
                                //                               FontWeight.w600,
                                //                           color: Colors.white,
                                //                         ),
                                //                       ),
                                //                     ),
                                //             ),
                                //           ),
                                //           const SizedBox(
                                //             height: 16,
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              

                                // selectedRoleTypeName == 'Institute' &&
                                //         selectedRoleTypeName == ""
                                //     ? Container()
                                //     :
                                // selectedRoleTypeName != 'Institute' &&
                                //         selectedRoleTypeName != ""
                                //     ?
                                selectedRoleTypeName != 'Institute' &&
                                        selectedRole == 'Tutor'
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ..._buildDropdowns(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Tution name',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          '*',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.red
                                                                .withOpacity(
                                                                    0.6),
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
                                                        hintText:
                                                            'Enter here...',
                                                        keyboardType:
                                                            TextInputType.name,
                                                        inputFormatter: [
                                                          FilteringTextInputFormatter
                                                              .allow(
                                                            RegExp(
                                                                r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                                          ),
                                                        ],
                                                        controller:
                                                            accountController
                                                                .tutionController),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text(
                                                      'Additional info',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    InputTextField(
                                                        suffix: false,
                                                        readonly: false,
                                                        hintText:
                                                            'Enter here...',
                                                        keyboardType:
                                                            TextInputType.name,
                                                        inputFormatter: [
                                                          FilteringTextInputFormatter
                                                              .allow(
                                                            RegExp(
                                                                r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                                          ),
                                                        ],
                                                        controller:
                                                            accountController
                                                                .additionalInfoController),
                                                  ],
                                                ),
                                              ),
                                              _buildFileUploadSection(
                                                  'Attach resume', 'resume'),
                                              _buildFileUploadSection(
                                                  'Attach education certificate',
                                                  'education'),
                                              _buildFileUploadSection(
                                                  'Attach experience certificate',
                                                  'experience'),
                                              if (accountController
                                                  .validationMessages
                                                  .isNotEmpty)
                                                Column(
                                                  children: accountController
                                                      .validationMessages
                                                      .map((msg) => Text(
                                                            msg,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                          ))
                                                      .toList(),
                                                ),
                                              InkWell(
                                                onTap: () {
                                                  KeyboardUtil.hideKeyboard(
                                                      context);
                                                
                                                                                              if (isGoogleSignIn == true &&
                                                accountController
                                                    .accountVerified.value) {
                                              // If GoogleSignIn is true and account is verified, store personal info
                                              accountController
                                                      .storeEducationInfo(
                                                          context,
                                                          roleId,
                                                          roleTypeId,
                                                          selectedRole);
                                            } else if (isGoogleSignIn == true &&
                                                !accountController
                                                    .accountVerified.value) {
                                              // If GoogleSignIn is true but account is not verified, show verification message
                                              SnackBarUtils.showErrorSnackBar(
                                                context,
                                                "Please verify your phone number",
                                              );
                                            } else if (isGoogleSignIn ==
                                                    false &&
                                                !accountController
                                                    .accountVerified.value) {
                                              // If GoogleSignIn is false and account is not verified, store personal info
                                               accountController
                                                      .storeEducationInfo(
                                                          context,
                                                          roleId,
                                                          roleTypeId,
                                                          selectedRole);
                                            }
                                                },
                                                child: Container(
                                                  height: 48,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 40,
                                                    vertical: 12,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFC13584),
                                                        Color(0xFF833AB4)
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: accountController
                                                          .isLoading.value
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : const Center(
                                                          child: Text(
                                                            'Submit',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ),
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
                                    : selectedRole == 'Tutee'
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Highest qualification',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        '*',
                                                        style:
                                                            GoogleFonts.nunito(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.red
                                                              .withOpacity(0.6),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // InputTextField(
                                                  //     suffix: false,
                                                  //     readonly: false,
                                                  //     inputFormatter: [
                                                  //       FilteringTextInputFormatter
                                                  //           .allow(
                                                  //         RegExp(
                                                  //           r"[a-zA-Z0-9@&_,-\.']",
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //     hintText:
                                                  //         'Select',
                                                  //     keyboardType:
                                                  //         TextInputType
                                                  //             .emailAddress,
                                                  //     controller:
                                                  //         accountController
                                                  //             .tuteQualificationController),
                                                  CommonDropdownInputField(
                                                    title:
                                                        'Highest qualification',
                                                    controllerValue:
                                                        accountController
                                                            .tuteeHighestQualification,
                                                    selectedValue: accountController
                                                        .tuteeHighestQualification,
                                                    items: accountController
                                                        .tuteeQualifications,
                                                    onChanged: accountController
                                                        .setTuteeHighestQualification,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'Choose a board',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            '*',
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors.red
                                                                  .withOpacity(
                                                                      0.6),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Obx(() =>
                                                          CommonDropdownInputField(
                                                            title: 'board',
                                                            controllerValue:
                                                                accountController
                                                                    .boardController
                                                                    .value
                                                                    .obs,
                                                            selectedValue:
                                                                accountController
                                                                    .boardController
                                                                    .value
                                                                    .obs,
                                                            items:
                                                                accountController
                                                                    .board,
                                                            onChanged:
                                                                accountController
                                                                    .setBoard,
                                                          )),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 10),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Select a class',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              '*',
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .red
                                                                    .withOpacity(
                                                                        0.6),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Obx(() =>
                                                            CommonDropdownInputField(
                                                              title: 'Class',
                                                              controllerValue:
                                                                  accountController
                                                                      .classController
                                                                      .value
                                                                      .obs,
                                                              selectedValue:
                                                                  accountController
                                                                      .classController
                                                                      .value
                                                                      .obs,
                                                              items:
                                                                  accountController
                                                                      .classList,
                                                              onChanged:
                                                                  accountController
                                                                      .setClass,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 10),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Choose a subject',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              '*',
                                                              style: GoogleFonts
                                                                  .nunito(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .red
                                                                    .withOpacity(
                                                                        0.6),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Obx(() =>
                                                            CommonDropdownInputField(
                                                              title: 'subject',
                                                              controllerValue:
                                                                  accountController
                                                                      .subjectController
                                                                      .value
                                                                      .obs,
                                                              selectedValue:
                                                                  accountController
                                                                      .subjectController
                                                                      .value
                                                                      .obs,
                                                              items:
                                                                  accountController
                                                                      .subject,
                                                              onChanged:
                                                                  accountController
                                                                      .setSubject,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     const Text(
                                                  //       'Class/Specialization',
                                                  //       style: TextStyle(
                                                  //         fontSize: 14,
                                                  //         fontWeight:
                                                  //             FontWeight
                                                  //                 .w500,
                                                  //         color: Colors
                                                  //             .black,
                                                  //       ),
                                                  //     ),
                                                  //     Text(
                                                  //       '*',
                                                  //       style: GoogleFonts
                                                  //           .nunito(
                                                  //         fontSize: 18,
                                                  //         fontWeight:
                                                  //             FontWeight
                                                  //                 .w600,
                                                  //         color: Colors
                                                  //             .red
                                                  //             .withOpacity(
                                                  //                 0.6),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // InputTextField(
                                                  //     suffix: false,
                                                  //     readonly: false,
                                                  //     inputFormatter: [
                                                  //       FilteringTextInputFormatter
                                                  //           .allow(
                                                  //         RegExp(
                                                  //           r"[a-zA-Z0-9@&_,-\.']",
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //     hintText:
                                                  //         'Select',
                                                  //     keyboardType:
                                                  //         TextInputType
                                                  //             .emailAddress,
                                                  //     controller:
                                                  //         accountController
                                                  //             .tuteclassController),
                                                  // CommonDropdownInputField(
                                                  //   title:
                                                  //       'Class/Specialization',
                                                  //   controllerValue:
                                                  //       accountController
                                                  //           .tuteeSpeciallization,
                                                  //   selectedValue:
                                                  //       accountController
                                                  //           .tuteeSpeciallization,
                                                  //   items: accountController
                                                  //       .tuteeSpeciallizationClass,
                                                  //   onChanged:
                                                  //       accountController
                                                  //           .setTuteeSpeciallization,
                                                  // ),
                                                  // const SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  // Row(
                                                  //   children: [
                                                  //     const Text(
                                                  //       'Board',
                                                  //       style: TextStyle(
                                                  //         fontSize: 14,
                                                  //         fontWeight:
                                                  //             FontWeight.w500,
                                                  //         color: Colors.black,
                                                  //       ),
                                                  //     ),
                                                  //     Text(
                                                  //       '*',
                                                  //       style: GoogleFonts
                                                  //           .nunito(
                                                  //         fontSize: 18,
                                                  //         fontWeight:
                                                  //             FontWeight.w600,
                                                  //         color: Colors.red
                                                  //             .withOpacity(
                                                  //                 0.6),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // const SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                  // InputTextField(
                                                  //     suffix: false,
                                                  //     readonly: false,
                                                  //     inputFormatter: [
                                                  //       FilteringTextInputFormatter
                                                  //           .allow(
                                                  //         RegExp(
                                                  //           r"[a-zA-Z0-9@&_,-\.']",
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //     hintText:
                                                  //         'Enter your board',
                                                  //     keyboardType:
                                                  //         TextInputType
                                                  //             .emailAddress,
                                                  //     controller:
                                                  //         accountController
                                                  //             .tuteeboardController),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Name of school/college',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        '*',
                                                        style:
                                                            GoogleFonts.nunito(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                      readonly: false,
                                                      inputFormatter: [
                                                        FilteringTextInputFormatter
                                                            .allow(
                                                          RegExp(
                                                              r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
                                                        ),
                                                      ],
                                                      hintText: 'Enter here...',
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      controller: accountController
                                                          .tuteorganizationController),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      KeyboardUtil.hideKeyboard(
                                                          context);
                                                  
                                                       if (isGoogleSignIn == true &&
                                                accountController
                                                    .accountVerified.value) {
                                              // If GoogleSignIn is true and account is verified, store personal info
                                                accountController
                                                          .storeTuteeeducationInfo(
                                                              context,
                                                              roleId,
                                                              roleTypeId);
                                            } else if (isGoogleSignIn == true &&
                                                !accountController
                                                    .accountVerified.value) {
                                              // If GoogleSignIn is true but account is not verified, show verification message
                                              SnackBarUtils.showErrorSnackBar(
                                                context,
                                                "Please verify your phone number",
                                              );
                                            } else if (isGoogleSignIn ==
                                                    false &&
                                                !accountController
                                                    .accountVerified.value) {
                                              // If GoogleSignIn is false and account is not verified, store personal info
                                                  accountController
                                                          .storeTuteeeducationInfo(
                                                              context,
                                                              roleId,
                                                              roleTypeId);
                                            }
                                                    },
                                                    child: Container(
                                                      height: 48,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 40,
                                                        vertical: 12,
                                                      ),
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xFFC13584),
                                                            Color(0xFF833AB4)
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                      ),
                                                      child: accountController
                                                              .isLoading.value
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : const Center(
                                                              child: Text(
                                                                'Submit',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container()
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            )
            // Obx((){
            //   return  ;
            // })
          ],
        ),
      ),
    );
  }

  // Widget _buildFileUploadSection(String title, String type) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w500,
  //                 color: Colors.black,
  //               ),
  //             ),
  //             Text(
  //               '*',
  //               style: GoogleFonts.nunito(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w600,
  //                 color: Colors.red.withOpacity(0.6),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 5,
  //         ),
  //         // Padding(
  //         //   padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
  //         //   child: Text(
  //         //     title,
  //         //     style: GoogleFonts.nunito(
  //         //         fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
  //         //   ),
  //         // ),
  //         Container(
  //           // margin: EdgeInsets.all(20),
  //           width: double.infinity,
  //           height: 120,

  //           decoration: BoxDecoration(
  //             color: Color(0xFFBA0161).withOpacity(0.2),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           // child: DottedBorder(
  //           // borderType: BorderType.RRect,
  //           // radius: const Radius.circular(12),
  //           // color: Color(0xFFC13584),
  //           // strokeWidth: 1,
  //           // dashPattern: const [5, 5],
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(12),
  //                 border: Border.all(
  //                     color: AppConstants.secondaryColor,
  //                     style: BorderStyle.solid)),
  //             child: GestureDetector(
  //               onTap: () async {
  //                 await accountController.pickFile(type);
  //               },
  //               child: SizedBox.expand(
  //                 child: FittedBox(
  //                   child: (type == 'resume' &&
  //                               accountController
  //                                   .resumePath.value.isNotEmpty) ||
  //                           (type == 'education' &&
  //                               accountController
  //                                   .educationCertPath.value.isNotEmpty) ||
  //                           (type == 'experience' &&
  //                               accountController
  //                                   .experienceCertPath.value.isNotEmpty)
  //                       ? Image.file(
  //                           File(
  //                             (type == 'resume'
  //                                 ? accountController.resumePath.value
  //                                 : type == 'education'
  //                                     ? accountController
  //                                         .educationCertPath.value
  //                                     : accountController
  //                                         .experienceCertPath.value),
  //                           ),
  //                           fit: BoxFit.cover,
  //                         )
  //                       : Column(
  //                           children: [
  //                             const Icon(
  //                               Icons.image_outlined,
  //                               color: Color(0xFFC13584),
  //                             ),
  //                             Text(
  //                               "Attachment",
  //                               style: GoogleFonts.nunito(
  //                                   fontSize: 10,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: Colors.black.withOpacity(0.5)),
  //                             )
  //                           ],
  //                         ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildFileUploadSection(String title, String type) {
    final AccountSetupController accountController =
        Get.put(AccountSetupController());
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
              accountController.pickFile(type);
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

  List<Widget> _buildDropdowns() {
    final AccountSetupController accountController =
        Get.put(AccountSetupController());
    return [
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
            ),
          ],
        ),
      ),
    ];
  }

  Widget placesAutoCompleteTextField(AccountSetupController accountController) {
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
