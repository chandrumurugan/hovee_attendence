// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/modals/googleSignInModel.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/utils/keyboardUtils.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/home_screen/guest_home_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:hovee_attendence/view/roleSelection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignUp extends StatelessWidget {
  const LoginSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthControllers authController = Get.put(AuthControllers());
    final splashController = Get.find<SplashController>();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarHeader(
          needGoBack: false,
          navigateTo: () {},
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.24,
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
                          'Welcome !',
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
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.2,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Visibility(
                          visible: authController.tabController.index == 0,
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  color: Colors.grey.shade400,
                                  height: 2,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  color: Colors.grey.shade400,
                                  height: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Login with",
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Visibility(
                          visible: authController.tabController.index == 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            child: InkWell(
                              onTap: () async {
                                var googleResponse =
                                    await authController.signInWithGoogle();
                                print(googleResponse);
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                var deviceType =
                                    Platform.isAndroid ? 'Android' : 'Ios';
                                String? token =
                                    prefs.getString('google_token') ?? '';
                                print(token);
                                var response = await WebService.googleSignIn(
                                    token, deviceType, context);
                                if (response != null) {
                                  authController.isGLoading = false.obs;
                                  prefs.setString(
                                      'Token', response.data!.token!);
                                  prefs.setString(
                                      'UserEmail', response.data!.user!.email!);
                                  // Split the full name into first and last name
                                  String fullName = response.data!.user!.name!;
                                  List<String> nameParts = fullName.split(' ');

// Ensure there are at least two parts (first name and last name)
                                  String firstName =
                                      nameParts.isNotEmpty ? nameParts[0] : '';
                                  String lastName =
                                      nameParts.length > 1 ? nameParts[1] : '';

// Save the first and last names separately
                                  prefs.setString('UserName', firstName);
                                  prefs.setString('UserLastName', lastName);
                                   String title1 = response.data!.accountSetup! == false
                                                  ? 'Registered' 
                                                  : 'Logged in';
                                  showModalBottomSheet(
                                    isDismissible: false,
                                    enableDrag: false,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return CustomDialogBox(
                                        title1: title1,
                                        title2: "successfully !",
                                        subtitle: 'subtitle',
                                        btnName: 'Ok',
                                        onTap: () {
                                          Navigator.pop(context);
                                          if (response.data!.accountSetup! &&
                                              response.data!.accountVerified!) {
                                            print(response
                                                .data!.user!.role!.roleName!);
                                            Get.offAll(() => DashboardScreen(
                                                rolename: response.data!.user!
                                                    .role!.roleName!));
                                          } else {
                                            Get.offAll(
                                                () => const RoleSelection(
                                                      isFromParentOtp: false,
                                                      isGoogleSignIn: true,
                                                    ));
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                        color: const Color(0xFF833AB4),
                                        singleBtn: true,
                                      );
                                    },
                                  );
                                }
                                authController.isGLoading = false.obs;
                              },
                              child: Image.asset(
                                'assets/appConstantImg/loginSignupI/google_2504739.png',
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: authController.tabController.index == 0,
                          child: Image.asset(
                            'assets/appConstantImg/loginSignupI/image 203.png',
                            height: 150,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: Obx(() {
                    return Container(
                      height: authController.currentTabIndex.value == 0 ||
                              authController.tabController.index == 0
                          ? 265
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
                            controller: authController.tabController,
                            onTap: (int index) {
                              if (index == 1) {
                                authController.tabController.animateTo(1);
                              }

                              authController.currentTabIndex.value = index;
                              authController.isLoading.value = false;
                              KeyboardUtil.hideKeyboard(context);
                            },
                            tabs: const [
                              Tab(
                                text: 'Login',
                              ),
                              Tab(
                                text: 'Sign up',
                              ),
                            ],
                            unselectedLabelColor: Colors.grey,
                            unselectedLabelStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                                controller: authController.tabController,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Enter Phone no / Email ID',
                                          style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        InputTextField(
                                          suffix: false,
                                          readonly: false,
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                r"[a-zA-Z0-9\s@&_,-\/.']",
                                              ),
                                            ),
                                          ],
                                          hintText: 'Enter here...',
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller:
                                              authController.logInController,
                                        ),
                                        // const SizedBox(
                                        //   height: 20,
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                color: Colors.white,
                                                width: 30,
                                                child: Checkbox(
                                                  value: authController
                                                      .isChecked.value,
                                                  checkColor: Colors.white,
                                                  activeColor: AppConstants
                                                      .secondaryColor,
                                                  onChanged: (bool? value) {
                                                    authController.isChecked
                                                        .value = value!;
                                                    if (authController
                                                        .isChecked.value) {
                                                      authController
                                                          .saveForLaterUse();
                                                    } else {
                                                      print("getting true");
                                                      authController
                                                          .removeLaterUse();
                                                    }
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 0),
                                              Text(
                                                "Remember me",
                                                style: GoogleFonts.nunito(
                                                  fontSize: 12.0,
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //                     const Padding(
                                        //                       padding: EdgeInsets.symmetric(
                                        //                           horizontal: 20),
                                        //                       child: Divider(),
                                        //                     ),
                                        //                     const SizedBox(
                                        //                       height: 10,
                                        //                     ),
                                        //                       Text(
                                        //   "Login with",
                                        //   style: GoogleFonts.nunito(
                                        //     fontSize: 12,
                                        //     color: Colors.black.withOpacity(0.5),
                                        //     fontWeight: FontWeight.w500,
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        // GestureDetector(
                                        //   onTap: () async {
                                        // var googleResponse = await _signInWithGoogle();
                                        // var response = await WebService.googleSignin(
                                        //     displayName: googleResponse!.displayName!,
                                        //     email: googleResponse.email!,
                                        //     photoUrl: googleResponse.photoURL!);
                                        // if (response != null) {
                                        //    authController. isGLoading = false.obs;
                                        //   // showModalBottomSheet(
                                        //   //     backgroundColor: Colors.transparent,
                                        //   //     isDismissible: false,
                                        //   //     enableDrag: false,
                                        //   //     context: context,
                                        //   //     builder: (context) {
                                        //   //       return CustomDialogBox(
                                        //   //           title1:response is GoogleUserModal ? "Registered" :'Logged In',
                                        //   //           title2: 'successfully !',
                                        //   //           subtitle: 'subtitle',
                                        //   //           btnName: 'Ok',
                                        //   //           onTap: () {
                                        //   //             // if(response.data.userdetails.)
                                        //   //             Navigator.pop(context);

                                        //   //           },
                                        //   //           icon: Icon(
                                        //   //             Icons.check,
                                        //   //             color: Colors.white,
                                        //   //           ),
                                        //   //           color: Colors.green,
                                        //   //           singleBtn: true);
                                        //   //     });
                                        // }
                                        //  authController. isGLoading = false.obs;
                                        //   },
                                        //   child: const SizedBox(
                                        //     height: 36,
                                        //     child: Center(
                                        //       child: Image(
                                        //         image: AssetImage("assets/icons/google_icon.png"),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                authController.logIn(
                                                    authController
                                                        .logInController.text,
                                                    context);
                                              },
                                              child: Container(
                                                height: 48,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                ),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFFC13584),
                                                      Color(0xFF833AB4)
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                ),
                                                child: authController
                                                        .isLoading.value
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : const Center(
                                                        child: Text(
                                                          'Login',
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
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const GuestHomeScreen());
                                              },
                                              child: Text(
                                                "Maybe later",
                                                style: GoogleFonts.nunito(
                                                  fontSize: 15.0,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),

                                  //signup component
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
                                                  color: Colors.red
                                                      .withOpacity(0.6),
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
                                                      hintText: 'First name',
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
                                                      controller: authController
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
                                                    hintText: 'Last name',
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
                                                    controller: authController
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
                                                    r"[a-zA-Z0-9@&_,-\/.']",
                                                  ),
                                                ),
                                              ],
                                              hintText: 'Enter here...',
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              controller: authController
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
                                                  color: Colors.red
                                                      .withOpacity(0.6),
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
                                              hintText: 'Select',
                                              initialDate:
                                                  DateTime.now().subtract(
                                                const Duration(days: 365 * 18),
                                              ),
                                              lastDate: DateTime.now().subtract(
                                                const Duration(days: 365 * 18),
                                              ),
                                              keyboardType:
                                                  TextInputType.datetime,
                                              controller:
                                                  authController.dobController),
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
                                                  color: Colors.red
                                                      .withOpacity(0.6),
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
                                                      width:
                                                          70, // Ensure the Container has a width
                                                      height:
                                                          46, // Make the height same as the parent SizedBox
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                                0xffD9D9D9)
                                                            .withOpacity(0.4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                    ),
                                                    CountryCodePicker(
                                                      onChanged: print,
                                                      countryList:
                                                          authController
                                                              .country_codes,
                                                      initialSelection:
                                                          'IN', // Changed to 'IN' for India
                                                      favorite: [
                                                        '+91'
                                                      ], // Added '+91' for India as favorite
                                                      showCountryOnly: false,
                                                      showOnlyCountryWhenClosed:
                                                          false,
                                                      alignLeft: false,
                                                      showFlag: false,
                                                      padding: const EdgeInsets
                                                          .all(
                                                          0), // Add padding if needed
                                                      textStyle: const TextStyle(
                                                          color: Colors
                                                              .black), // Adjust text style if needed
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Expanded(
                                                  // Use Expanded to fill the remaining space
                                                  child: InputTextField(
                                                    suffix: false,
                                                    readonly: false,
                                                    hintText: 'Enter here...',
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatter: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(r"[0-9]"),
                                                      ),
                                                      LengthLimitingTextInputFormatter(
                                                          10), // Restrict to 10 digits
                                                    ],
                                                    controller: authController
                                                        .phController,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //       Row(
                                          //         children: [
                                          //           CountryCodePicker(
                                          //   onChanged: print,
                                          //   countryList:authController. country_codes,
                                          //   initialSelection:
                                          //       'IN', // Changed to 'IN' for India
                                          //   favorite: [
                                          //     '+91'
                                          //   ], // Added '+91' for India as favorite
                                          //   showCountryOnly: false,
                                          //   showOnlyCountryWhenClosed: false,
                                          //   alignLeft: false,
                                          //   showFlag: false,
                                          //   padding: EdgeInsets.all(
                                          //       0), // Add padding if needed
                                          //   textStyle: TextStyle(
                                          //       color: Colors
                                          //           .black), // Adjust text style if needed
                                          // ),
                                          //           Expanded(
                                          //             child: InputTextField(
                                          //               suffix: false,
                                          //               readonly: false,
                                          //               hintText: 'Enter here...',
                                          //               keyboardType: TextInputType.number,
                                          //               inputFormatter: [
                                          //                 FilteringTextInputFormatter.allow(
                                          //                   RegExp(r"[0-9]"),
                                          //                 ),
                                          //                 LengthLimitingTextInputFormatter(
                                          //                     10), // Restrict to 10 digits
                                          //               ],
                                          //               controller:
                                          //                   authController.phController,
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),

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
                                                  color: Colors.red
                                                      .withOpacity(0.6),
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
                                            controller: authController
                                                .pincodeController,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child:
                                                    CheckboxListTile.adaptive(
                                                  value: authController
                                                      .acceptedTerms.value,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 0),
                                                  activeColor: AppConstants
                                                      .secondaryColor,
                                                  onChanged: (bool? newValue) {
                                                    authController.acceptedTerms
                                                            .value =
                                                        newValue ?? false;
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  dense:
                                                      true, // Makes the CheckboxListTile more compact
                                                  visualDensity: VisualDensity
                                                      .compact, // Further reduces spacing
                                                  title: Text(
                                                    'I consent to submit ID proof for profile updates',
                                                    overflow: TextOverflow.clip,
                                                    style: GoogleFonts.nunito(
                                                      height: 1.5,
                                                      fontSize: 13,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: authController
                                                .acceptedTerms.value,
                                            child: const SizedBox(
                                              height: 5,
                                            ),
                                          ),
                                          Visibility(
                                            visible: authController
                                                .acceptedTerms.value,
                                            child: Row(
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
                                                    color: Colors.red
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: authController
                                                .acceptedTerms.value,
                                            child: const SizedBox(
                                              height: 5,
                                            ),
                                          ),
                                          Visibility(
                                            visible: authController
                                                .acceptedTerms.value,
                                            child: InkWell(
                                              onTap: () {
                                                print("gretting values==");
                                                ModalService
                                                    .openIDProofModalSheet(
                                                        context,
                                                        splashController,
                                                        authController);
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
                                                child: authController
                                                        .selectedIDProof
                                                        .value
                                                        .isNotEmpty
                                                    ? Text(authController
                                                        .selectedIDProof.value)
                                                    : Text(
                                                        "Tap to select the ID proof",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[400],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                  text:
                                                      'By continuing, you agree to ',
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 12,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Terms & Conditions',
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 12,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {},
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Get updates on ',
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 13,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const Icon(
                                                        FontAwesomeIcons
                                                            .whatsapp,
                                                        color: Colors.green),
                                                    Text(
                                                      ' WhatsApp',
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 13,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // Add some spacing between text and switch
                                                SizedBox(
                                                  height: 25,
                                                  width: 50,
                                                  child: Transform.scale(
                                                    scale: 0.7,
                                                    child: Switch(
                                                      // activeColor:
                                                      //     AppConstants
                                                      //         .secondaryColor,
                                                      value: authController
                                                          .isTickedWhatsApp
                                                          .value,
                                                      onChanged: (value) {
                                                        authController
                                                                .isTickedWhatsApp
                                                                .value =
                                                            value ?? false;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              authController.signIn(context);
                                            },
                                            child: Container(
                                              height: 48,
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                    Color(0xFF833AB4)
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                              child: authController
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
                                                              FontWeight.w600,
                                                          color: Colors.white,
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
                                ]),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
