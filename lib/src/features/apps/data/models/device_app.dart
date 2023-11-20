import 'dart:convert';

import 'package:app_bin_mobile/src/features/block/data/models/block_app.dart';
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

extension DeviceAppBlock on DeviceApp {
  BlockApp toBlockApp() {
    return BlockApp(deviceApp: this);
  }
}

class DeviceApp extends Equatable {
  final int pk;
  final String deviceId;
  final String appName;
  final String packageName;
  final bool isBlock;

  const DeviceApp({
    required this.pk,
    required this.deviceId,
    required this.appName,
    required this.packageName,
    required this.isBlock,
  });

  @override
  List<Object?> get props => [
        pk,
        deviceId,
        appName,
        packageName,
        isBlock,
      ];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'deviceId': deviceId});
    result.addAll({'appName': appName});
    result.addAll({'packageName': packageName});
    result.addAll({'isBlock': isBlock});

    return result;
  }

  factory DeviceApp.fromMap(Map<String, dynamic> map) {
    return DeviceApp(
      pk: map['pk'] ?? '',
      deviceId: map['deviceId'] ?? '',
      appName: map['app_name'] ?? '',
      packageName: map['package_name'] ?? '',
      isBlock: map['is_block'] ?? false,
    );
  }

  factory DeviceApp.toDeviceApp({
    required Application app,
    required String deviceId,
  }) {
    return DeviceApp(
      pk: -1,
      deviceId: deviceId,
      appName: app.appName,
      packageName: app.packageName,
      isBlock: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceApp.fromJson(String source) =>
      DeviceApp.fromMap(json.decode(source));

  DeviceApp copyWith({
    int? pk,
    String? deviceId,
    String? appName,
    String? packageName,
    bool? isBlock,
  }) {
    return DeviceApp(
      pk: pk ?? this.pk,
      deviceId: deviceId ?? this.deviceId,
      appName: appName ?? this.appName,
      packageName: packageName ?? this.packageName,
      isBlock: isBlock ?? this.isBlock,
    );
  }
}
