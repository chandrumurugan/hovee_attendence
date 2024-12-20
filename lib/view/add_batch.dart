import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/add_batch_controller.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/widget/addteacher_dropdown.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/multipleCheckDropDown.dart';
import 'package:hovee_attendence/widget/single_button.dart';
import 'package:intl/intl.dart';

class TutorAddBatchScreen extends StatefulWidget {
  const TutorAddBatchScreen({super.key});

  @override
  State<TutorAddBatchScreen> createState() => _TutorAddBatchScreenState();
}

class _TutorAddBatchScreenState extends State<TutorAddBatchScreen> {
  final BatchController controller = Get.put(BatchController());
  UserProfileController accountController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
     controller.batchTeacher.text = accountController
                                                .firstNameController.text;
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          controller.onInit();
          Navigator.pop(context);
          
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.12,
              width: size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Image.asset('assets/bgImage/peopleTop.png'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                'Add Batch',
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           const Text(
            //             'Batch short name',
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
            //         height: 10,
            //       ),
            //       CommonInputField(
            //         // title: 'Branch short name',
            //         controllerValue: controller.branchShortNameController,
            //         selectedValue: controller.branchShortNameController,
            //         keyboardType: TextInputType.text,
            //         hintText: 'Enter here...',
            //         onTap: () {}, controller: controller.branchShortName,
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Batch name',
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
                  CommonInputField(
                    // title: 'Batch name',
                    controllerValue: controller.batchNameController,
                    selectedValue: controller.batchNameController,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter here...',
                    onTap: () {}, controller: controller.batchName,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Batch tutor',
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
                  // CommonDropdownInputField(
                  //   title: 'Batch teacher',
                  //   controllerValue: controller.batchTeacherController,
                  //   selectedValue: controller.batchTeacherController,
                  //   items: controller.teacher,
                  //   onChanged: controller.setTeacher,
                  // ),
                  Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey.shade200),
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
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Batch Timing Start',
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
                  CommonInputField(
                    // title: 'Batch Timing Start',
                    controllerValue: controller.batchTimingController,
                    selectedValue: controller
                        .batchTimingController, // Make the field read-only to prevent manual input
                    //suffixIcon: Icon(Icons.arrow_drop_down), // Add dropdown icon
                    onChanged: controller.setStartTiming,
                    hintText: 'Select',
                     readonly: true,
                    onTap: () async {
                      // Show time picker and pass the current context
                      print("start time");
                      await _showTimePicker(context, isStartTime: true);
                    }, controller: controller.batchTiming,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Batch Timing End',
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
                  CommonInputField(
                    // title: 'Batch Timing End',
                    controllerValue: controller.batchTimingEndController,
                    // Make the field read-only to prevent manual input
                    //suffixIcon: Icon(Icons.arrow_drop_down), // Add dropdown icon
                    selectedValue: controller.batchTimingEndController,
                    onChanged: controller.setEndingTiming,
                    hintText: 'Select',
                    readonly: true,
                    onTap: () async {
                      // Show time picker and pass the current context
                   await _showTimePicker(context, isStartTime: false);
                    }, controller: controller.batchTimingEnd,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Maximum slots',
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
                  CommonInputField(
                    // readOnly
                    // title: 'Maximum slots',
                    hintText: 'Enter here...',
                    controllerValue: controller.maxSlotsController,
                    selectedValue: controller.maxSlotsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ], // Allow only digits
                    onTap: () {}, controller: controller.maxSlots,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Batch days',
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
                  // CommonDropdownInputField(
                  //   title: 'Batch days',
                  //   controllerValue: controller.batchDaysController,
                  //   selectedValue: controller.batchDaysController,
                  //   items: controller.batchDays,
                  //   onChanged: controller.setBatchDays,
                  // ),
                  CommonDropdownInputFieldDays(
  title: 'Batch Days',
  selectedValues: controller.selectedBatchDays,
  items: controller.batchDays,
  onChanged: (selected) {
    print('Selected Batch Days: $selected');
    controller.setBatchDays;
  },
),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Mode',
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
                  CommonDropdownInputField(
                    title: 'Mode',
                    controllerValue: controller.modeController,
                    selectedValue: controller.modeController,
                    items: controller.batchModes,
                    onChanged: controller.setBatchModes,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Fees',
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
                  CommonInputField(
                    // title: 'Fees',
                    hintText: 'Enter here...',
                    controllerValue: controller.feesController,
                    selectedValue: controller.feesController,
                    keyboardType: TextInputType.phone,
                    onTap: () {},
                    prefixText: '₹ ', // Add the rupee symbol as prefix
                    suffixText: '/month', controller: controller.fees,
                     inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(r"[0-9]"),
                                              ),
                                              LengthLimitingTextInputFormatter(
                                                  10), // Restrict to 10 digits
                                            ], // Add "/month" as suffix
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controller.validationMessages.isNotEmpty) {
                return Column(
                  children: controller.validationMessages
                      .map((msg) => Text(
                            msg,
                            style: const TextStyle(color: Colors.red),
                          ))
                      .toList(),
                );
              }
              return const SizedBox
                  .shrink(); // If no validation errors, return empty widget
            }),
            SingleButton(
              
              btnName: 'Add',
              onTap: () {
                controller.addBatch(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showTimePicker(BuildContext context,
      {required bool isStartTime}) async {
    // Show the time picker dialog
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Update the appropriate controller based on isStartTime
      if (isStartTime) {
        controller.batchTiming.text = pickedTime.format(context);
      } else {
        controller.batchTimingEnd.text = pickedTime.format(context);
      }
    }
  }
}
