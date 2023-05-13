import 'package:app_bin_mobile/gen/assets.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = '/on-boarding';
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  void handleGetStarted() {
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.images.appbin.image(),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomText(
                          text: "Welcome to App Bin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomText(
                          text: "Your Application Management Usage",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    child: CustomBtn(
                      onTap: handleGetStarted,
                      label: "Get Started",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
