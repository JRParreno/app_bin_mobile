import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/widgets/app_installed_list.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppsScreen extends StatefulWidget {
  static const String routeName = '/apps';

  const AppsScreen({super.key});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  @override
  void initState() {
    getApps();
    super.initState();
  }

  void getApps() async {
    final tempList =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);

    Future.delayed(const Duration(seconds: 2), () {
      BlocProvider.of<AppsBloc>(context).add(
        AppsLoadEvent(
          applications: Helper.filterApps(tempList),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const CustomText(
        text: "App Bin Apps",
      )),
      body: BlocBuilder<AppsBloc, AppsState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AppsLoaded) {
            return AppInstalledList(
              apps: state.applications,
            );
          }
          return Container();
        },
      ),
    );
  }
}
