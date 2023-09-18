import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_week.dart';
import 'package:app_bin_mobile/src/features/stats/data/repository/app_week_filter_repository_impl.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/widgets/app_week_date_card.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

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
            ListView.builder(
              shrinkWrap: true,
              itemCount: appWeekResults.length,
              itemBuilder: (context, index) {
                final item = appWeekResults[index];
                return AppWeekDateCard(
                  appWeek: item,
                );
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
    getAppWeek(androidInfo.device);
  }

  Future<void> getAppWeek(String? code) async {
    try {
      final results = await AppWeekFilterRepositoryImpl()
          .filterAppWeeks(deviceCode: code ?? deviceCode);
      setState(() {
        appWeekResults = results;
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
