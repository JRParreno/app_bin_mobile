import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/block/presentation/widget/usage_limit/apps_tile.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUsageLimitScreen extends StatefulWidget {
  static const String routeName = '/add-usage-limit';
  const AddUsageLimitScreen({super.key});

  @override
  State<AddUsageLimitScreen> createState() => _AddUsageLimitState();
}

class _AddUsageLimitState extends State<AddUsageLimitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: "Usage Limit",
        showBackBtn: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<AppsBloc, AppsState>(
          builder: (context, state) {
            if (state is InitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AppsLoaded) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.applications.length,
                    itemBuilder: ((context, index) {
                      return AppsTile(
                          app:
                              state.applications[index] as ApplicationWithIcon);
                    }),
                  ),
                ]),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
