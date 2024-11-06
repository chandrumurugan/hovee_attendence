import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/controllers/course_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDropDownInputField.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/single_button.dart';

class TutorAddCourseScreen extends StatelessWidget {
   TutorAddCourseScreen({super.key});
   final CourseController courseController = Get.put(CourseController());
   final BatchController controller = Get.put(BatchController());
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
                  'Add Course',
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
        
            //  Obx(() => DropdownButton<String>(
            //         value: courseController.boardController.value.isNotEmpty ? courseController.boardController.value : null,
            //         hint: Text("Select Board"),
            //         onChanged: (value) {
            //           if (value != null) {
            //             courseController.updateClassList(value);
            //           }
            //         },
            //         items: courseController.board.map((board) {
            //           return DropdownMenuItem<String>(
            //             value: board,
            //             child: Text(board),
            //           );
            //         }).toList(),
            //       )),
        
            //   // Class Dropdown
            //   Obx(() => DropdownButton<String>(
            //         value: courseController.classController.value.isNotEmpty ? courseController.classController.value : null,
            //         hint: Text("Select Class"),
            //         onChanged: (value) {
            //           if (value != null) {
            //             courseController.updateSubjectList(value);
            //           }
            //         },
            //         items: courseController.classList.map((classItem) {
            //           return DropdownMenuItem<String>(
            //             value: classItem,
            //             child: Text(classItem),
            //           );
            //         }).toList(),
            //       )),
        
            //   // Subject Dropdown
            //   Obx(() => DropdownButton<String>(
            //         value: courseController.subjectController.value.isNotEmpty ? courseController.subjectController.value : null,
            //         hint: Text("Select Subject"),
            //         onChanged: (value) {
            //           if (value != null) {
            //             courseController.subjectController.value = value;
            //           }
            //         },
            //         items: courseController.subject.map((subject) {
            //           return DropdownMenuItem<String>(
            //             value: subject,
            //             child: Text(subject),
            //           );
            //         }).toList(),
            //       )), 
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
                      items: controller.batchName1,
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
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Remarks',
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
                    const SizedBox(
                      height: 10,
                    ),
                    CommonInputField(
                      // title: 'Branch short name',
                      controllerValue: courseController.remarksController,
                      selectedValue: courseController.remarksController,
                      keyboardType: TextInputType.text,
                      hintText: 'Enter here...',
                      onTap: () {}, controller: courseController.remarks,
                    ),
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
                
                btnName: 'Add',
                onTap: () {
                  courseController.addCourse(context);
                },
              )
          ],
        ),
      ),
    );
  }
}