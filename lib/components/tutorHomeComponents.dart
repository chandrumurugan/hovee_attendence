import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartApp extends StatelessWidget {
  const ChartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(5),
          height: MediaQuery.sizeOf(context).height * 0.24,
          child: Row(
            children: [
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
                          height: 20,
                          width: 20,
                          color: Colors.orange,
                        ),
                        Text(
                          ' - Absent',
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
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.purple,
                        ),
                        Text(
                          ' - Present',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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

class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.purple,
            value: 70,
            title: '70%',
            // titlePositionPercentageOffset: 0.7,
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            // titlePositionPercentageOffset: 0.2,
            color: Colors.orange,
            value: 30,
            title: '30%',
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
                    SizedBox(
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
            title: '25%',
            // titlePositionPercentageOffset: 0.7,
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: 15,
            title: '15%',
            // titlePositionPercentageOffset: 0.7,
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.blue,
            value: 20,
            title: '20%',
            // titlePositionPercentageOffset: 0.7,
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.pink,
            value: 20,
            title: '20%',
            // titlePositionPercentageOffset: 0.7,
            radius: 35,
            titleStyle: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            // titlePositionPercentageOffset: 0.2,
            color: Colors.orange,
            value: 20,
            title: '20%',
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
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                TextStyle style = TextStyle(
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
                    return Text('');
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
  List<String> _batches = ['Batch 1', 'Batch 2', 'Batch 3'];
   List<String> _class = ['Maths', 'English', 'Science'];

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(x: 'Jan', y: 36),
      ChartData(x: 'Feb', y: 41),
      ChartData(x: 'Mar', y: 42),
      ChartData(x: 'Apr', y: 43),
      ChartData(x: 'May', y: 44),
      ChartData(x: 'Jun', y: 38),
      ChartData(x: 'Jul', y: 37),
      ChartData(x: 'Aug', y: 47),
      ChartData(x: 'Sep', y: 48),
      ChartData(x: 'Oct', y: 49),
      ChartData(x: 'Nov', y: 50),
      ChartData(x: 'Dec', y: 52),
    ];

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
                    DropdownButton<String>(
                      value: _selectedBatch,
                      hint: widget.userType =='Tutee'? Text('Class'):Text('Batch'),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBatch = newValue!;
                        });
                      },
                      items: _batches
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          elevation: 10,
                          shadowColor: Colors.black.withOpacity(.4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Months',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffFF8800),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: const Text(
                                    'Years',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 130,
                child: SfCartesianChart(
                  series: <CartesianSeries>[
                    LineSeries<ChartData, String>(
                      color: Colors.red,
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      markerSettings: const MarkerSettings(
                        shape: DataMarkerType.circle,
                        isVisible: true, // Show markers
                      ),
                    )
                  ],
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(text: '2024'),
                    axisLine: const AxisLine(width: .5),
                    majorGridLines: const MajorGridLines(width: 0.4),
                  ),
                  primaryYAxis: LogarithmicAxis(
                    title: AxisTitle(
                        text: 'Student count',
                        textStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    axisLine: const AxisLine(width: 1),
                    majorGridLines: const MajorGridLines(width: 0.4),
                  ),
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

