import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData mediaQueryData = const MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double defaultSize = 0;
  static double devicePixelRatio = 0;
  static double devicePixelWidth = 0;
  static double smallScreenSize = 750;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    devicePixelRatio = mediaQueryData.devicePixelRatio;
    devicePixelWidth = screenWidth * devicePixelRatio;
  }

  static double get textScaleFactor {
    return SizeConfig.screenWidth / AppConstant.kMockupWidth;
  }

// Get the proportionate height as per screen size
  static double getProportionateScreenHeight(double inputHeight) {
    final screenHeight = SizeConfig.screenHeight;
    // 812 is the layout height that designer use
    return (inputHeight / AppConstant.kMockupHeight) * screenHeight;
  }

// Get the proportionate height as per screen size
  static double getProportionateScreenWidth(double inputWidth) {
    final screenWidth = SizeConfig.screenWidth;
    // 375 is the layout width that designer use
    return (inputWidth / AppConstant.kMockupWidth) * screenWidth;
  }

  static bool isSmallScreen() {
    return devicePixelWidth <= smallScreenSize;
  }
}
