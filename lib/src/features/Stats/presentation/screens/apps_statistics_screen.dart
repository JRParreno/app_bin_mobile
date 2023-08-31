import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/features/stats/models/chart_data.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/bloc/app_stats_bloc.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/widgets/list_app_duration.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  List<AppUsageInfo> currentUsageInfo = [];
  Duration duration = const Duration();
  List<Application> myApps = [];

  @override
  void initState() {
    getCurrentApps();
    super.initState();
  }

  Future<void> getCurrentApps() async {
    final tempList =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);
    setState(() {
      myApps = tempList
          .where((element) =>
              element.category == ApplicationCategory.game ||
              element.category == ApplicationCategory.social ||
              element.category == ApplicationCategory.productivity)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "Statistics"),
      ),
      body: BlocBuilder<AppStatsBloc, AppStatsState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AppStatsLoaded) {
            final chartData = Helper.getAppUsageChartData(state);

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorName.primary,
                    ),
                    margin: const EdgeInsets.all(20),
                    child: const CustomText(
                      text: "Weekly Usage",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomText(
                    text:
                        '${state.duration.inHours}hrs ${state.duration.inMinutes.remainder(60)}mins today',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Center(
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
                            xValueMapper: (AppUsageChartData sales, _) =>
                                sales.dayName,
                            yValueMapper: (AppUsageChartData sales, _) {
                              final hours = sales.duration.inHours;
                              final minutes = sales.duration.inMinutes;

                              return hours > 0 ? hours : minutes;
                            },
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(fontSize: 10),
                            ),
                            yAxisName: "Hours"),
                      ],
                      onDataLabelTapped: (args) {},
                      onAxisLabelTapped: (args) {},
                    ),
                  ),
                  ListAppDuration(
                    apps: state.appUsage.last,
                    currentApps: myApps,
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
