// ignore_for_file: file_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';

class LoginSignUp extends StatelessWidget {
  const LoginSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthControllers authController = Get.put(AuthControllers());
    final splashController = Get.find<SplashController>();

    return Scaffold(
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
                      // const Text(
                      //   'Lorem Ipsum is simply dummy text\n of the printing and typesetting industry',
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 16),
                      // ),
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
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150,
                                color: Colors.grey.shade400,
                                height: 2,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                color: Colors.grey.shade400,
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: authController.tabController.index == 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: InkWell(
                            onTap: () {
                              // controller.signInWithGoogle().then((value) {
                              //   if (value.user!.uid.isNotEmpty) {
                              //     if (context.mounted) {
                              //       Navigator.pushReplacement(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) =>
                              //                   const ChatRoom()));
                              //     }
                              //   }
                              // });
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
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                surfaceTintColor: Colors.white,
                color: Colors.white,
                child: Obx(() {
                  return Container(
                    height: authController.currentTabIndex.value == 0
                        ? 250
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
                            authController.currentTabIndex.value = index;
                            authController.isLoading.value = false;
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                              r"[a-zA-Z0-9\s@&_,-\.']",
                                            ),
                                          ),
                                        ],
                                        hintText: 'Phone number / Email ID',
                                        keyboardType: TextInputType.name,
                                        controller:
                                            authController.logInController,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              authController.logIn(
                                                  authController
                                                      .logInController.text,context);
                                            },
                                            child: Container(
                                              height: 48,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 40,
                                              ),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
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
                                        ],
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
                                                    hintText: 'First name',
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
                                                        r"[a-zA-Z0-9\s@&_,-\.']",
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
                                            hintText: 'Enter here',
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller:
                                                authController.emailController),
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
                                            hintText: 'Select your dob',
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
                                              authController.phController,
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
                                          readonly: false,
                                          hintText: 'Enter your pincode',
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                r"[0-9]",
                                              ),
                                              
                                            ),
                                            LengthLimitingTextInputFormatter(
                                                6),
                                          ],
                                          keyboardType: TextInputType.number,
                                          controller:
                                              authController.pincodeController,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: CheckboxListTile.adaptive(  value: authController
                                                    .acceptedTerms.value,
                                                 contentPadding: const EdgeInsets.symmetric(horizontal: 0), 
                                                
                                                onChanged: (bool? newValue) {
                                                  authController.acceptedTerms
                                                      .value = newValue ?? false;},
                                                      controlAffinity: ListTileControlAffinity.leading,
                                                      // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                      
                                                      
                                                      title:  Text(
                                                'I allow to submit ID proof to update profile info',
                                                overflow: TextOverflow.clip,
                                                style: GoogleFonts.nunito(
                                                  height: 1.5,
                                                  fontSize: 13,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ) ,),
                                            ),
                                            // Checkbox(
                                            //   value: authController
                                            //       .acceptedTerms.value,
                                            //   onChanged: (bool? newValue) {
                                            //     authController.acceptedTerms
                                            //         .value = newValue ?? false;
                                            //     // setState(() {
                                            //     //   _acceptedTerms =
                                            //     //       newValue!;
                                            //     // });
                                            //   },
                                            // ),
                                            // Text(
                                            //   'I allow to submit ID proof to update profile info',
                                            //   overflow: TextOverflow.clip,
                                            //   style: GoogleFonts.nunito(
                                            //     height: 1.5,
                                            //     fontSize: 13,
                                            //     color: Colors.black
                                            //         .withOpacity(0.5),
                                            //     fontWeight: FontWeight.w500,
                                            //   ),
                                            // ),
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
                                                  ?Text(authController
                                                      .selectedIDProof.value)
                                                  : Text(
                                                      "Tap to select the ID proof",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontWeight:
                                                              FontWeight.w400)),
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
                                                    text: 'Terms & Conditions',
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
                                                mainAxisSize: MainAxisSize.min,
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
                                                      FontAwesomeIcons.whatsapp,
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
                                                        .isTickedWhatsApp.value,
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
                                                  Color(0xFF833AB4)
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                            child:
                                                authController.isLoading.value
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : const Center(
                                                        child: Text(
                                                          'Sign In',
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
    );
  }
}