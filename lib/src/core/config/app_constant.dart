import 'package:flutter/material.dart';

class AppConstant {
  static const kMockupHeight = 812;
  static const kMockupWidth = 375;
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
  static const clientId = 'BXNiP6rk3IQ60YL3Mny7R9pdiVV5SLasrna2k3BP';
  static const clientSecret =
      'wovayzriCTydBIF1oBMAjxxQRg8LisOi8xTuLEXnU3czncvPw667jWAZhjd5hvIGOfCrTzBc6bKqGJifR1gbHPiLnsK8uWTLnIsIbO8q60j1aGTnRfcK3Z0tUSwHI8IP';
  static const serverUrl = 'http://192.168.1.12:8000';
  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
  static const appName = 'App Bin';
  static const schedule = 'schedule';
}
