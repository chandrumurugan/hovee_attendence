import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/controllers/msp_controller.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendanceTutee_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDropDownInputField.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/single_button.dart';

class AddMspScreen extends StatelessWidget {
 final BatchList? data;
 final String date;
 final String id,batchId;
   AddMspScreen({super.key, required this.data, required this.date, required this.id, required this.batchId,});
  final MspController mspController = Get.put(MspController());
   final BatchController controller = Get.put(BatchController());
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.sizeOf(context);
       mspController.batchNameController.value = data!.batchName ?? '';
    mspController.startDateController.text = date;

    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.back();
           mspController.onInit();
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
                'Add MSP',
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
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
                          'Choose batch name',
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
                      title: 'batch name',
                      controllerValue: mspController.batchNameController,
                      selectedValue: mspController.batchNameController,
                      items: controller.batchName1,
                      onChanged: mspController.setBatchName,
                    ),
                  ],
                ),
              ),
              Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  const Text(
                    'Date',
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
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                suffix: true,
                readonly: true,
                isDate: true,
                hintText: 'Select',
                initialDate: DateTime.now(),
                firstDate:
                    DateTime.now(), // Sets the minimum selectable date to today
                lastDate:
                    DateTime(2100), // You can set this to a far future date
                keyboardType: TextInputType.datetime,
                controller: mspController.startDateController,
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
                        'Time',
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
                    controllerValue: mspController.batchTimingController,
                    selectedValue: mspController
                        .batchTimingController, // Make the field read-only to prevent manual input
                    //suffixIcon: Icon(Icons.arrow_drop_down), // Add dropdown icon
                    onChanged: mspController.setStartTiming,
                    hintText: 'Select',
                     readonly: true,
                    onTap: () async {
                      // Show time picker and pass the current context
                      print("start time");
                      await _showTimePicker(context, isStartTime: true);
                    }, controller: mspController.batchTiming,
                  ),
                ],
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
            //             'Time out',
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
            //       CommonInputField(
            //         // title: 'Batch Timing Start',
            //         controllerValue: mspController.batchTimingEndController,
            //         selectedValue: mspController
            //             .batchTimingEndController, // Make the field read-only to prevent manual input
            //         //suffixIcon: Icon(Icons.arrow_drop_down), // Add dropdown icon
            //         onChanged: mspController.setEndingTiming,
            //         hintText: 'Select',
            //          readonly: true,
            //         onTap: () async {
            //           // Show time picker and pass the current context
            //           print("start time");
            //           await _showTimePicker(context, isStartTime: true);
            //         }, controller: mspController.batchTimingEnd,
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
                        'Reason',
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
                    controllerValue: mspController.reasonController,
                    selectedValue: mspController.reasonController,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter here...',
                    onTap: () {}, controller: mspController.reason,
                  ),
                ],
              ),
            ),
            //   Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           const Text(
            //             'Remarks',
            //             style: TextStyle(
            //               fontSize: 14,
            //               fontWeight: FontWeight.w500,
            //               color: Colors.black,
            //             ),
            //           ),
            //         ],
            //       ),
            //       CommonInputField(
            //         // title: 'Batch name',
            //         controllerValue: mspController.remarksController,
            //         selectedValue: mspController.remarksController,
            //         keyboardType: TextInputType.text,
            //         hintText: 'Enter here...',
            //         onTap: () {}, controller: mspController.remarks,
            //       ),
            //     ],
            //   ),
            // ),
            SingleButton(
              btnName: 'Add',
              onTap: () {
               mspController.addMSP(context,id,batchId);
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
        mspController.batchTiming.text = pickedTime.format(context);
      } else {
        mspController.batchTimingEnd.text = pickedTime.format(context);
      }
    }
  }
}