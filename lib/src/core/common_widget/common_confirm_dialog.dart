import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class CommonConfirmDialog {
  static void showDialog({
    required BuildContext context,
    required String content,
    required VoidCallback onTapYes,
    String? title,
    VoidCallback? onTapClose,
  }) async {
    NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: CustomText(text: title ?? AppConstant.appName),
      content: CustomText(text: content),
      actions: <Widget>[
        TextButton(onPressed: onTapYes, child: const CustomText(text: "Yes")),
        TextButton(
          onPressed: onTapClose ?? () => Navigator.pop(context),
          child: const CustomText(text: "Close"),
        ),
      ],
    ).show(context);
  }
}
