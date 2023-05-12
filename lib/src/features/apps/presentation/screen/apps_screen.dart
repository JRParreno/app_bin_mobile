import 'package:app_bin_mobile/gen/assets.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/widgets/app_installed_list.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "App Bin Apps",
        ),
      ),
      body: BlocBuilder<AppsBloc, AppsState>(
        builder: (context, state) {
          if (state is AppsLoaded) {
            final filterApps =
                state.applications.where((element) => element.isBlock).toList();
            if (filterApps.isNotEmpty) {
              return AppInstalledList(
                apps: filterApps,
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
}
