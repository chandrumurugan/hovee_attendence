import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/hostel_msp_controller.dart';
import 'package:hovee_attendence/controllers/msp_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/single_button.dart';

class EditMspHostelScreen extends StatelessWidget {
   final String batchname,date,reason,id,batchEnd,hostelId,hostelObjId,hostellerObjId;
   EditMspHostelScreen({super.key, required this.batchname, required this.date, required this.reason, required this.id, required this.batchEnd, required this.hostelId, required this.hostelObjId, required this.hostellerObjId});
 final HostelMspController mspController = Get.put(HostelMspController());
  @override
  Widget build(BuildContext context) {
      mspController.batchNameController.value = batchname ?? '';
         mspController.batchNameController1.text = batchname ?? '';
    mspController.startDateController.text = date;
    mspController.batchTiming.text = batchEnd ?? '';
   mspController.reason.text = reason ?? '';
   Size size = MediaQuery.sizeOf(context);
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
                'Edit MSP',
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
      const SizedBox(height: 5),
      TextField(
        controller: mspController.batchNameController1,
        enabled: false, // Makes it non-editable
        decoration: InputDecoration(
          hintText: 'Select',
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    ],
  ),
),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
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
      const SizedBox(height: 5),
      TextField(
        controller: mspController.startDateController,
        enabled: false, // Makes it non-editable
        decoration: InputDecoration(
          hintText: 'Select',
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
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
            SingleButton(
              btnName: 'Add',
              onTap: () {
              mspController.editMSP(context,id,hostelId,hostelObjId,hostellerObjId);
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