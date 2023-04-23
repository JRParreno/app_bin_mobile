import 'package:app_bin_mobile/gen/assets.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_text.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.svg.appBinLogo.svg(),
              const CustomText(text: "Welcome tp App Bin"),
              const CustomText(text: "Your Application Management Usage"),
            ],
          ),
        ),
      ),
    );
  }
}
