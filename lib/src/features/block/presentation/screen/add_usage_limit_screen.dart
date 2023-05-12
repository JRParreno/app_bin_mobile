import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/core/local_storage/local_storage.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_apps.dart';
import 'package:app_bin_mobile/src/features/block/presentation/widget/usage_limit/apps_tile.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddUsageLimitScreen extends StatefulWidget {
  static const String routeName = '/add-usage-limit';
  const AddUsageLimitScreen({super.key});

  @override
  State<AddUsageLimitScreen> createState() => _AddUsageLimitState();
}

class _AddUsageLimitState extends State<AddUsageLimitScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  List<Application> apps = [];
  bool isApLoaded = false;

  void setupAppBlock() {
    if (!isApLoaded) {
      final state = BlocProvider.of<AppsBloc>(context).state;
      List<AppBinApps> tempApps = [];
      if (state is AppsLoaded) {
        tempApps = state.applications.where(
          (e) {
            return e.isBlock;
          },
        ).toList();
      }
      setState(() {
        apps = tempApps.map((e) => e.application).toList();
        isApLoaded = true;
      });
    }
  }

  @override
  void initState() {
    setupAppBlock();
    super.initState();
  }

  bool isAppBlock(AppBinApps app) {
    final appExists = apps
        .where((element) => element.packageName == app.application.packageName)
        .toList();
    return appExists.isNotEmpty;
  }

  void handleSaveWhiteList() async {
    BlocProvider.of<AppsBloc>(context).add(
      AppsWhiteListEvent(applications: apps),
    );

    EasyLoading.showSuccess("Saving please wait..");

    final appPackages = apps.map((e) => e.packageName);

    await LocalStorage.storeLocalStorage('_whiteList', appPackages.join(', '));

    await Future.delayed(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
    });
    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  List<AppBinApps> handleSearch(AppsLoaded state) {
    if (searchCtrl.value.text.isEmpty) {
      return state.applications;
    }
    return state.applications
        .where((element) => element.application.appName
            .toLowerCase()
            .contains(searchCtrl.value.text))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: "Usage Limit",
        showBackBtn: false,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: CustomTextField(
                labelText: 'Search apps',
                textController: searchCtrl,
                onChanged: (p0) {
                  BlocProvider.of<AppsBloc>(context).add(
                    AppsSearchEvent(query: p0),
                  );
                },
              ),
            ),
            BlocBuilder<AppsBloc, AppsState>(
              builder: (ctx, state) {
                if (state is InitialState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is AppsLoaded) {
                  if (state.applications.isEmpty) {
                    return const Flexible(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CustomText(
                              text: "Apps",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: Column(children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: handleSearch(state).length,
                                  itemBuilder: ((context, index) {
                                    final appBin = handleSearch(state)[index];
                                    return AppsTile(
                                      app: appBin.application
                                          as ApplicationWithIcon,
                                      isBlock: isAppBlock(appBin),
                                      isOnchanged: (value) {
                                        if (value) {
                                          setState(() {
                                            apps.add(appBin.application);
                                          });
                                        } else {
                                          setState(() {
                                            apps = apps
                                                .where((element) =>
                                                    element.packageName !=
                                                    appBin.application
                                                        .packageName)
                                                .toList();
                                          });
                                        }
                                      },
                                    );
                                  }),
                                ),
                              ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: CustomBtn(
                              label: "Save",
                              onTap:
                                  apps.isNotEmpty ? handleSaveWhiteList : null,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
