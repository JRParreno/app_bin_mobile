import 'dart:convert';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';

extension DeviceAppFormData on DeviceApp {
  dynamic formData() {
    return {
      "device_id": deviceId,
      "app_name": appName,
      "package_name": packageName,
      "is_block": isBlock,
    };
  }
}

class DeviceApp extends Equatable {
  final String deviceId;
  final String appName;
  final String packageName;
  final bool isBlock;

  const DeviceApp({
    required this.deviceId,
    required this.appName,
    required this.packageName,
    required this.isBlock,
  });

  @override
  List<Object?> get props => [
        deviceId,
        appName,
        packageName,
        isBlock,
      ];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'deviceId': deviceId});
    result.addAll({'appName': appName});
    result.addAll({'packageName': packageName});
    result.addAll({'isBlock': isBlock});

    return result;
  }

  factory DeviceApp.fromMap(Map<String, dynamic> map) {
    return DeviceApp(
      deviceId: map['deviceId'] ?? '',
      appName: map['appName'] ?? '',
      packageName: map['packageName'] ?? '',
      isBlock: map['isBlock'] ?? false,
    );
  }

  factory DeviceApp.toDeviceApp({
    required Application app,
    required String deviceId,
  }) {
    return DeviceApp(
      deviceId: deviceId,
      appName: app.appName,
      packageName: app.packageName,
      isBlock: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceApp.fromJson(String source) =>
      DeviceApp.fromMap(json.decode(source));
}
