import 'package:app_bin_mobile/src/features/block/data/models/block_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_bin_mobile/src/core/bloc/enums/view_status.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/features/block/presentation/bloc/block_select_app/block_select_app_bloc.dart';
import 'package:app_bin_mobile/src/features/block/presentation/widget/usage_limit/remote_apps_tile.dart';

class RemoteSelectBlockScreenArgs {
  final List<BlockApp> apps;

  RemoteSelectBlockScreenArgs({
    required this.apps,
  });
}

class RemoteSelectBlockScreen extends StatefulWidget {
  static const String routeName = '/search-app-block/remote';
  const RemoteSelectBlockScreen({super.key, required this.args});

  final RemoteSelectBlockScreenArgs args;

  @override
  State<RemoteSelectBlockScreen> createState() => _RemoteSelectBlockState();
}

class _RemoteSelectBlockState extends State<RemoteSelectBlockScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  late final BlockSelectAppBloc blockSelectAppBloc;

  @override
  void initState() {
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
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: BlocBuilder<BlockSelectAppBloc, BlockSelectAppState>(
          bloc: blockSelectAppBloc,
          builder: (ctx, state) {
            if (state.viewStatus == ViewStatus.loading) {
              return const Flexible(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final myApps = getApps(query: state.searchText, apps: state.apps);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: CustomTextField(
                    labelText: 'Search apps',
                    textController: searchCtrl,
                    onChanged: (p0) {
                      blockSelectAppBloc.add(OnSearchTextEvent(p0));
                    },
                  ),
                ),
                Flexible(
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
                        if (myApps.isEmpty) ...[
                          const Center(
                            child: CustomText(text: 'No Apps found'),
                          ),
                        ] else ...[
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: Column(children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: myApps.length,
                                  itemBuilder: ((context, index) {
                                    final device = state.apps[index];

                                    return RemoteAppsTile(
                                        deviceApp: device,
                                        onChangedSwitch: () {
                                          blockSelectAppBloc.add(
                                              OnChageBlockAppsEvent(index));
                                        });
                                  }),
                                ),
                              ]),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void handleSetBloc() {
    blockSelectAppBloc = BlocProvider.of<BlockSelectAppBloc>(context);
    blockSelectAppBloc.add(SetBlockAppsEvent(apps: widget.args.apps));
  }

  List<BlockApp> getApps({
    required String query,
    required List<BlockApp> apps,
  }) {
    if (query.isEmpty) return apps;

    return apps
        .where((element) => element.deviceApp.appName
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }
}
