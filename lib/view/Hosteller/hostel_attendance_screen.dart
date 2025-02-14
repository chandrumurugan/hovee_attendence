import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/hostel_attendance_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/Tutor/tutorsStudentAttendenceList.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';

class HostelAttendanceScreen extends StatelessWidget {
   final String type;
  final HostelAttendanceController controller;
  final String? firstname, lastname, wowid, batchname;
   HostelAttendanceScreen({super.key,required this.type,
      this.firstname,
      this.lastname,
      this.wowid,
      this.batchname}): controller = Get.put(HostelAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.offAll(DashboardScreen(
            rolename: type,
            firstname: firstname ?? '',
            lastname: lastname ?? '',
            wowid: wowid ?? '',
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
                    padding: const EdgeInsets.only(top: 5),
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.grey.shade100,
                      surfaceTintColor: Colors.white,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() {
                              if (controller.isLoading.value) {
                                return const CircularProgressIndicator(); // Show loading indicator if no batches are fetched
                              } else {
                                return CustomDropdown(
                                  itemsListPadding: EdgeInsets.zero,
                                  listItemPadding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 10),
                                  hintText: 'Select batch',
                                  items: controller.batchList
                                      .map((batch) => batch.hostelListDetails!.hostelName ?? '')
                                      .toList(),
                                  initialItem: controller
                                      .selectedBatchIN.value?.hostelListDetails!.hostelName,
                                  onChanged: (String? selectedValue) {
                                    if (selectedValue != null) {
                                      controller.selectedBatch =
                                          controller.batchList.firstWhere(
                                        (batch) =>
                                            batch.hostelListDetails!.hostelName == selectedValue,
                                      );
                                      controller.selectBatch(controller.selectedBatch!);
                                      controller.isBatchSelected.value = true;
                                      controller.fetchStudentsList(
                                       controller. selectedBatch!.hostelListDetails!.id!,
                                       '',
                                        DateFormat('MMM')
                                            .format(DateTime.now()),
                                      );
                                    }
                                  },
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),

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
                            // controller.isBatchSelected.value =
                            //     !controller.isBatchSelected.value;
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
            Obx(() {
              if (!controller.isCalendarVisible.value) {
                return const SizedBox
                    .shrink(); // Hide calendar if no batch is selected
              }
              return GetBuilder<HostelAttendanceController>(
                builder: (_) => Container(
                  // height: MediaQuery.of(context).size.height * 0.55,
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
                    // rangeStartDay: controller.selectedBatchStartDate.value,
                    // rangeEndDay: controller.selectedBatchEndDate.value,
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: const CalendarStyle(
                      markerDecoration: BoxDecoration(
                        color: Colors.red, // Color for miss punch markers
                        shape: BoxShape.circle,
                      ),
                      markersAlignment: Alignment.bottomCenter,
                      markersMaxCount: 1,
                      rangeHighlightColor: AppConstants.primaryColor,
                      withinRangeTextStyle: TextStyle(color: Colors.white),
                    ),
                    selectedDayPredicate: (day) {
                        return isSameDay(controller.selectedDay.value, day) && 
         isSameDay(controller.selectedDay.value, DateTime.now());
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.onDateSelected(selectedDay);
                      controller.setFocusedDay(focusedDay);
                    },
                    onPageChanged: (focusedDay) {
                      controller.onMonthSelected(focusedDay);
                       controller.update();
                    },
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        // Check if the day is a miss punch date
                        if (controller.missPunchDates
                            .contains(DateTime(day.year, day.month, day.day))) {
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.orange[
                                  400], // Background color for miss punch dates
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${day.day}', // Display the day
                              style: const TextStyle(
                                  color: Colors.white), // Text style
                            ),
                          );
                        }
                        
                        if (controller.absentDates
                            .contains(DateTime(day.year, day.month, day.day))) {
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xffAD0F60), // Background color for miss punch dates
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

                        // Highlight Present dates
                        if (controller.presentDates
                            .contains(DateTime(day.year, day.month, day.day))) {
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors
                                  .green, // Background color for miss punch dates
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
                        //controller.leaveDates.refresh();
                        if (controller.leaveDates
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
                        if (controller.holidayDates
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
            Obx(() {
              if (!controller.isCalendarVisible.value) {
                return const SizedBox
                    .shrink(); // Hide calendar if no batch is selected
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 105,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Wrap only the Circular Chart in Obx to react to changes in attendanceData
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 18,
                                          width: 18,
                                          color: Color(0xffAD0F60),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Absent',
                                          style: GoogleFonts.nunito(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 18,
                                          width: 18,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Present',
                                          style: GoogleFonts.nunito(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 18,
                                          width: 18,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Leave ',
                                          style: GoogleFonts.nunito(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 18,
                                          width: 18,
                                          color: Colors.amber,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Holiday',
                                          style: GoogleFonts.nunito(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 18,
                                          width: 18,
                                          color: Colors.orange[400],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Miss Punch',
                                          style: GoogleFonts.nunito(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Wrap the bar chart section in a separate Obx to react to changes in controller.data
                      ],
                    ),
                  ),
                ),
              );
            }),

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                barChart(
                                  color:  Colors.blue,
                                  count:
                                      '${controller.data?.statusCounts?.missPunch ?? 0}',
                                  title: 'Leave',
                                ),
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
            ),  Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                'Attendance list',
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
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
                          horizontal: 15.0, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Column headers
                          Expanded(
                            child: Text('Date',
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                          Expanded(
                            child: Text('Punch In',
                                style: GoogleFonts.nunito(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                          Expanded(
                            child: Text('Punch Out',
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
                      // Check if attendance data is available and load it dynamically
                      if (controller.isLoadingList.value) {
                        return const CircularProgressIndicator();
                      } else if (controller.data?.attendanceDetails !=
                              null &&
                          controller.data!.attendanceDetails!.isNotEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.data!.attendanceDetails!.length,
                          itemBuilder: (context, index) {
                            final attendance =
                                controller.data!.attendanceDetails![index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Date
                                  Expanded(
                                    child: Text(
                                      attendance.punchInDate ?? '',
                                      style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  // Punch In
                                  Expanded(
                                    child: attendance.punchInTime != null &&
                                            attendance.punchInTime!.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Image.asset(
                                              "assets/appbar/check.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          )
                                        : IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.blue),
                                            onPressed: () {
                                              // Handle edit action for punch in time
                                            
                                            },
                                          ),
                                  ),
                                  // Punch Out
                                  Expanded(
                                    child: attendance.punchOutTime != null &&
                                            attendance.punchOutTime!.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Image.asset(
                                              "assets/appbar/check.png",
                                              height: 25,
                                              width: 25,
                                            ),
                                          )
                                        : IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.blue),
                                            onPressed: () {
                                              // Handle edit action for punch out time
                                            },
                                          ),
                                  ),
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

  Widget _buildDateContainer(DateTime day, Color color) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: color, // Dynamic background color
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.center,
      child: Text(
        '${day.day}', // Display the day number
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
