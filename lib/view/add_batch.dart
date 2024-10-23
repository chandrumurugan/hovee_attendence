import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/add_batch_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/widget/addteacher_dropdown.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/single_button.dart';
import 'package:intl/intl.dart';

class TutorAddBatchScreen extends StatefulWidget {
  const TutorAddBatchScreen({super.key});

  @override
  State<TutorAddBatchScreen> createState() => _TutorAddBatchScreenState();
}

class _TutorAddBatchScreenState extends State<TutorAddBatchScreen> {
  final TutorAddBatchController controller = Get.put(TutorAddBatchController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: CommonInputField(
                label: 'Branch short name',
                controllerValue: controller.branchShortNameController,
                onTap: () {},
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: CommonInputField(
                label: 'Batch name',
                controllerValue: controller.batchNameController,
                onTap: () {},
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: CommonDropdownInputField(
                title: 'Batch teacher',
                controllerValue: controller.batchTeacherController,
                selectedValue: controller.batchTeacherController,
                items: controller.teacher,
                onChanged: controller.setTeacher,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: CommonInputField(
                label: 'Batch Timing Start',
                controllerValue: controller.batchTimingController,
                readOnly: false, // Makes it read-only, enabling time selection
                onTap: () {}, // Call selectTime with isStartTime
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: CommonInputField(
                label: 'Batch Timing End',
                controllerValue: controller.batchTimingEndController,
                readOnly: false, // Makes it read-only, enabling time selection
                onTap: () {}, // Call selectTime with isStartTime
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: CommonInputField(
                label: 'Maximum slots',
                controllerValue: controller.maxSlotsController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ], // Allow only digits
                onTap: () {},
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: CommonDropdownInputField(
                title: 'Batch days',
                controllerValue: controller.batchDaysController,
                selectedValue: controller.batchDaysController,
                items: controller.batchDays,
                onChanged: controller.setBatchDays,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: CommonDropdownInputField(
                title: 'Mode',
                controllerValue: controller.modeController,
                selectedValue: controller.modeController,
                items: controller.batchModes,
                onChanged: controller.setBatchModes,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: CommonInputField(
                label: 'Fees',
                controllerValue: controller.feesController,
                onTap: () {},
                prefixText: '₹ ', // Add the rupee symbol as prefix
                suffixText: '/month', // Add "/month" as suffix
              ),
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            //   child: CommonInputField(
            //     label: 'Month',
            //     controllerValue: controller.monthController,
            //     onTap: () {},
            //   ),
            // ),
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
}
