import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_week.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/bloc/app_stats_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppStatisticsFilterScreen extends StatefulWidget {
  static const String routeName = 'app-statistic-filter-screen';

  const AppStatisticsFilterScreen({super.key});

  @override
  State<AppStatisticsFilterScreen> createState() =>
      _AppStatisticsFilterScreenState();
}

class _AppStatisticsFilterScreenState extends State<AppStatisticsFilterScreen> {
  late final String deviceCode;
  List<AppWeek> appWeekResults = [];

  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(text: "Filter Statistic Dates"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.single,
              showActionButtons: true,
              showNavigationArrow: true,
              onSubmit: (p0) {
                try {
                  final date = p0 as DateTime;
                  fetchAppDataList(date);
                } catch (e) {
                  print(e.toString());
                }
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 50,
            ),
            CustomBtn(
              label: 'Clear Filter',
              onTap: () {
                final today = DateTime.now();
                fetchAppDataList(today);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceCode = androidInfo.device;
  }

  Future<void> fetchAppDataList(DateTime date) async {
    BlocProvider.of<AppStatsBloc>(context)
        .add(AppStatsFetchUsage(date: date, deviceCode: deviceCode));

    Navigator.pop(context);
  }
}
