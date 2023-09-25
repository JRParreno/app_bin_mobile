import 'package:app_bin_mobile/src/features/stats/presentation/screens/apps_statistics_filter_screen.dart';
import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/features/stats/data/models/chart_data.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/bloc/app_stats_bloc.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/widgets/list_app_duration.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: "Statistics"),
        actions: [
          IconButton(
              onPressed: () {
                // testBloc();
                toNavigateScreen(
                    context: context,
                    screen: const AppStatisticsFilterScreen());
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      body: BlocBuilder<AppStatsBloc, AppStatsState>(
        builder: (context, state) {
          if (state is InitialState || state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AppStatsLoaded) {
            final chartData = Helper.getAppUsageChartData(state);
            final firstDayWeek = DateFormat('MMM dd, yyyy')
                .format(Helper.findFirstDateOfTheWeek(state.filterDate));
            final endDayWeek = DateFormat('MMM dd, yyyy')
                .format(Helper.findLastDateOfTheWeek(state.filterDate));

            final durationTitle = state.duration.inHours > 0
                ? '${state.duration.inHours}hrs ${state.duration.inMinutes.remainder(60)}mins'
                : '${state.duration.inMinutes.remainder(60)}mins';

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
                    text: '$firstDayWeek - $endDayWeek',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: durationTitle,
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
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          labelFormat: '{value} hrs',
                          interval:
                              getMaximumIntervalValue(state.duration.inHours),
                          maximum: getMaximumValues(state.duration.inHours),
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

                              return hours > 0
                                  ? hours
                                  : num.parse(
                                      (minutes / 60).toStringAsFixed(2));
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
                    currentApps: state.apps,
                  ),
                ],
              ),
            );
          } else if (state is ErrorState) {
            return const Center(
              child: CustomText(text: 'Something went wrong'),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void toNavigateScreen(
      {required BuildContext context, required Widget screen}) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: screen,
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    ).whenComplete(() {});
  }

  Future<void> testBloc() async {
    final appStats = await Helper.getDailyAppUsage();
    final apps = await Helper.getListOfApps();
    // ignore: use_build_context_synchronously
    BlocProvider.of<AppStatsBloc>(context).add(AppStatsInitialUsage(
      appBinStats: [appStats],
      apps: apps,
    ));
  }

  double getMaximumValues(int inHours) {
    if (inHours < 1) {
      return 0.5;
    } else if (inHours < 2) {
      return 3;
    } else if (inHours < 5) {
      return 5;
    } else if (inHours < 8) {
      return 10;
    } else if (inHours < 10) {
      return 15;
    } else {
      return 24;
    }
  }

  double getMaximumIntervalValue(int inHours) {
    if (inHours < 1) {
      return 0.25;
    } else if (inHours < 2) {
      return 2;
    } else if (inHours < 5) {
      return 3;
    } else if (inHours < 8) {
      return 2;
    } else if (inHours < 10) {
      return 3;
    } else {
      return 4;
    }
  }
}
