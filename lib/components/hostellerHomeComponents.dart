import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/hosteller_controller.dart';
import 'package:hovee_attendence/controllers/tutorHome_controllers.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HostellerChartApp extends StatelessWidget {
  HostellerChartApp({super.key});
  final HostellerController controller = Get.put(HostellerController());
  @override
  Widget build(BuildContext context) {
    int? present = double.tryParse(
            controller.dailyattendance.value!.present!.replaceAll('%', ''))
        ?.toInt();
    int? absent = double.tryParse(
            controller.dailyattendance.value!.absent!.replaceAll('%', ''))
        ?.toInt();
    int? partial = double.tryParse(
            controller.dailyattendance.value!.missPunch!.replaceAll('%', ''))
        ?.toInt();

    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox.shrink();
      } else if (controller.dailyattendance == null) {
        return const Center(child: Text("No data found"));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0),
        child: Card(
          elevation: 10,
          shadowColor: Colors.grey,
          surfaceTintColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(8),
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(child: PieChartWidget()),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 18,
                            width: 18,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          controller.dailyattendance.value != null
                              ? Text(
                                  'Present - ${present} %',
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 18,
                            width: 18,
                            color: Color(0xffAD0F60),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          controller.dailyattendance.value != null
                              ? Text(
                                  'Absent - ${absent} %',
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //         height: 18,
                      //       width: 18,
                      //       color:  Colors.blue,
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     controller.dailyattendance.value != null
                      //         ? Text(
                      //             'Leave - ${controller.dailyattendance.value!.leave!.toString()}',
                      //             style: GoogleFonts.nunito(
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black),
                      //           )
                      //         : const SizedBox.shrink(),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Row(
                        children: [
                          Container(
                            height: 18,
                            width: 18,
                            color: Colors.orange[500],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          controller.dailyattendance.value != null
                              ? Text(
                                  'Miss punch - ${partial} %',
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        DateFormat('MMMM yyyy')
                            .format(DateTime.now()), // Displays "March 2025"
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class PieChartWidget extends StatelessWidget {
  final HostellerController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox.shrink();
      }

      final percentage = controller.dailyattendance.value;
      //Logger().i("dsg€sdgsg${percentage!.absent}");
      if (percentage == null) {
        return const Center(child: Text("No data found"));
      }

      double? present = double.parse(percentage.present!.replaceAll('%', ''));

      double? absent = double.parse(percentage.absent!.replaceAll('%', ''));
      // double? leave = double.parse(percentage.leave!.replaceAll('%', ''));
      double? partial = double.parse(percentage.missPunch!.replaceAll('%', ''));

      final total = present + absent + partial.toInt();

      // If all values are 0, display a single blue circle
      if (total == 0) {
        return PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                color: Color(0xff7E71FF),
                value: 100,
                title: '${total.toInt()}%',
                radius: 35,
                titleStyle: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
            centerSpaceRadius: 40,
          ),
        );
      }

      List<PieChartSectionData> sections = [];

      if (present > 0) {
        sections.add(
          PieChartSectionData(
            color: Colors.green,
            value: present,
            title: '${present.toInt()}%',
            radius: 40,
            titleStyle: GoogleFonts.nunito(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }

      if (absent > 0) {
        sections.add(
          PieChartSectionData(
            color: Color(0xffAD0F60),
            value: absent,
            title: ' ${absent.toInt()}%',
            radius: 40,
            titleStyle: GoogleFonts.nunito(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }

      // if (leave > 0) {
      //   sections.add(
      //     PieChartSectionData(
      //       color: Colors.blue,
      //       value: leave,
      //       title: ' ${leave.toInt()}%',
      //       radius: 40,
      //       titleStyle: GoogleFonts.nunito(
      //         fontSize: 11,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //       ),
      //     ),
      //   );
      // }

      if (partial > 0) {
        sections.add(
          PieChartSectionData(
            color: Colors.orange[500],
            value: partial,
            title: '${partial.toInt()}%',
            radius: 40,
            titleStyle: GoogleFonts.nunito(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }

      return PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 40,
        ),
      );
    });
  }
}

class PieChartWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Color(0xff7E71FF),
            value: 30,
            title: '0%',
            // titlePositionPercentageOffset: 0.7,
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
        centerSpaceRadius: 40,
      ),
    );
    // return Obx(() {
    //   if (controller.isLoading.value) {
    //     return const SizedBox.shrink();
    //   } else if (controller.dailyattendance.value == null) {
    //     //Center(child: Text("No data found"));
    //     return Center(child: Text("No data found"));
    //   }
    //   return PieChart(
    //     PieChartData(
    //       sections: [
    //         PieChartSectionData(
    //           color: Colors.purple,
    //           value: double.tryParse(
    //               controller.dailyattendance.value!.percentage != null
    //                   ? controller.dailyattendance.value!.percentage!.present!
    //                   : ''),
    //           title:
    //               '${controller.dailyattendance.value!.percentage!.present!}',
    //           radius: 35,
    //           titleStyle: GoogleFonts.nunito(
    //               fontSize: 14,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.white),
    //         ),
    //         PieChartSectionData(
    //           color: Colors.orange,
    //           value: double.tryParse(
    //               controller.dailyattendance.value!.percentage != null
    //                   ? controller.dailyattendance.value!.percentage!.absent!
    //                   : ''),
    //           title: '${controller.dailyattendance.value!.percentage!.absent!}',
    //           radius: 35,
    //           titleStyle: GoogleFonts.nunito(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.white),
    //         ),
    //         PieChartSectionData(
    //           color: Colors.blue,
    //           value: double.tryParse(
    //               controller.dailyattendance.value!.percentage != null
    //                   ? controller.dailyattendance.value!.percentage!.leave!
    //                   : ''),
    //           title: '${controller.dailyattendance.value!.percentage!.leave!}',
    //           radius: 35,
    //           titleStyle: GoogleFonts.nunito(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.white),
    //         ),
    //         PieChartSectionData(
    //           color: Colors.red,
    //           value: double.tryParse(
    //               controller.dailyattendance.value!.percentage != null
    //                   ? controller.dailyattendance.value!.percentage!.partial!
    //                   : ''),
    //           title:
    //               '${controller.dailyattendance.value!.percentage!.partial!}',
    //           radius: 35,
    //           titleStyle: GoogleFonts.nunito(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.white),
    //         ),
    //       ],
    //       centerSpaceRadius: 40,
    //     ),
    //   );
    // });
  }
}

class HostellerChartApp1 extends StatelessWidget {
  HostellerChartApp1({super.key});
  final TutorHomeController controller = Get.put(TutorHomeController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(8),
          height: MediaQuery.sizeOf(context).height * 0.24,
          child: Row(
            children: [
              Expanded(child: PieChartWidget1()),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 18,
                          width: 18,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Present - ${0}',
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 18,
                          width: 18,
                          color: Color(0xffAD0F60),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Absent - ${0}',
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   children: [
                    //     Container(
                    //         height: 18,
                    //       width: 18,
                    //       color: Colors.blue,
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //             'Leave - ${0}',
                    //             style: GoogleFonts.nunito(
                    //                 fontSize: 14,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.black),
                    //           ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      children: [
                        Container(
                          height: 18,
                          width: 18,
                          color: Colors.orange[500],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Miss punch - ${0}',
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      DateFormat('MMMM yyyy')
                          .format(DateTime.now()), // Displays "March 2025"
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData({required this.x, required this.y});
}

class ChartData1 {
  final String x;
  final double y;

  ChartData1({required this.x, required this.y});
}
