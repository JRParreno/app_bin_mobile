import 'package:app_bin_mobile/src/core/bloc/enums/view_status.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/core/utils/profile_utils.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:app_bin_mobile/src/features/block/presentation/bloc/user_device/user_device_bloc.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/block_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/remote_block/remote_block_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/widget/device/block_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SelectDeviceBlock extends StatefulWidget {
  const SelectDeviceBlock({super.key});

  static const String routeName = 'block/select-device';

  @override
  State<SelectDeviceBlock> createState() => _SelectDeviceBlockState();
}

class _SelectDeviceBlockState extends State<SelectDeviceBlock> {
  @override
  void initState() {
    handleFetchDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: "Blocking",
        showBackBtn: true,
      ),
      body: BlocBuilder<UserDeviceBloc, UserDeviceState>(
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

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CustomText(
                        text: 'Select Device',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        handleOnTapCurrentDevice();
                      },
                      child: const Card(
                        child: ListTile(
                          leading: Icon(Icons.device_hub),
                          title: CustomText(text: 'Current Device'),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CustomText(
                        text: 'Other devices',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.devices.length,
                      itemBuilder: (context, index) {
                        final device = state.devices[index];

                        return BlockDevice(
                            device: device,
                            onTap: () {
                              handleOnTapSelectedDevice(device);
                            });
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> handleFetchDevice() async {
    final profile = ProfileUtils.userProfile(context);

    if (profile != null) {
      BlocProvider.of<UserDeviceBloc>(context)
          .add(GetUserDeviceEvent(profile.pk));
    }
  }

  void handleOnTapCurrentDevice() {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: const BlockScreen(),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  void handleOnTapSelectedDevice(Device device) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: RemoteBlockScreen(args: RemoteBlockScreenArgs(device: device)),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
