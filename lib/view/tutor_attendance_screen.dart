import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/tutor_attendance_controller.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TutorAttendanceScreen extends StatelessWidget {
  TutorAttendanceScreen({super.key});
  final TutorAttendanceController controller =
      Get.put(TutorAttendanceController());
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
              padding: const EdgeInsets.all(0),
              child: Card(
                elevation: 10,
                shadowColor: Colors.grey.shade100,
                surfaceTintColor: Colors.white,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    image: DecorationImage(
                        image: AssetImage('assets/Course_BG_Banner.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Obx(() {
                        if (controller.batchList.isEmpty) {
                          return CircularProgressIndicator(); // Show loading indicator if no batches are fetched
                        }
                        return DropdownButtonFormField<Data1>(
                          dropdownColor: AppConstants.primaryColor,
                          style: GoogleFonts.nunito(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Batch',
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
                              controller.fetchGroupedEnrollmentByBatchList(newBatch.batchId!,newBatch.startDate!); // Replace with your actual method to fetch batch-related data
                            }
                          },
                        );
                      }),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() => Container(
                            color: Colors.white,
                            child: TableCalendar(
                              headerVisible: false,
                              daysOfWeekVisible: true,
                              rowHeight: 40,
                              firstDay: DateTime.utc(2020, 1, 1),
                              lastDay: DateTime.utc(2030, 12, 31),
                              focusedDay: controller.focusedDay.value,
                              calendarFormat: CalendarFormat.month,
                              selectedDayPredicate: (day) {
                                return day == controller.selectedDay.value;
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                controller.selectedDay.value = selectedDay;
                                controller.focusedDay.value = focusedDay;
                                controller.fetchGroupedEnrollmentByBatchList(
                                    controller.selectedBatchId!,
                                    controller.selectedDate1!);
                              },
                              onPageChanged: (focusedDay) {
                                controller.onMonthChange(focusedDay);
                              },
                              calendarBuilders: CalendarBuilders(
                                dowBuilder: (context, day) {
                                  if (day.weekday == DateTime.sunday) {
                                    return const Center(
                                      child: Text(
                                        'Sun',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  }
                                  return null;
                                },
                                defaultBuilder: (context, day, focusedDay) {
                                  final attendance =
                                      controller.attendanceData[day];
                                  Color? bgColor;
                                  Color textColor = Colors.black;

                                  // Define the batch start and end dates
                                  final startDate =
                                      controller.selectedBatchStartDate;
                                  final endDate =
                                      controller.selectedBatchEndDate;

                                  // Highlight the start and end dates, and shade dates in between
                                  if (startDate != null && endDate != null) {
                                    if (day.isAtSameMomentAs(startDate)) {
                                      bgColor = Colors
                                          .green; // Color for the start date
                                    } else if (day.isAtSameMomentAs(endDate)) {
                                      bgColor =
                                          Colors.red; // Color for the end date
                                    } else if (day.isAfter(startDate) &&
                                        day.isBefore(endDate)) {
                                      bgColor = Colors.yellow.withOpacity(
                                          0.3); // Color for dates between
                                    }
                                  }

                                  // Attendance-based coloring
                                  if (attendance != null) {
                                    switch (attendance) {
                                      case 'Present':
                                        bgColor = Colors.green;
                                        break;
                                      case 'Leave':
                                        bgColor = Colors.red;
                                        break;
                                      case 'Absent':
                                        bgColor = Colors.orange;
                                        break;
                                      case 'Holiday':
                                        bgColor = Colors.blue;
                                        break;
                                      case 'Miss punch':
                                        bgColor = Colors.brown;
                                        break;
                                      case 'Leave Approved Pending':
                                        bgColor = Colors.purple;
                                        break;
                                    }
                                  }

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    margin: const EdgeInsets.all(4.0),
                                    child: Center(
                                      child: Text(
                                        '${day.day}',
                                        style: TextStyle(color: textColor),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            SearchfiltertabBar(
              title: 'Student List',
              searchOnTap: () {},
              filterOnTap: () {},
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name',
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  Text('Time in',
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                  Text('Time out',
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ],
              ),
            ),
            Obx(() {
              // Check if loading
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              // Check if attendance details are empty
              else if (controller.data == null ||
                  controller.data!.attendanceDetails!.isEmpty) {
                print(controller.data); // Print the data for debugging
                return Center(
                  child: Text(
                    'No data found',
                    style: GoogleFonts.nunito(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                // Display the list of attendance details
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.data!.attendanceDetails!.length,
                  itemBuilder: (context, index) {
                    final students = controller.data!.attendanceDetails![index];
                    DateTime dateTime = DateTime.parse(students.punchInTime!);
                    // Format it to "hh:mm:ss a"
                    String formattedTime =
                        DateFormat('hh:mm:ss a').format(dateTime);
                    DateTime dateTime1 = DateTime.parse(students.punchOutTime!);
                    // Format it to "hh:mm:ss a"
                    String formattedTime1 =
                        DateFormat('hh:mm:ss a').format(dateTime1);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            students.studentName!,
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            formattedTime,
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.primaryColor,
                            ),
                          ),
                          Text(
                            formattedTime1,
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      indent: 15,
                      endIndent: 15,
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
