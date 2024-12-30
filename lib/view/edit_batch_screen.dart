import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/modals/getbatchlist_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDropDownInputField.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/widget/add_days_dropdown.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/multipleCheckDropDown.dart';
import 'package:hovee_attendence/widget/single_button.dart';
import 'package:logger/logger.dart';

class EditBatchScreen extends StatelessWidget {
  final Data2 batch;
   EditBatchScreen({super.key, required this.batch});
final BatchController controller = Get.put(BatchController());

  @override
  Widget build(BuildContext context) {
    Logger().i("getting runtime==?>>>${batch.batchDays}");
     controller.batchName.text = batch.batchName ?? '';
    controller.batchTeacherController.value = batch.batchTeacher ?? '';
    controller.batchTimingController.value = batch.batchTimingStart ?? '';
    controller.batchTimingEndController.value = batch.batchTimingEnd ?? '';
    controller.batchTiming.text=batch.batchTimingStart ?? '';
    controller.batchTimingEnd.text=batch.batchTimingEnd ?? '';
    controller.maxSlots.text = batch.batchMaximumSlots.toString();
    controller.batchDaysController.value = batch.batchDays.toString();
    controller.modeController.value = batch.batchMode ?? '';
    controller.fees.text = batch.fees.toString();
    controller.startDateController.text = batch.startDate.toString();
    controller.endDateController.text = batch.endDate.toString();
     Size size = MediaQuery.sizeOf(context);
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
                'Edit Batch',
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
                        'Batch teacher',
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
                    title: 'Batch teacher',
                    controllerValue: controller.batchTeacherController,
                    selectedValue: controller.batchTeacherController,
                    items: controller.teacher,
                    onChanged: controller.setTeacher,
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
                        'Batch start time ',
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
                        'Batch end time ',
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
                        'Batch maximum slots',
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
                    controllerValue: controller.batchDaysController,
                    title: 'Batch Days',
                    items: controller.batchDays,
                    onChanged: (selected) {
                      print('Selected Batch Days: $selected');
                      controller.setBatchDays;
                    },
                    selectedValues: controller.selectedBatchDays,
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
                                    Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'Start Date',
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
            // const SizedBox(
            //   height: 5,
            // ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
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
                controller: controller.startDateController,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'End Date',
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
            // const SizedBox(
            //   height: 5,
            // ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
              child: InputTextField(
                  suffix: true,
                  readonly: true,
                  isDate: true,
                  hintText: 'Select',
                 initialDate: DateTime.now(),
                firstDate:
                    DateTime.now(), // Sets the minimum selectable date to today
                lastDate:
                    DateTime(2100),
                  keyboardType: TextInputType.datetime,
                  controller: controller.endDateController),
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
              
              btnName: 'Submit',
              onTap: () {
                controller.updateBatch(context,batch.sId!);
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
