import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/controllers/holiday_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/widget/addteacher_dropdown.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/single_button.dart';

class AddHolidayScreen extends StatelessWidget {
   AddHolidayScreen({super.key});
 final HolidayController holidayController = Get.put(HolidayController());
 final BatchController controller = Get.put(BatchController());
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          holidayController.onInit();
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
                'Add holiday',
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
                      controllerValue: holidayController.batchNameController,
                      selectedValue: holidayController.batchNameController,
                      items: controller.batchName1,
                      onChanged: holidayController.setBatchName,
                      isNonEdit: false,
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
                        'Holiday name',
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
                    controllerValue: holidayController.holidayNameController,
                    selectedValue: holidayController.holidayNameController,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter here...',
                    onTap: () {}, controller: holidayController.holidayName,
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
                          'Choose holiday type',
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
                      title: 'holiday type',
                      controllerValue: holidayController.holidayTypeController,
                      selectedValue: holidayController.holidayTypeController,
                      items: holidayController.holidayaType,
                      onChanged: holidayController.setHolidayType,
                      isNonEdit: false,
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
                    'From date',
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
                controller: holidayController.startDateController,
              ),
            ),
             Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  const Text(
                    'End date',
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
                controller: holidayController.endDateController,
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
                        'Description',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  CommonInputField(
                    // title: 'Batch name',
                    controllerValue: holidayController.descriptionController,
                    selectedValue: holidayController.descriptionController,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter here...',
                    onTap: () {}, controller: holidayController.description,
                  ),
                ],
              ),
            ),
            Obx(() {
              if (holidayController.validationMessages.isNotEmpty) {
                return Column(
                  children: holidayController.validationMessages
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
              if (!holidayController.validateFields(context)) {
      // If validation fails, return early and don't show the dialog
      return;
    }
              else {
                 _showConfirmationDialog(context);
              }
              
              },
            )
          ],
        ),
      ),
    );
  }

   void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Do you want to add this holiday? ',
          title2: '',
          subtitle: 'Do you want to add this holiday? ',
          icon: const Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          color: const Color(0xFF833AB4), // Set the primary color
          color1: const Color(0xFF833AB4), // Optional gradient color
          singleBtn: false, // Show both 'Yes' and 'No' buttons
          btnName: 'No',
          onTap: () {
            // Call the updateClass method when 'Yes' is clicked
            // Close the dialog after update
            Navigator.of(context).pop();
          },
          btnName2: 'Yes',
          onTap2: () {
            // Close the dialog when 'No' is clicked
            holidayController.addHoliday(context);
            // classController.tabController.animateTo(1);
            // classController.handleTabChange(1);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}