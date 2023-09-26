import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/features/device/request_device/presentation/bloc/request_pair_device_user_bloc.dart';
import 'package:app_bin_mobile/src/features/device/request_device/presentation/widgets/request_pair_device_card.dart';
import 'package:app_bin_mobile/src/features/device/view_device/data/models/pair_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ndialog/ndialog.dart';

class RequestDeviceScreen extends StatefulWidget {
  const RequestDeviceScreen({super.key});

  @override
  State<RequestDeviceScreen> createState() => _RequestDeviceScreenState();
}

class _RequestDeviceScreenState extends State<RequestDeviceScreen> {
  @override
  void initState() {
    super.initState();
    initialValueBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Request Device(s)"),
      body: BlocConsumer<RequestPairDeviceUserBloc, RequestPairDeviceUserState>(
        listener: (context, state) {
          if (state is RequestPairDeviceUserLoaded) {
            if (state.isUpdating) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is RequestPairDeviceUserLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                Future.delayed(const Duration(microseconds: 500), () {
                  initialValueBloc();
                });
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.pairDevies.length,
                itemBuilder: (context, index) {
                  final item = state.pairDevies[index];

                  return RequestPairDeviceCard(
                    pairDevice: item,
                    onAccept: () {
                      showDialogReport(
                          device: item,
                          isAccept: true,
                          index: index,
                          message:
                              "Accept this request?\nIt will share you data across your device.");
                    },
                    onReject: () {
                      showDialogReport(
                          device: item,
                          isAccept: false,
                          index: index,
                          message: "Reject this request?");
                    },
                  );
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
                        initialValueBloc();
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

  void showDialogReport({
    required String message,
    required bool isAccept,
    required PairDevice device,
    required int index,
  }) {
    Future.delayed(const Duration(milliseconds: 500), () {
      NDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: const CustomText(text: AppConstant.appName),
        content: CustomText(text: message),
        actions: <Widget>[
          TextButton(
              child: const CustomText(text: "Yes"),
              onPressed: () {
                onSubmitRequestDevice(isAccept: isAccept, index: index);

                Navigator.pop(context);
              }),
          TextButton(
              child: const CustomText(text: "No"),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ).show(context);
    });
  }

  Future<void> onSubmitRequestDevice({
    required bool isAccept,
    required int index,
  }) async {
    // ignore: use_build_context_synchronously
    BlocProvider.of<RequestPairDeviceUserBloc>(context)
        .add(UpdatePairDeviceEvent(
      index: index,
      isAccept: isAccept,
    ));
  }

  void initialValueBloc() {
    BlocProvider.of<RequestPairDeviceUserBloc>(context)
        .add(FetchRequestPairDeviceEvent());
  }
}
