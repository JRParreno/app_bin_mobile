// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromptBlockArgs {
  final ApplicationWithIcon app;

  PromptBlockArgs({
    required this.app,
  });
}

class PromptBlockScreen extends StatefulWidget {
  static const String routeName = 'prompt-block-screen';
  final PromptBlockArgs args;

  const PromptBlockScreen({super.key, required this.args});

  @override
  State<PromptBlockScreen> createState() => _PromptBlockScreenState();
}

class _PromptBlockScreenState extends State<PromptBlockScreen> {
  @override
  Widget build(BuildContext context) {
    final app = widget.args.app;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.memory(
                app.icon,
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: 20,
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: app.appName,
                      style: TextStyle(
                        color: ColorName.error,
                        fontSize: 25.sp,
                      ),
                    ),
                    CustomText(
                      text: " is Blocked",
                      style: TextStyle(fontSize: 25.sp, color: Colors.white),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomText(
                text: "by Quick Block",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              const SizedBox(
                height: 100,
              ),
              const CustomText(
                text: "Time is precious, make every moment count!",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.highlight_off,
                      size: 33.0,
                      color: ColorName.error,
                    ),
                    label: const CustomText(
                      text: "Close",
                      style: TextStyle(fontSize: 20),
                    ), // <-- Text
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
