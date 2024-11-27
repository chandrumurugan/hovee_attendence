
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/accountSetup_controller.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDropDownInputField.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/utils/keyboardUtils.dart';
import 'package:path/path.dart' as path;

class AccountSetup extends StatelessWidget {
  final String roleId;
  final String roleTypeId;
  final String selectedRoleTypeName;
  final String selectedRole;
  AccountSetup(
      {super.key,
      required this.roleId,
      required this.roleTypeId,
      required this.selectedRoleTypeName,
      required this.selectedRole});
  final authController = Get.find<AuthControllers>();
  AccountSetupController accountController = Get.put(AccountSetupController());

  @override
  Widget build(BuildContext context) {
    final splashController = Get.find<SplashController>();

    return WillPopScope(
      onWillPop: ()async{
         return await ModalService.handleBackButtonN(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () async{
          bool isBack =   await ModalService.handleBackButtonN(context);
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
                      height: selectedRole == 'Tutee'
                          ? accountController.currentTabIndex.value == 2
                              ? MediaQuery.of(context).size.height * 0.55
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
                              if(index == 1){
                                accountController.storePersonalInfo(context, roleId, roleTypeId);
                              }
                              accountController.currentTabIndex.value = index;
                              accountController.isLoading.value = false;
                              KeyboardUtil.hideKeyboard(context);
                            },
                            tabs: [
                              const Tab(
                                text: 'Personal info',
                              ),
                              const Tab(
                                text: 'Address',
                              ),
                              if (selectedRoleTypeName != 'Institute')
                                 Tab(
                                  text: selectedRole == 'Tutee' ?'Education':'Professional',
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
                                //personal info
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                                color:
                                                    Colors.black.withOpacity(0.2),
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
                                            readonly: false,
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
                                        InputTextField(
                                            suffix: true,
                                            readonly: true,
                                            isDate: true,
                                            hintText: 'Select',
                                            initialDate: DateTime.now().subtract(
                                              const Duration(days: 365 * 18),
                                            ),
                                            lastDate: DateTime.now().subtract(
                                              const Duration(days: 365 * 18),
                                            ),
                                            keyboardType: TextInputType.datetime,
                                            controller:
                                                accountController.dobController),
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
                                            hintText: 'Enter here...',
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
                                          hintText: 'Enter here...',
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                r"[0-9]",
                                              ),
                                            ),
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          keyboardType: TextInputType.number,
                                          controller:
                                              accountController.pincodeController,
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
                                            KeyboardUtil.hideKeyboard(context);
                                            accountController.storePersonalInfo(
                                                context, roleId, roleTypeId);
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
                                                accountController.isLoading.value
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
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
      
                                //address info
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                            hintText: 'Enter here...',
                                            keyboardType: TextInputType.name,
                                            inputFormatter: [
                                               FilteringTextInputFormatter.allow(
      RegExp(r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
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
                                            hintText: 'Enter here...',
                                            keyboardType: TextInputType.name,
                                            inputFormatter: [
                                               FilteringTextInputFormatter.allow(
      RegExp(r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
    ),
                                            ],
                                            controller:
                                                accountController.cityController),
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
                                            hintText: 'Enter here...',
                                            keyboardType: TextInputType.text,
                                            inputFormatter: [
                                              FilteringTextInputFormatter.allow(
      RegExp(r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
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
                                          hintText: 'Enter here...',
                                          keyboardType: TextInputType.name,
                                          inputFormatter: [
                                            FilteringTextInputFormatter.allow(
      RegExp(r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
    ),
                                          ],
                                          controller:
                                              accountController.countryController,
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
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        InkWell(
                                          onTap: () {
                                             KeyboardUtil.hideKeyboard(context);
                                            accountController.storeAddressInfo(
                                                context,
                                                selectedRoleTypeName,
                                                roleId,
                                                roleTypeId);
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
                                                accountController.isLoading.value
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
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                selectedRoleTypeName == 'Institute' &&
                                        selectedRoleTypeName == ""
                                    ? Container()
                                    : selectedRoleTypeName !=
                                                'Institute' &&
                                            selectedRoleTypeName != ""
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
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                                TextInputType
                                                                    .name,
                                                                    inputFormatter: [
                                                                       FilteringTextInputFormatter.allow(
      RegExp(r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
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
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ))
                                                          .toList(),
                                                    ),
                                                  InkWell(
                                                    onTap: () {
                                                       KeyboardUtil.hideKeyboard(context);
                                                      accountController
                                                          .storeEducationInfo(
                                                              context,
                                                              roleId,
                                                              roleTypeId);
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
              title: 'Highest qualification',
              controllerValue: accountController.tuteeHighestQualification,
              selectedValue: accountController.tuteeHighestQualification,
              items: accountController.tuteeQualifications,
              onChanged: accountController.setTuteeHighestQualification,
            ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'Class/Specialization',
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
                                                      CommonDropdownInputField(
              title: 'Class/Specialization',
              controllerValue: accountController.tuteeSpeciallization,
              selectedValue: accountController.tuteeSpeciallization,
              items: accountController.tuteeSpeciallizationClass,
              onChanged: accountController.setTuteeSpeciallization,
            ),
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
                                                          inputFormatter: [
                                                            FilteringTextInputFormatter.allow(
      RegExp(r"[a-zA-Z0-9\s@&_,-\./']"), // \s allows spaces
    ),
                                                          ],
                                                          hintText:
                                                              'Enter here...',
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          controller:
                                                              accountController
                                                                  .tuteorganizationController),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      InkWell(
                                                        
                                                        onTap: () {
                                                           KeyboardUtil.hideKeyboard(context);
                                                          accountController.storeTuteeeducationInfo(context, roleId, roleTypeId);
                                                        },
                                                        child: Container(
                                                          height: 48,
                                                          padding:
                                                              const EdgeInsets
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
                                                          child:
                                                              accountController
                                                                      .isLoading
                                                                      .value
                                                                  ? const Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    )
                                                                  : const Center(
                                                                      child: Text(
                                                                        'Submit',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color: Colors
                                                                              .white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                        ),
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
}
