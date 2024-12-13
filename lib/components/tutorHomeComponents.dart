import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/tutorHome_controllers.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartApp extends StatelessWidget {
  ChartApp({super.key});
  final TutorHomeController controller = Get.put(TutorHomeController());
  @override
  Widget build(BuildContext context) {
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
            height: MediaQuery.sizeOf(context).height * 0.24,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
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
                            color: Color(0xffAD0F60),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          controller.dailyattendance.value != null
                              ? Text(
                                  'Absent - ${controller.dailyattendance.value!.absent!.toString()}',
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
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          controller.dailyattendance.value != null
                              ? Text(
                                  'Present - ${controller.dailyattendance.value!.present!.toString()}',
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                              height: 18,
                            width: 18,
                            color:  Colors.blue,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          controller.dailyattendance.value != null
                              ? Text(
                                  'Leave - ${controller.dailyattendance.value!.leave!.toString()}',
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 18,
                            width: 18,
                            color:  Colors.orange[500],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          controller.dailyattendance.value != null
                              ? Text(
                                  'Miss punch - ${controller.dailyattendance.value!.missPunch!.toString()}',
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
                      controller.currentMonthYear!=null?
                      Text(
                        controller.currentMonthYear!,
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ):const SizedBox.shrink()
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
  final TutorHomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox.shrink();
      }

      final percentage = controller.dailyattendance.value?.percentage;
      //Logger().i("dsg€sdgsg${percentage!.absent}");
      if (percentage == null) {
        return const Center(child: Text("No data found"));
      }

      double? present = double.parse(
                  percentage.present!.replaceAll('%', '')
                     );
                    
      double? absent = double.parse(percentage.absent!.replaceAll('%', ''));
      double? leave = double.parse(percentage.leave!.replaceAll('%', ''));
      double? partial = double.parse(percentage.missPunch!.replaceAll('%', ''));

      final total = present + absent + leave + partial.toInt();

      // If all values are 0, display a single blue circle
      if (total == 0) {
        return PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                color: Color(0xff7E71FF ),
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
           title:'${present.toInt()}%',
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

      if (leave > 0) {
        sections.add(
          PieChartSectionData(
            color: Colors.blue,
            value: leave,
            title: ' ${leave.toInt()}%',
            radius: 40,
            titleStyle: GoogleFonts.nunito(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }

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


class ChartApp1 extends StatelessWidget {
  ChartApp1({super.key});
  final TutorHomeController controller = Get.put(TutorHomeController());
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
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
                            color: Colors.orange,
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
                      Row(
                        children: [
                          Container(
                             height: 18,
                            width: 18,
                            color: Colors.purple,
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
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                              height: 18,
                            width: 18,
                            color: Color(0xff014EA9),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                                  'Leave - ${0}',
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 18,
                            width: 18,
                            color: Color(0xff2E5BB5),
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
                     
                      // Text(
                      //   controller.currentMonthYear!,
                      //   style: GoogleFonts.nunito(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black),
                      // )
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


class StudentChartApp extends StatelessWidget {
  const StudentChartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 10),
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(5),
          height: MediaQuery.sizeOf(context).height * 0.26,
          child: Row(
            children: [
              Expanded(child: StudentPIeChart()),
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
                          height: 20,
                          width: 20,
                          color: Colors.orange,
                        ),
                        Text(
                          ' - Present',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.purple,
                        ),
                        Text(
                          ' - Absent',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.blue,
                        ),
                        Text(
                          ' - Leave',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.pink,
                        ),
                        Text(
                          ' - Holiday',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.brown,
                        ),
                        Text(
                          ' - Miss punch',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'June - 2024',
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StudentPIeChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.purple,
            value: 25,
            title: '25',
            // titlePositionPercentageOffset: 0.7,
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: 15,
            title: '15',
            // titlePositionPercentageOffset: 0.7,
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.blue,
            value: 20,
            title: '20',
            // titlePositionPercentageOffset: 0.7,
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.pink,
            value: 20,
            title: '20',
            // titlePositionPercentageOffset: 0.7,
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            // titlePositionPercentageOffset: 0.2,
            color: Colors.orange,
            value: 20,
            title: '20',
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
        centerSpaceRadius: 40,
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 30,
                color: Colors.purple,
                width: 20,
              ),
              BarChartRodData(
                toY: 10,
                color: Colors.orange,
                width: 20,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 35,
                color: Colors.purple,
                width: 20,
              ),
              BarChartRodData(
                toY: 5,
                color: Colors.orange,
                width: 20,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 35,
                color: Colors.purple,
                width: 20,
              ),
              BarChartRodData(
                toY: 20,
                color: Colors.orange,
                width: 20,
              ),
            ],
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                TextStyle style = const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                );
                switch (value.toInt()) {
                  case 0:
                    return Text('Jan', style: style);
                  case 1:
                    return Text('Feb', style: style);
                  case 2:
                    return Text('Mar', style: style);
                  default:
                    return const Text('');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LineChartSample extends StatefulWidget {
  final String userType;
  const LineChartSample({Key? key, required this.userType}) : super(key: key);

  @override
  State<LineChartSample> createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  String? _selectedBatch; // Initial value
  // List<String> _batches = ['Batch 1', 'Batch 2', 'Batch 3'];
  //  List<String> _class = ['Maths', 'English', 'Science'];
  final TutorHomeController controller = Get.put(TutorHomeController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black.withOpacity(.4),
        color: Colors.white,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      if(controller.isLoading.value){
                       return const CircularProgressIndicator();
                      }
                      return             SizedBox(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: CustomDropdown(
                          itemsListPadding: EdgeInsets.zero,
                                listItemPadding: EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                          hintText: 'Select batch',
                          items: controller.batchList.map((batch) => batch.batchName ?? '').toList(),
                          initialItem:controller.selectedBatchIN.value?.batchName,
                          onChanged: (String? selectedValue) {
                            if (selectedValue != null) {
                              final selectedBatch = controller.batchList.firstWhere(
                                (batch) => batch.batchName == selectedValue,
                              );
                              controller.selectBatch(selectedBatch);
                              controller.isBatchSelected.value = true;
                              controller.fetchBatchList(
                                selectedBatch.batchId!,
                        
                              );
                            }
                          },
                        ),
                      )
;
                      // DropdownButton<Data1>(
                      //   value: controller.selectedBatchIN.value,
                      //   hint: widget.userType == 'Tutee'
                      //       ? Text('Class')
                      //       : Text('Select'),
                      //   icon: const Icon(Icons.arrow_drop_down),
                      //   iconSize: 24,
                      //   elevation: 16,
                      //   style: const TextStyle(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w500,
                      //       color: Colors.black),
                      //   underline: Container(
                      //     height: 0,
                      //     color: Colors.transparent,
                      //   ),
                      //   onChanged: (newBatch) {
                      //     if (newBatch != null) {
                      //       controller.selectBatch(newBatch);
                      //       controller.isBatchSelected.value = true;
                      //       controller.fetchBatchList(
                      //         newBatch.batchId!,
                      //       );
                      //     }
                      //   },
                      //   items: controller.batchList.map((Data1 batch) {
                      //     return DropdownMenuItem<Data1>(
                      //       value: batch,
                      //       child: Text(batch.batchName!),
                      //     );
                      //   }).toList(),
                      // );
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Toggle Buttons for Month/Year
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    controller.isMonthSelected = true.obs;
                                  });
                                },
                                child: Container(
                                  // color: controller.isMonthSelected.value
                                  //       ? const Color(0xffFF8800)
                                  //       : Colors.grey.shade300,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    'Monthly',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: controller.isMonthSelected.value
                                          ? Colors.blue
                                          : Colors.black45,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                          height: 15,
                          width: 1.5,
                          color: Colors.black.withOpacity(0.5),
                        ),
                              //const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    controller.isMonthSelected.value = false;
                                  });
                                },
                                child: Container(
                                  // color: !controller.isMonthSelected.value
                                  //       ? const Color(0xffFF8800)
                                  //       : Colors.grey.shade300,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    'Yearly',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: !controller.isMonthSelected.value
                                          ? Colors.blue
                                          : Colors.black45,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              controller.isMonthSelected.value
                  ? ValueListenableBuilder<List<ChartData>>(
                      valueListenable: controller.chartData,
                      builder: (context, data, _) {
                        return Column(
                          children: [
                            controller.isLoading1.value
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    height: 130,
                                    child: SfCartesianChart(
                                      series: <CartesianSeries>[
                                        LineSeries<ChartData, String>(
                                          color: Colors.red,
                                          dataSource: data,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          markerSettings: const MarkerSettings(
                                            shape: DataMarkerType.circle,
                                            isVisible: true,
                                          ),
                                        ),
                                      ],
                                      primaryXAxis: const CategoryAxis(
                                        title: AxisTitle(text: 'Month'),
                                        axisLine: AxisLine(width: .5),
                                        majorGridLines:
                                            MajorGridLines(width: 0.4),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: AxisTitle(
                                            text: 'Student Count',
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        axisLine: AxisLine(width: 1),
                                        majorGridLines:
                                            MajorGridLines(width: 0.4),
                                      ),
                                    ),
                                  ),
                          ],
                        );
                      },
                    )
                  : ValueListenableBuilder<List<ChartData1>>(
                      valueListenable: controller.chartData1,
                      builder: (context, data, _) {
                        return Column(
                          children: [
                            controller.isLoading1.value
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    height: 130,
                                    child: SfCartesianChart(
                                      series: <CartesianSeries>[
                                        LineSeries<ChartData1, String>(
                                          color: Colors.red,
                                          dataSource: data,
                                          xValueMapper: (ChartData1 data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData1 data, _) =>
                                              data.y,
                                          markerSettings: const MarkerSettings(
                                            shape: DataMarkerType.circle,
                                            isVisible: true,
                                          ),
                                        ),
                                      ],
                                      primaryXAxis: const CategoryAxis(
                                        title: AxisTitle(text: 'Year'),
                                        axisLine: AxisLine(width: .5),
                                        majorGridLines:
                                            MajorGridLines(width: 0.4),
                                      ),
                                      primaryYAxis: const NumericAxis(
                                        title: AxisTitle(
                                            text: 'Student Count',
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        axisLine: AxisLine(width: 1),
                                        majorGridLines:
                                            MajorGridLines(width: 0.4),
                                      ),
                                    ),
                                  ),
                          ],
                        );
                      },
                    )
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
