import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/features/device/view_all_user_device/presentation/bloc/view_all_user_device_bloc.dart';
import 'package:app_bin_mobile/src/features/device/view_all_user_device/presentation/widgets/device_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAllUserDeviceScreen extends StatefulWidget {
  const ViewAllUserDeviceScreen(
      {super.key, required this.fullName, required this.pk});

  final String fullName;
  final String pk;

  @override
  State<ViewAllUserDeviceScreen> createState() =>
      _ViewAllUserDeviceScreenState();
}

class _ViewAllUserDeviceScreenState extends State<ViewAllUserDeviceScreen> {
  @override
  void initState() {
    super.initState();
    initialBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "${widget.fullName} Device"),
      body: BlocBuilder<ViewAllUserDeviceBloc, ViewAllUserDeviceState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ViewAllUserDeviceLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                Future.delayed(const Duration(milliseconds: 500), () {
                  initialBloc();
                });
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.devices.length,
                itemBuilder: (context, index) {
                  final item = state.devices[index];

                  return DeviceCard(device: item);
                },
              ),
            );
          }

          if (state is EmptyState) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: "No Device found",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomBtn(
                      label: 'Refresh',
                      onTap: () {
                        initialBloc();
                      },
                    )
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void initialBloc() {
    BlocProvider.of<ViewAllUserDeviceBloc>(context)
        .add(FetchAllUserDeviceEvent(widget.pk));
  }
}
