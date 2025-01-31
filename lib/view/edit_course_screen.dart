import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/controllers/course_controller.dart';
import 'package:hovee_attendence/modals/getCouseList_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDropDownInputField.dart';
import 'package:hovee_attendence/widget/single_button.dart';

class EditCourseScreen extends StatelessWidget {
   final Data1 batch;
   EditCourseScreen({super.key, required this.batch});
 final CourseController courseController = Get.put(CourseController());
   final BatchController controller = Get.put(BatchController());
  @override
  Widget build(BuildContext context) {
      courseController.batchNameController.value = batch.batchName ?? '';
    courseController.boardController.value = batch.board ?? '';
    courseController.classController.value = batch.className ?? '';
    courseController.subjectController.value = batch.subject ?? '';
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          courseController.onInit();
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
                  'Edit course',
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
                      controllerValue: courseController.batchNameController,
                      selectedValue: courseController.batchNameController,
                      items: courseController.batchNamebyCourse,
                      onChanged: courseController.setBatchName,
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
              'Choose a board',
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
              title: 'board',
              controllerValue: courseController.boardController.value.obs,
              selectedValue: courseController.boardController.value.obs,
              items: courseController.board,
              onChanged: courseController.setBoard,
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
              'Select a class',
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
              title: 'Class',
              controllerValue: courseController.classController.value.obs,
              selectedValue: courseController.classController.value.obs,
              items: courseController.classList,
              onChanged: courseController.setClass,
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
              'Choose a subject',
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
              title: 'subject',
              controllerValue: courseController.subjectController.value.obs,
              selectedValue: courseController.subjectController.value.obs,
              items: courseController.subject,
              onChanged: courseController.setSubject,
            )),
            ],
          ),
        ),
              Obx(() {
                if (courseController.validationMessages.isNotEmpty) {
                  return Column(
                    children: courseController.validationMessages
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
                  courseController.updateCourse(context,batch.sId!);
                },
              )
          ],
        ),
      ),
    );
  }
}