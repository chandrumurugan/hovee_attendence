import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/components/tutorHomeComponents.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/tutorsStudentAttendanceList.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/controllers/tutor_attendance_controller.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StudentAttendanceList extends StatelessWidget {
  final String type;
  final String? firstname, lastname, wowid;
  StudentAttendanceList(
      {super.key,
      required this.type,
      this.firstname,
      this.lastname,
      this.wowid});

  @override
  Widget build(BuildContext context) {
    StudentAttendanceController controller =
        Get.put(StudentAttendanceController());

    Logger().i("type==>$type");
    List<AttendanceData> attendanceData = [
      AttendanceData(
        category: 'Present',
        percentage: 80,
        pointColor: const Color.fromRGBO(0, 201, 230, 1.0),
      ),
      AttendanceData(
        category: 'Absent',
        percentage: 15,
        pointColor: const Color.fromRGBO(63, 224, 0, 1.0),
      ),
      AttendanceData(
        category: 'Late',
        percentage: 5,
        pointColor: const Color.fromRGBO(226, 1, 26, 1.0),
      ),
    ];
    // controller.setType(type);
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.offAll(DashboardScreen(
            rolename: type,
            firstname: firstname,
            lastname: lastname,
            wowid: wowid,
          ));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        //padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        // decoration: const BoxDecoration(
                        //   borderRadius: BorderRadius.all(Radius.circular(8)),
                        //   image: DecorationImage(
                        //     image: AssetImage('assets/Course_BG_Banner.png'),
                        //     fit: BoxFit.cover,
                        //   ),
                        //),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() {
                              if (controller.isLoading.value) {
                                return const CircularProgressIndicator(); // Show loading indicator if no batches are fetched
                              }
                              return CustomDropdown(
                                itemsListPadding: EdgeInsets.zero,
                                listItemPadding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                hintText: 'Select batch',
                                items: controller.batchList
                                    .map((batch) => batch.batchName ?? '')
                                    .toList(),
                                initialItem:
                                    controller.selectedBatchIN.value?.batchName,
                                onChanged: (String? selectedValue) {
                                  if (selectedValue != null) {
                                    final selectedBatch =
                                        controller.batchList.firstWhere(
                                      (batch) =>
                                          batch.batchName == selectedValue,
                                    );
                                    controller.selectBatch(selectedBatch);
                                    controller.isBatchSelected.value = true;
                                    controller.fetchStudentsList(
                                      selectedBatch.batchId!,
                                      selectedBatch.startDate ?? '',
                                      DateFormat('MMM').format(DateTime.now()),
                                    );
                                  }
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(0),
                  //   child: Card(
                  //     elevation: 10,
                  //     shadowColor: Colors.grey.shade100,
                  //     surfaceTintColor: Colors.white,
                  //     child: Container(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 12, vertical: 10),
                  //       width: MediaQuery.sizeOf(context).width * 0.7,
                  //       decoration: const BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         image: DecorationImage(
                  //             image: AssetImage('assets/Course_BG_Banner.png'),
                  //             fit: BoxFit.cover),
                  //       ),
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           // const SizedBox(height: 10),
                  //           Obx(() {
                  //             if (controller.isLoading.value) {
                  //               return const CircularProgressIndicator(); // Show loading indicator if no batches are fetched
                  //             }
                  //             return
                  //             DropdownButtonFormField<Data1>(
                  //               dropdownColor: AppConstants.primaryColor,
                  //               icon: const Icon(
                  //                 Icons.arrow_drop_down_circle_rounded,
                  //                 color: Colors.white,
                  //               ),
                  //               style: GoogleFonts.nunito(
                  //                 fontSize: 19,
                  //                 fontWeight: FontWeight.w400,
                  //                 color: Colors.white,
                  //               ),
                  //               decoration: InputDecoration(
                  //                 suffixIconColor: Colors.white,
                  //                 alignLabelWithHint: true,
                  //                 border: InputBorder.none,
                  //                 labelText: 'Select batch',
                  //                 labelStyle: GoogleFonts.nunito(
                  //                   fontSize: 15,
                  //                   fontWeight: FontWeight.w400,
                  //                   color: Colors.white,
                  //                 ),
                  //               ),
                  //               value: controller.selectedBatchIN.value,
                  //               items: controller.batchList.map((Data1 batch) {
                  //                 return DropdownMenuItem<Data1>(
                  //                   value: batch,
                  //                   child: Text(batch.batchName!),
                  //                 );
                  //               }).toList(),
                  //               onChanged: (newBatch) {
                  //                 if (newBatch != null) {
                  //                   controller.selectBatch(newBatch);
                  //                   controller.isBatchSelected.value = true;
                  //                   controller.fetchStudentsList(newBatch.batchId!, newBatch.startDate!, DateFormat('MMM').format(DateTime.now()));
                  //                   // controller.fetchGroupedEnrollmentByBatchList(newBatch.batchId!,newBatch.startDate!);
                  //                   // Replace with your actual method to fetch batch-related data
                  //                 }
                  //               },
                  //             );
                  //           }),

                  //           // const SizedBox(
                  //           //   height: 20,
                  //           // ),
                  //           //tabl
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // Obx((){})
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10), // Set the desired radius
                    child: Container(
                      color: AppConstants.secondaryColor,
                      height: 70,
                      width: 70,
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            // controller.isBatchSelected.value = !controller.isBatchSelected.value;
                            controller.isCalendarVisible.value =
                                !controller.isCalendarVisible.value;
                          },
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // const SizedBox(height: 10,),
            Obx(() {
              if (!controller.isCalendarVisible.value) {
                return const SizedBox
                    .shrink(); // Hide calendar if no batch is selected
              }
              return GetBuilder<StudentAttendanceController>(
                builder: (_) => Container(
                  // height: MediaQuery.of(context).size.height * 0.50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  // padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black)),
                  child: TableCalendar(
                    firstDay: DateTime(2024, 1, 1),
                    lastDay: DateTime(2025, 12, 31),
                    focusedDay: controller.focusedDay.value,
                    rangeStartDay: controller.selectedBatchStartDate.value,
                    rangeEndDay: controller.selectedBatchEndDate.value,
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: const CalendarStyle(
                      rangeHighlightColor: AppConstants.primaryColor,
                      withinRangeTextStyle: TextStyle(color: Colors.white),
                      selectedDecoration: BoxDecoration(
                        color: Colors
                            .blue, // Customize the color for selected date
                        shape: BoxShape.circle,
                      ),
                      // outsideRangeTextStyle: TextStyle(color: Colors.grey),
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(controller.selectedDay.value, day) &&
                          isSameDay(
                              controller.selectedDay.value, DateTime.now());
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.onDateSelectedTutor(selectedDay);
                      controller.setFocusedDay(focusedDay);
                    },
                    onPageChanged: (focusedDay) {
                      // controller.setFocusedDay(focusedDay);
                      controller.onMonthSelectedTutor(focusedDay);
                      controller.update();
                    },
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        // Check if the day is a miss punch date
                        controller.holidayDatesTutor.refresh();
                        if (controller.holidayDatesTutor
                            .contains(DateTime(day.year, day.month, day.day))) {
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors
                                  .amber, // Background color for miss punch dates
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Center(
                                child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            )),
                          );
                        }
                        if (controller.leaveDatesTutor
                            .contains(DateTime(day.year, day.month, day.day))) {
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors
                                  .blue, // Background color for miss punch dates
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Center(
                                child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            )),
                          );
                        }
                        // Return default appearance for other dates
                        return null;
                      },
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                'Attendance wheel',
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Card(
                color: Colors.white,
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Wrap only the Circular Chart in Obx to react to changes in attendanceData
                      Obx(() {
                        if (controller.isLoadingList.value) {
                          return const SizedBox.shrink();
                        }
                        return SizedBox(
                          width: 130,
                          child: SfCircularChart(
                            centerX: "50%",
                            legend: const Legend(
                              isVisible: false,
                              iconHeight: 20,
                              iconWidth: 20,
                              overflowMode: LegendItemOverflowMode.scroll,
                            ),
                            tooltipBehavior: TooltipBehavior(enable: false),
                            series: <RadialBarSeries<AttendanceData, String>>[
                              RadialBarSeries<AttendanceData, String>(
                                animationDuration: 0,
                                maximumValue: 100,
                                radius: '100%',
                                gap: '10%',
                                innerRadius: '30%',
                                dataSource: controller.attendanceData.isNotEmpty
                                    ? controller.attendanceData
                                    : controller.defaultData,
                                cornerStyle: CornerStyle.bothCurve,
                                xValueMapper: (AttendanceData data, _) =>
                                    data.category,
                                yValueMapper: (AttendanceData data, _) =>
                                    data.percentage,
                                pointColorMapper: (AttendanceData data, _) =>
                                    data.pointColor,
                                dataLabelMapper: (AttendanceData data, _) =>
                                    '${data.percentage}%',
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: false,
                                  labelIntersectAction:
                                      LabelIntersectAction.hide,
                                  alignment: ChartAlignment.near,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      // Wrap the bar chart section in a separate Obx to react to changes in controller.data
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoadingList.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                barChart(
                                  color: const Color(0xff014EA9),
                                  count:
                                      '${controller.data?.statusCounts?.totalStudents ?? 0}',
                                  title: 'All',
                                ),
                                barChart(
                                  color: const Color(0xffF07721),
                                  count:
                                      '${controller.data?.statusCounts?.present ?? 0}',
                                  title: 'Present',
                                ),
                                barChart(
                                  color: const Color(0xffAD0F60),
                                  count:
                                      '${controller.data?.statusCounts?.absent ?? 0}',
                                  title: 'Absent',
                                ),
                                barChart(
                                  color: const Color(0xff2E5BB5),
                                  count:
                                      '${controller.data?.statusCounts?.missPunch ?? 0}',
                                  title: 'Miss\npunch',
                                ),
                                // barChart(
                                //   color:  Colors.blue,
                                //   count:
                                //       '${controller.data?.statusCounts?.leave ?? 0}',
                                //   title: 'Leave',
                                // ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tutee list',
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  TextButton(
                    //Handle button press event
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      //Change font size and weight
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                      //Set the foreground color
                      backgroundColor: AppConstants.primaryColor,
                      //Set the padding on all sides to 20px
                      padding: const EdgeInsets.all(8.0),
                    ),
                    //Contents of the button
                    child: Text(
                      "Session closed",
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text('Name',
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                          // Expanded(
                          //   flex: 1,
                          //   child: Text('Roll No',
                          //       style: GoogleFonts.nunito(
                          //           fontSize: 17,
                          //           fontWeight: FontWeight.w700,
                          //           color: Colors.black)),
                          // ),
                          Expanded(
                            flex: 2,
                            child: Text('Punch in',
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text('Punch out',
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Obx(() {
                      if (controller.isLoadingList.value) {
                        return const CircularProgressIndicator();
                      } else if (controller.data?.attendanceDetails != null &&
                          controller.data!.attendanceDetails!.isNotEmpty) {
                        return Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1.5), // Name column width
                            // 1: FlexColumnWidth(1), // Roll No column width
                            1: FlexColumnWidth(0.9), // Punch in column width
                            2: FlexColumnWidth(2), // Punch out column width
                          },
                          // border: TableBorder.symmetric(
                          //   inside: BorderSide(color: Colors.grey, width: 0.5),
                          // ),
                          children: [
                            for (var attendance
                                in controller.data!.attendanceDetails!)
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(attendance.studentName ?? '',
                                        style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  //   child: Text(attendance.rollNo!,
                                  //       style: GoogleFonts.nunito(
                                  //           fontSize: 16,
                                  //           fontWeight: FontWeight.w500,
                                  //           color: Colors.black)),
                                  // ),
                                  Center(
                                    child: attendance.punchInTime != null
                                        ? Image.asset(
                                            "assets/appbar/check.png",
                                            height: 25,
                                            width: 25,
                                          )
                                        : const Text("-"),
                                  ),
                                  Center(
                                    child: attendance.punchOutTime != null
                                        ? Image.asset(
                                            "assets/appbar/check.png",
                                            height: 25,
                                            width: 25,
                                          )
                                        : const Text("-"),
                                  ),
                                ],
                              ),
                          ],
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

  Widget barChart(
      {required String count, required String title, required Color color}) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.nunito(
              color: color, fontWeight: FontWeight.w400, fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: GoogleFonts.nunito(
              color: const Color(0xff828282),
              fontWeight: FontWeight.w400,
              fontSize: 12),
        )
      ],
    );
  }
}

class AttendanceData {
  AttendanceData({
    required this.category,
    required this.percentage,
    required this.pointColor,
  });

  final String category;
  final double percentage;
  final Color pointColor;
}
