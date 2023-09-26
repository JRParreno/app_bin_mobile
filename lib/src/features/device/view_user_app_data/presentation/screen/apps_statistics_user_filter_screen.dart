import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/device/view_user_app_data/presentation/bloc/app_stats_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppStatisticsUserFilterScreen extends StatefulWidget {
  static const String routeName = 'app-statistic-filter-screen';

  const AppStatisticsUserFilterScreen({
    super.key,
    required this.deviceCode,
    required this.userPk,
  });

  final String userPk;
  final String deviceCode;

  @override
  State<AppStatisticsUserFilterScreen> createState() =>
      _AppStatisticsUserFilterScreenState();
}

class _AppStatisticsUserFilterScreenState
    extends State<AppStatisticsUserFilterScreen> {
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

  Future<void> fetchAppDataList(DateTime date) async {
    BlocProvider.of<AppStatsUserBloc>(context).add(
      AppStatsFetchUserUsage(
        date: date,
        deviceCode: widget.deviceCode,
        userPk: widget.userPk,
      ),
    );

    Navigator.pop(context);
  }
}
