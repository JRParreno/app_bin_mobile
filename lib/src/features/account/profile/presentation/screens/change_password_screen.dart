import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/widgets/change_password/password_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ndialog/ndialog.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = 'change-password';
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController passwordConfirmCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _passwordConfirmVisible = true;

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      if (passwordConfirmCtrl.text == passwordCtrl.text) {
        ProfileRepositoryImpl()
            .changePassword(
                oldPassword: oldPasswordCtrl.text,
                newPassword: passwordCtrl.text)
            .then((value) {
          showDialogReport("Successfully change your password!");
          passwordConfirmCtrl.text = "";
          passwordCtrl.text = "";
          oldPasswordCtrl.text = "";
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
        });
      } else {
        EasyLoading.dismiss();
        showDialogReport("Password and Confirm password doesn't match");
      }
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
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pop(context);
                });
              }),
        ],
      ).show(context);
    });
  }

  void handleOnConfirmChangePassVisible() {
    setState(() {
      _passwordConfirmVisible = !_passwordConfirmVisible;
    });
  }

  void handleOnChangePassVisible() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Change Password"),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            PasswordForm(
              formKey: formKey,
              oldPasswordCtrl: oldPasswordCtrl,
              passwordConfirmCtrl: passwordConfirmCtrl,
              passwordCtrl: passwordCtrl,
              onSubmit: handleSubmit,
              confirmPasswordVisible: _passwordConfirmVisible,
              confirmSuffixIcon: GestureDetector(
                onTap: handleOnConfirmChangePassVisible,
                child: Icon(!_passwordConfirmVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
              passwordVisible: _passwordVisible,
              suffixIcon: GestureDetector(
                onTap: handleOnChangePassVisible,
                child: Icon(!_passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            )
          ],
        ),
      ),
    );
  }
}
