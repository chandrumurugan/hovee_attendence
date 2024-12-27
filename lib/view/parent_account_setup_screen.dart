import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/parent_accountsetup_controller.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDropDownInputField.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/utils/keyboardUtils.dart';

class ParentAccountSetupScreen extends StatelessWidget {
   ParentAccountSetupScreen({super.key});
   
 final ParentAccountSetupController parentController = Get.put(ParentAccountSetupController());
  final splashController = Get.find<SplashController>();
  
  @override
  Widget build(BuildContext context) {
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
        body:  GestureDetector(
             onVerticalDragUpdate: (details) {
            // Detect dragging on the map

            if (details.localPosition.dy <= parentController.mapHeight.value) {
              // setState(() {
              //   _isMapInteracting = true;
              // });
              parentController.isMapInteracting.value = true;
            }
          },
          onVerticalDragEnd: (details) {
            // Reset the interaction flag when the drag ends
            // setState(() {
            //   _isMapInteracting = false;
            // });
            parentController.isMapInteracting.value = true;
          },
          child: Stack(
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
                        height
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
                              controller: parentController.tabController,
                              onTap: (int index) {
                               
                                KeyboardUtil.hideKeyboard(context);
                              },
                              tabs: [
                                const Tab(
                                  text: 'Personal info',
                                ),
                                const Tab(
                                  text: 'Address',
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
                                controller: parentController.tabController,
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
                                                      controller: parentController
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
                                                    controller: parentController
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
                                              controller: parentController
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
                                                  parentController.dobController),
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
                                                  parentController.phController),
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
                                                parentController.pincodeController,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     const Text(
                                          //       'ID Proof',
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
                                          //         color:
                                          //             Colors.red.withOpacity(0.6),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          // InkWell(
                                          //   onTap: () {
                                          //     print("gretting values==");
                                          //     ModalService.openIDProofModalSheet(
                                          //         context,
                                          //         splashController,
                                          //         parentController);
                                          //   },
                                          //   child: Container(
                                          //     height: 55,
                                          //     alignment: Alignment.centerLeft,
                                          //     padding: const EdgeInsets.only(
                                          //         top: 10, bottom: 10, left: 12),
                                          //     decoration: BoxDecoration(
                                          //         color: Colors.grey[200],
                                          //         borderRadius:
                                          //             BorderRadius.circular(15)),
                                          //     child: parentController
                                          //             .selectedIDProof
                                          //             .value
                                          //             .isNotEmpty
                                          //         ? Text(parentController
                                          //             .selectedIDProof.value)
                                          //         : Text(
                                          //             "Tap to select the ID proof",
                                          //             style: TextStyle(
                                          //                 color: Colors.grey[400],
                                          //                 fontWeight:
                                          //                     FontWeight.w400)),
                                          //   ),
                                          // ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              KeyboardUtil.hideKeyboard(context);
                                               if (parentController.validateFields(context)) {
                                               parentController.tabController.animateTo(1);
                                               }
                                            //parentController.signIn(context);
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
                                                  parentController.isLoading.value
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
                                           placesAutoCompleteTextField(
                                              parentController),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Obx(() => Stack(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.25,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  8.0)),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  8.0)),
                                                      child: GoogleMap(
                                                        initialCameraPosition:
                                                            const CameraPosition(
                                                          target:
                                                              LatLng(0.0, 0.0),
                                                          zoom: 10,
                                                        ),
                                                        onMapCreated:
                                                            parentController
                                                                .onMapCreated,
                                                        markers:
                                                            parentController
                                                                        .marker
                                                                        .value !=
                                                                    null
                                                                ? {
                                                                    parentController
                                                                        .marker
                                                                        .value!
                                                                  }
                                                                : {},
                                                        onTap: (position) {
                                                          parentController
                                                              .setMarker(
                                                                  position);
                                                        },
                                                        zoomControlsEnabled:
                                                            false,
                                                      ),
                                                    ),
                                                  ),
                                                  if (parentController
                                                      .isLoading.value)
                                                    Positioned.fill(
                                                      child: Container(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        child: const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      ),
                                                    ),
                                                  Positioned(
                                                    top: 10,
                                                    right: 10,
                                                    child: Column(
                                                      children: [
                                                        FloatingActionButton(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          onPressed: () =>
                                                              parentController
                                                                  .zoomIn(),
                                                          mini: true,
                                                          child: const Icon(
                                                              Icons.zoom_in,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        FloatingActionButton(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          onPressed: () =>
                                                              parentController
                                                                  .zoomOut(),
                                                          mini: true,
                                                          child: const Icon(
                                                              Icons.zoom_out,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
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
                                              controller: parentController
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
                                              controller: parentController
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
                                                  parentController.cityController),
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
                                              controller: parentController
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
                                                parentController.countryController,
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
                                            controller: parentController
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
                                              parentController.signIn(context);
                                               
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
                                                  parentController.isLoading.value
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
                                  ),
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
      ),
    );
  }

    Widget placesAutoCompleteTextField(ParentAccountSetupController parentController) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: parentController.autoCompleteController,
        googleAPIKey: "AIzaSyCe2-5wVLxW2xSeQpqVzVCEt9n3ppUAwXA",
        inputDecoration: InputDecoration(
          hintText: "Search your location",
          filled: true,
          fillColor: Colors.grey.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          suffixIcon: const Icon(Icons.search),
        ),
        debounceTime: 800,
        countries: const ["in", "QA"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          parentController.handleAutoCompleteSelection(prediction);
        },
        itemClick: (Prediction prediction) {
          parentController.autoCompleteController.text =
              prediction.description!;
          parentController.focusNode.unfocus();
        },
        focusNode: parentController.focusNode,
      ),
    );
  }
}