import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget buildAppBar({
  required BuildContext context,
  String? title,
  Widget? leading,
  bool showBackBtn = false,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight,
    titleSpacing: 0,
    backgroundColor: ColorName.primary,
    centerTitle: true,
    leading: !showBackBtn
        ? leading ??
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            )
        : null,
    title: Text(
      title ?? AppConstant.appName,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: .3,
      ),
    ),
  );
}
