import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/leave_controller.dart';
import 'package:hovee_attendence/modals/getLeaveListModel.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/customDropDownInputField.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/single_button.dart';

class EditleaveScreen extends StatelessWidget {
   final LeaveData batch;
   EditleaveScreen({super.key, required this.batch});
     final TuteeLeaveController leaveController = Get.put(TuteeLeaveController());
  @override
  Widget build(BuildContext context) {
    
    leaveController.batchNameController.value = batch.batchDetails!=null?  batch.batchDetails!.batchName ?? '': '';
    leaveController.leaveTypeController.value = batch.leaveType ?? '';
    leaveController.startDateController.text = batch.fromDate ?? '';
    leaveController.endDateController.text = batch.endDate ?? '';
    leaveController.reason.text=batch.reason ?? '';
     Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          leaveController.onInit();
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
                'Add leave request',
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
                      controllerValue: leaveController.batchNameController,
                      selectedValue: leaveController.batchNameController,
                      items: leaveController.batchName1,
                      onChanged: leaveController.setBatchName,
                      
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
                          'Choose leave type',
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
                      title: 'Leave type',
                      controllerValue: leaveController.leaveTypeController,
                      selectedValue: leaveController.leaveTypeController,
                      items: leaveController.leaveType,
                      onChanged: leaveController.setHolidayType,
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
                controller: leaveController.startDateController,
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
                controller: leaveController.endDateController,
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
                       )
                    ],
                  ),
                  CommonInputField(
                    // title: 'Batch name',
                    controllerValue: leaveController.reasonController,
                    selectedValue: leaveController.reasonController,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter here...',
                    onTap: () {}, controller: leaveController.reason,
                  ),
                ],
              ),
            ),
            Obx(() {
              if (leaveController.validationMessages.isNotEmpty) {
                return Column(
                  children: leaveController.validationMessages
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
              if (!leaveController.validateFields(context)) {
      // If validation fails, return early and don't show the dialog
      return;
    }
              else {
                 _showConfirmationDialog(context,batch.sId!);
              }
              },
            )
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Do you want to update your leave request?',
          title2: '',
          subtitle: 'Do you want to update your leave request?',
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
           leaveController.updateBatch(context,batch.sId!);
            // classController.tabController.animateTo(1);
            // classController.handleTabChange(1);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}