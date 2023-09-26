import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/features/device/add_device/data/add_device_repository_impl.dart';
import 'package:app_bin_mobile/src/features/device/view_device/presentation/bloc/pair_device_user_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ndialog/ndialog.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  static const String routeName = '/add-device-screen';

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Add Device"),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: Center(
          child: Form(
            key: formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              CustomTextField(
                textController: emailCtrl,
                labelText: "Enter email address",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
              ),
              const Divider(
                color: Colors.transparent,
              ),
              CustomBtn(
                label: "Pair",
                onTap: handleCheckForm,
                width: 275,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void handleCheckForm() {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      AddDeviceRepositoryImpl().addDevice(emailCtrl.value.text).then((value) {
        showDialogReport(value);
        emailCtrl.text = "";
        formKey.currentState!.reset();
      }).catchError((onError) {
        EasyLoading.dismiss();
        final DioException error = onError as DioException;
        if (error.response != null) {
          final response = error.response!.data;
          showDialogReport(response['error_message']);
        }
      }).whenComplete(() {
        EasyLoading.dismiss();
        fetchPairDevices();
      });
    }
  }

  void showDialogReport(String message) {
    Future.delayed(const Duration(milliseconds: 500), () {
      NDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: const CustomText(text: AppConstant.appName),
        content: CustomText(text: message),
        actions: <Widget>[
          TextButton(
              child: const CustomText(text: "Close"),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ).show(context);
    });
  }

  void fetchPairDevices() {
    BlocProvider.of<PairDeviceUserBloc>(context).add(FetchPairDeviceEvent());
  }
}
