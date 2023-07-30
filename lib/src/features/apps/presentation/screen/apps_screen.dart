import 'package:app_bin_mobile/gen/assets.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/local_storage/local_storage.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/widgets/app_installed_list.dart';
import 'package:app_bin_mobile/src/features/block/data/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';

class AppsScreen extends StatefulWidget {
  static const String routeName = '/apps';

  const AppsScreen({super.key});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  @override
  void initState() {
    getAppSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "App Bin Apps",
        ),
        actions: [
          BlocBuilder<AppsBloc, AppsState>(
            builder: (context, state) {
              if (state is AppsLoaded) {
                if (state.schedule != null) {
                  return IconButton(
                    onPressed: () => showInformationDialog(
                        context: context, schedule: state.schedule!),
                    icon: const Icon(Icons.info),
                  );
                }
              }
              return Container();
            },
          ),
        ],
      ),
      body: BlocBuilder<AppsBloc, AppsState>(
        builder: (context, state) {
          if (state is AppsLoaded) {
            final filterApps =
                state.applications.where((element) => element.isBlock).toList();

            if (filterApps.isNotEmpty) {
              return Column(
                children: [
                  AppInstalledList(
                    apps: filterApps,
                    schedule: state.schedule,
                  ),
                ],
              );
            }
            return SizedBox(
                child: Column(
              children: [
                SizedBox(
                    child:
                        Assets.json.branndsjetApplicationDevelopment.lottie()),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: CustomText(text: "No apps block, please tap blocking"),
                )
              ],
            ));
          }
          return Container();
        },
      ),
    );
  }

  void getAppSchedule() async {
    final tempSchedule =
        await LocalStorage.readLocalStorage(AppConstant.schedule);

    Future.delayed(const Duration(seconds: 1), () {
      if (tempSchedule != null) {
        BlocProvider.of<AppsBloc>(context).add(AppsScheduleEvent(
            schedule: Schedule.fromJson(tempSchedule.toString())));
      }
    });
  }

  void showInformationDialog({
    required BuildContext context,
    required Schedule schedule,
  }) async {
    final hours = schedule.hours;
    final minutes = schedule.minutes;

    final hoursStr = hours > 0 ? '$hours hrs ' : '';
    final minuesStr =
        minutes > 0 ? '${minutes > 60 ? minutes - 60 : minutes} mins' : '';
    final title = schedule.isHourly ? 'Hourly' : 'Daily';

    final meridean = schedule.myDateTime.hour > 12;
    final startAt =
        '${meridean ? schedule.myDateTime.hour - 12 : schedule.myDateTime.hour}:${schedule.myDateTime.minute} ${meridean ? "PM" : "AM"}';

    final endTime = DateTime(
            schedule.myDateTime.year,
            schedule.myDateTime.month,
            schedule.myDateTime.day,
            schedule.myDateTime.hour,
            schedule.myDateTime.minute)
        .add(Duration(hours: schedule.hours, minutes: schedule.minutes));
    final endMeridean = endTime.hour > 12;

    final endAt =
        '${endMeridean ? endTime.hour - 12 : endTime.hour}:${endTime.minute > 0 ? "${endTime.minute}" : '00'} ${endMeridean ? "PM" : "AM"}';

    NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const CustomText(text: AppConstant.appName),
      content: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Schedule Type: $title',
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            CustomText(
              text: 'Block apps start at: $startAt',
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            CustomText(
              text: 'Block apps end at: $endAt',
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            CustomText(
              text: 'Duration: $hoursStr$minuesStr',
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const CustomText(text: "Close"),
        ),
      ],
    ).show(context);
  }
}
