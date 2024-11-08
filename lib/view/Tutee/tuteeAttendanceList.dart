import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/tutorsStudentAttendanceList.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';



class TuteeAttendanceList extends StatelessWidget {
   TuteeAttendanceList({super.key});
 final StudentAttendanceController controller =
      Get.put(StudentAttendanceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.grey.shade100,
                      surfaceTintColor: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                              image: AssetImage('assets/Course_BG_Banner.png'),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // const SizedBox(height: 10),
                            Obx(() {
                              if (controller.batchList.isEmpty) {
                                return const CircularProgressIndicator(); // Show loading indicator if no batches are fetched
                              }
                              return DropdownButtonFormField<Data1>(
                                dropdownColor: AppConstants.primaryColor,
                                icon: const Icon(
                                  Icons.arrow_drop_down_circle_rounded,
                                  color: Colors.white,
                                ),
                                style: GoogleFonts.nunito(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  suffixIconColor: Colors.white,
                                  alignLabelWithHint: true,
                                  border: InputBorder.none,
                                  labelText: 'Select batch',
                                  labelStyle: GoogleFonts.nunito(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                value: controller.selectedBatchIN.value,
                                items: controller.batchList.map((Data1 batch) {
                                  return DropdownMenuItem<Data1>(
                                    value: batch,
                                    child: Text(batch.batchName!),
                                  );
                                }).toList(),
                                onChanged: (newBatch) {
                                  if (newBatch != null) {
                                    controller.selectBatch(newBatch);
                                    controller.isBatchSelected.value = true;
                                    // controller.fetchGroupedEnrollmentByBatchList(newBatch.batchId!,newBatch.startDate!);
                                    // Replace with your actual method to fetch batch-related data
                                  }
                                },
                              );
                            }),

                            // const SizedBox(
                            //   height: 20,
                            // ),
                            //tabl
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          

            const SizedBox(
              height: 10,
            ),
            SearchfiltertabBar(
              title: 'Student List',
              searchOnTap: () {},
              filterOnTap: () {},
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 12),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(12),
                //   border: Border.all(color: Colors.black),
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name',
                              style: GoogleFonts.nunito(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          //      Text('Date',
                          // style: GoogleFonts.nunito(
                          //     fontSize: 17,
                          //     fontWeight: FontWeight.w700,
                          //     color: Colors.black)),
                          Text('Time in',
                              style: GoogleFonts.nunito(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          Text('Time out',
                              style: GoogleFonts.nunito(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    const Divider(),
                    Obx(() {
                      // Check if attendance data is available and load it dynamically
                      if (controller.isLoadingList.value) {
                        return const CircularProgressIndicator();
                      } else if (controller.dataTutee?.attendanceDetails != null &&
                          controller.dataTutee!.attendanceDetails!.isNotEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.dataTutee!.attendanceDetails!.length,
                          itemBuilder: (context, index) {
                            final attendance =
                                controller.dataTutee!.attendanceDetails![index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(attendance.studentName ?? '',
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  attendance.punchInTime != null
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Image.asset(
                                            "assets/appbar/check.png",
                                            height: 30,
                                            width: 30,
                                          ),
                                        )
                                      : const Text("-"),
                                  attendance.punchOutTime != null
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Image.asset(
                                            "assets/appbar/check.png",
                                            height: 30,
                                            width: 30,
                                          ),
                                        )
                                      : const Text("-"),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(); // Divider between items except the last one
                          },
                        );
                      } else {
                        return const Text(
                            'No attendance data available for the selected date.');
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}