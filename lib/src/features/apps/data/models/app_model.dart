import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';

import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_apps.dart';

class AppModel extends Equatable {
  final List<Application> inactiveApps;
  final List<AppBinApps> appbinApps;

  const AppModel({
    required this.inactiveApps,
    required this.appbinApps,
  });

  factory AppModel.empty() {
    return const AppModel(inactiveApps: [], appbinApps: []);
  }

  @override
  List<Object?> get props => [inactiveApps, appbinApps];

  AppModel copyWith({
    List<Application>? inactiveApps,
    List<AppBinApps>? appbinApps,
  }) {
    return AppModel(
      inactiveApps: inactiveApps ?? this.inactiveApps,
      appbinApps: appbinApps ?? this.appbinApps,
    );
  }
}
