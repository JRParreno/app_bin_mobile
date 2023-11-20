import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/bloc/enums/view_status.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_confirm_dialog.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/local_storage/local_storage.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:app_bin_mobile/src/features/block/data/models/block_app.dart';
import 'package:app_bin_mobile/src/features/block/data/models/schedule.dart';
import 'package:app_bin_mobile/src/features/block/presentation/bloc/block_apps/block_apps_bloc.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/remote_block/remote_select_block_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/widget/device/list_block_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:duration_picker/duration_picker.dart';

class RemoteAddUsageLimitScreenArgs {
  final Device device;

  RemoteAddUsageLimitScreenArgs({
    required this.device,
  });
}

class RemoteAddUsageLimitScreen extends StatefulWidget {
  static const String routeName = '/add-usage-limit/remote';
  const RemoteAddUsageLimitScreen({super.key, required this.args});

  final RemoteAddUsageLimitScreenArgs args;

  @override
  State<RemoteAddUsageLimitScreen> createState() => _AddUsageLimitState();
}

class _AddUsageLimitState extends State<RemoteAddUsageLimitScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  bool isSetSchedule = false;
  Schedule? mySchedule;
  late final BlockAppsBloc blockAppsBloc;

  @override
  void initState() {
    checkSchedule();
    handleSetBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: "Usage Limit",
        showBackBtn: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: mySchedule != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Set Schedule',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        ),
                        if (mySchedule != null) ...[
                          IconButton(
                            onPressed: handleChangeSchedule,
                            icon: const Icon(
                              Icons.delete,
                              size: 30,
                              color: ColorName.primary,
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                  if (mySchedule != null) ...[
                    scheduleDisplay(),
                  ] else ...[
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: CustomText(
                          text: 'No schedule found',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: CustomBtn(
                            label: "Add Hourly",
                            onTap: () => handleSetSchedule(true),
                            width: null,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: CustomBtn(
                            label: "Add Daily",
                            onTap: () => handleSetSchedule(false),
                            width: null,
                          ),
                        ),
                      ],
                    )
                  ],
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Divider(
                  color: ColorName.primary,
                  thickness: 3,
                ),
              ),
              BlocBuilder<BlockAppsBloc, BlockAppsState>(
                builder: (context, state) {
                  if (state.viewStatus == ViewStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.viewStatus == ViewStatus.failed) {
                    return Center(
                      child: CustomText(text: state.errorMessage ?? ''),
                    );
                  }

                  if (state.apps.isEmpty) {
                    return const SizedBox();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Blocked Apps',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35),
                            ),
                            IconButton(
                              onPressed: () {
                                handleNavigate(state.apps);
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 30,
                                color: ColorName.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                      ListBlockApps(
                        blockApps: state.apps,
                      )
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

  void handleSetBloc() {
    blockAppsBloc = BlocProvider.of<BlockAppsBloc>(context);
    blockAppsBloc.add(GetBlockAppsEvent(widget.args.device.deviceCode));
  }

  void handleNavigate(List<BlockApp> apps) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: RemoteSelectBlockScreen(
          args: RemoteSelectBlockScreenArgs(apps: apps)),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.fade,
    ).whenComplete(() {
      blockAppsBloc.add(GetBlockAppsEvent(widget.args.device.deviceCode));
    });
  }

  Widget scheduleDisplay() {
    final schedule = mySchedule;

    if (schedule != null) {
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

      return Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Schedule Type: $title',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                fontStyle: FontStyle.italic,
              ),
            ),
            CustomText(
              text: 'Block apps start at: $startAt',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                fontStyle: FontStyle.italic,
              ),
            ),
            CustomText(
              text: 'Block apps end at: $endAt',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                fontStyle: FontStyle.italic,
              ),
            ),
            CustomText(
              text: 'Duration: $hoursStr$minuesStr',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }

  Future<void> checkSchedule() async {
    final tempSchedule =
        await LocalStorage.readLocalStorage(AppConstant.schedule);

    if (tempSchedule != null) {
      setState(() {
        mySchedule = Schedule.fromJson(tempSchedule);
      });
    }
  }

  Future<void> handleSetSchedule(bool isHourly) async {
    Duration? picker = await showDurationPicker(
      context: context,
      initialTime: const Duration(minutes: 30),
    );

    if (picker != null) {
      setTimeStart(duration: picker, isHourly: isHourly);
    }
  }

  void handleChangeSchedule() {
    CommonConfirmDialog.showDialog(
      context: context,
      content: 'Change schedule? Will be delete the current one',
      onTapYes: handleDeleteSchedule,
    );
  }

  Future<void> handleDeleteSchedule() async {
    // ignore: use_build_context_synchronously
    BlocProvider.of<AppsBloc>(context).add(AppsDeleteScheduleEvent());
    await LocalStorage.deleteLocalStorage(AppConstant.schedule);
    setState(() {
      mySchedule = null;
    });
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  Future<void> setTimeStart({
    required Duration duration,
    bool isHourly = true,
  }) async {
    Future<TimeOfDay?> picker = showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    final selectedTime = await picker;

    if (selectedTime != null) {
      final DateTime now = DateTime.now();

      final hourlySchedule = Schedule(
        myDateTime: DateTime(now.year, now.month, now.day, selectedTime.hour,
            selectedTime.minute),
        isHourly: isHourly,
        hours: duration.inHours,
        minutes: duration.inMinutes,
      );

      // ignore: use_build_context_synchronously
      BlocProvider.of<AppsBloc>(context)
          .add(AppsScheduleEvent(schedule: hourlySchedule));

      await LocalStorage.storeLocalStorage(
          AppConstant.schedule, hourlySchedule.toJson());
      setState(() {
        mySchedule = hourlySchedule;
      });
    }
  }
}
