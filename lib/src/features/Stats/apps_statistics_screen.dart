import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/features/stats/models/chart_data.dart';
import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AppsStatisticsScreen extends StatefulWidget {
  static const String routeName = "/apps-statistics-screen";

  const AppsStatisticsScreen({
    super.key,
  });

  @override
  State<AppsStatisticsScreen> createState() => _AppsStatisticsScreenState();
}

class _AppsStatisticsScreenState extends State<AppsStatisticsScreen> {
  List<List<AppUsageInfo>> weekUsageinfos = [];
  List<AppUsageChartData> chartData = [];

  @override
  void initState() {
    getUsageInfo();
    super.initState();
  }

  void getUsageInfo() async {
    final tempWeekUsageinfos = await Helper.getAppUsage();
    final List<AppUsageChartData> tempChartData = [];

    for (var i = 0; i < tempWeekUsageinfos.length; i++) {
      final element = tempWeekUsageinfos[i];
      tempChartData.add(AppUsageChartData(
          dayName: Helper.getDayName(element.first.startDate.weekday),
          totalHrs: Helper.getMaxHours(element)));
    }
    setState(() {
      chartData = tempChartData;
      weekUsageinfos = tempWeekUsageinfos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(
          text: "STATS",
        ),
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 0),
            labelFormat: '{value}',
            majorTickLines: const MajorTickLines(size: 0)),
        series: <ColumnSeries<AppUsageChartData, String>>[
          ColumnSeries<AppUsageChartData, String>(
              // Binding the chartData to the dataSource of the column series.
              dataSource: chartData,
              xValueMapper: (AppUsageChartData sales, _) => sales.dayName,
              yValueMapper: (AppUsageChartData sales, _) =>
                  sales.totalHrs.toDouble(),
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(fontSize: 10),
              ),
              yAxisName: "Hours"),
        ],
        onDataLabelTapped: (args) {},
        onAxisLabelTapped: (args) {},
      ),
    );
  }
}
