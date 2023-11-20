import 'package:equatable/equatable.dart';

import 'package:app_bin_mobile/src/core/bloc/enums/view_status.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device_app.dart';

class BlockApp extends Equatable {
  final DeviceApp deviceApp;
  final ViewStatus viewStatus;

  const BlockApp({
    required this.deviceApp,
    this.viewStatus = ViewStatus.none,
  });

  @override
  List<Object?> get props => [deviceApp, viewStatus];

  BlockApp copyWith({
    DeviceApp? deviceApp,
    ViewStatus? viewStatus,
  }) {
    return BlockApp(
      deviceApp: deviceApp ?? this.deviceApp,
      viewStatus: viewStatus ?? this.viewStatus,
    );
  }
}
