// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';

class AppBinApps extends Equatable {
  final Application application;
  final bool isBlock;

  const AppBinApps({
    required this.application,
    this.isBlock = false,
  });

  AppBinApps copyWith({
    Application? application,
    bool? isBlock,
  }) {
    return AppBinApps(
      application: application ?? this.application,
      isBlock: isBlock ?? this.isBlock,
    );
  }

  @override
  List<Object?> get props => [
        application,
        isBlock,
      ];
}
