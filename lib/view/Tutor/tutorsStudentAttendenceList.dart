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
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StudentAttendanceList extends StatelessWidget {
  StudentAttendanceList({super.key});
  final StudentAttendanceController controller =
      Get.put(StudentAttendanceController());

  @override
  Widget build(BuildContext context) {
    List<AttendanceData> attendanceData = [
      AttendanceData(
        category: 'Present',
        percentage: 80,
        pointColor: Color.fromRGBO(0, 201, 230, 1.0),
      ),
      AttendanceData(
        category: 'Absent',
        percentage: 15,
        pointColor: Color.fromRGBO(63, 224, 0, 1.0),
      ),
      AttendanceData(
        category: 'Late',
        percentage: 5,
        pointColor: Color.fromRGBO(226, 1, 26, 1.0),
      ),
    ];
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
                        width: MediaQuery.sizeOf(context).width * 0.7,
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

                  // Obx((){})
                  ClipRRect(
  borderRadius: BorderRadius.circular(10), // Set the desired radius
  child: Container(
    color: AppConstants.secondaryColor,
    height: 70,
    width: 80,
    child: Center(
      child: IconButton(
        onPressed: () {
          controller.isBatchSelected.value = !controller.isBatchSelected.value;
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
              if (!controller.isBatchSelected.value) {
                return const SizedBox
                    .shrink(); // Hide calendar if no batch is selected
              }
              return Container(
                height: MediaQuery.of(context).size.height * 0.45,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                // padding: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black)),
                child: TableCalendar(
                  firstDay: DateTime(2024, 1, 1),
                  lastDay: DateTime(2024, 12, 31),
                  focusedDay: controller.selectedBatchStartDate.value!,
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
                      color:
                          Colors.blue, // Customize the color for selected date
                      shape: BoxShape.circle,
                    ),
                    // outsideRangeTextStyle: TextStyle(color: Colors.grey),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(controller.selectedDay.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.onDateSelected(selectedDay);
                    controller.setFocusedDay(focusedDay);
                  },
                  onPageChanged: (focusedDay) {
                    controller.setFocusedDay(focusedDay);
                  },
                ),
              );
            }),
            const SizedBox(
              height: 10,
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
                          return SizedBox.shrink();
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
                            return Center(child: CircularProgressIndicator());
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                barChart(
                                  color: Color(0xff014EA9),
                                  count:
                                      '${controller.data?.statusCounts?.totalStudents ?? 0}',
                                  title: 'All',
                                ),
                                barChart(
                                  color: Color(0xffF07721),
                                  count:
                                      '${controller.data?.statusCounts?.present ?? 0}',
                                  title: 'Present',
                                ),
                                barChart(
                                  color: Color(0xffAD0F60),
                                  count:
                                      '${controller.data?.statusCounts?.absent ?? 0}',
                                  title: 'Absent',
                                ),
                                barChart(
                                  color: Color(0xff2E5BB5),
                                  count:
                                      '${controller.data?.statusCounts?.partialAttendance ?? 0}',
                                  title: 'P.Attend',
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
                      } else if (controller.data?.attendanceDetails != null &&
                          controller.data!.attendanceDetails!.isNotEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.data!.attendanceDetails!.length,
                          itemBuilder: (context, index) {
                            final attendance =
                                controller.data!.attendanceDetails![index];

                            //    DateTime dateTime1 = DateTime.parse(attendance.punchInTime!);
                            //    DateTime dateTime2 = DateTime.parse(attendance.punchOutTime!);

                            //    String punchINTime = DateFormat("hh:mm a").format(dateTime1);
                            //    String punchOUTTime = DateFormat("hh:mm a").format(dateTime2);
                            //  DateTime dateTime = DateFormat("dd/MM/yyyy").parse(controller.data!.date!);
                            //  String formattedDate = DateFormat("ddMMMyy").format(dateTime);

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
                                  //       Text(formattedDate,
                                  // style: GoogleFonts.nunito(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w500,
                                  //     color: Colors.black)),
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
                                  // Text(attendance.punchInTime ?? "-",
                                  //     style: GoogleFonts.nunito(
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.w500,
                                  //         color: Colors.black)),
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
                                  // Text(attendance.punchOutTime ?? "-",
                                  //     style: GoogleFonts.nunito(
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.w500,
                                  //         color: Colors.black)),
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

            //  const ChartApp(),

            // const SizedBox(height: 10,),

            // Obx(() {
            //   // Check if attendance data is available and load it dynamically
            //   if (controller.isLoadingList.value) {
            //     return const CircularProgressIndicator();
            //   } else if (controller.data?.attendanceDetails != null &&
            //       controller.data!.attendanceDetails!.isNotEmpty) {
            //     return Column(
            //       children:
            //           controller.data!.attendanceDetails!.map((attendance) {
            //         DateTime dateTime1 =
            //             DateTime.parse(attendance.punchInTime!);
            //         DateTime dateTime2 =
            //             DateTime.parse(attendance.punchOutTime!);

            //         String punchINTime =
            //             DateFormat("hh:mm a").format(dateTime1);
            //         String punchOUTTime =
            //             DateFormat("hh:mm a").format(dateTime2);

            //         return Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 15.0, vertical: 5),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(attendance.studentName ?? '',
            //                   style: GoogleFonts.nunito(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w500,
            //                       color: Colors.black)),
            //               Text(punchINTime ?? '-',
            //                   style: GoogleFonts.nunito(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w500,
            //                       color: Colors.black)),
            //               Text(punchOUTTime ?? '-',
            //                   style: GoogleFonts.nunito(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w500,
            //                       color: Colors.black)),
            //             ],
            //           ),
            //         );
            //       }).toList(),
            //     );
            //   } else {
            //     return const Text(
            //         'No attendance data available for the selected date.');
            //   }
            // }),
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
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: GoogleFonts.nunito(
              color: Color(0xff828282),
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
