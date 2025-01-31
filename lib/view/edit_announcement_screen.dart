import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/annoument_controller.dart';
import 'package:hovee_attendence/modals/getAnnounment_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDropDownInputField.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/single_button.dart';

class EditAnnouncementScreen extends StatelessWidget {
   final AnnounmentsData data;
   EditAnnouncementScreen({super.key, required this.data});
  final AnnoumentController annoumentController = Get.put(AnnoumentController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
      annoumentController.batchNamesController.value = data.batchDetails!.batchName ?? '';
  annoumentController.courseNamesController.value =
    '${data.courseDetails!.className} - ${data.courseDetails!.subject ?? ''}';
    //annoumentController..value = batch.batchTimingEnd ?? '';
    annoumentController.title.text=data.title ?? '';
    annoumentController.description.text=data.description ?? '';
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          annoumentController.onInit();
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
                  'Edit announcement',
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
                          'Choose course name',
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
                      title: 'course name',
                      controllerValue: annoumentController.courseNamesController,
                      selectedValue: annoumentController.courseNamesController,
                      items: annoumentController.courseNames,
                      onChanged: annoumentController.setCourse,
                    ),
                  ],
                ),
              ),
               Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
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
        Obx(() => CommonDropdownInputField(
              title: 'batch name',
              controllerValue: annoumentController.batchNamesController,
              selectedValue: annoumentController.batchNamesController.value.obs,
              items: annoumentController.batchNames,
              onChanged: annoumentController.setBatch,
            )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
        Row(
          children: [
            const Text(
              'Choose student name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            // Text(
            //   '*',
            //   style: GoogleFonts.nunito(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w600,
            //     color: Colors.red.withOpacity(0.6),
            //   ),
            // ),
          ],
        ),
        Obx(() => CommonDropdownInputField(
              title: 'student name',
              controllerValue: annoumentController.userNamesController.value.obs,
              selectedValue: annoumentController.userNamesController.value.obs,
              items: annoumentController.userNames,
              onChanged: annoumentController.setStudent,
            )),
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
                        'Title type',
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
                    controllerValue: annoumentController.titleController,
                    selectedValue: annoumentController.titleController,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter here...',
                    onTap: () {}, controller: annoumentController.title,
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
                        'Description',
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
                    controllerValue: annoumentController.descriptionController,
                    selectedValue: annoumentController.descriptionController,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter here...',
                    onTap: () {}, controller: annoumentController.description,
                  ),
                ],
              ),
            ),
              Obx(() {
                if (annoumentController.validationMessages.isNotEmpty) {
                  return Column(
                    children: annoumentController.validationMessages
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
                annoumentController.editAnnoument(context,data.announcementId!);
                },
              )
          ],
        ),
      ),
    );
  }
}