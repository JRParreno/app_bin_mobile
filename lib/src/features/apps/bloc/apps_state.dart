part of 'apps_bloc.dart';

abstract class AppsState extends Equatable {
  const AppsState();

  @override
  List<Object?> get props => [];
}

class AppsLoaded extends AppsState {
  final List<AppBinApps> applications;
  final String? query;
  final Schedule? schedule;

  const AppsLoaded({
    required this.applications,
    this.query,
    this.schedule,
  });

  AppsLoaded copyWith({
    List<AppBinApps>? applications,
    String? query,
    Schedule? schedule,
  }) {
    return AppsLoaded(
      applications: applications ?? this.applications,
      query: query ?? this.query,
      schedule: schedule ?? this.schedule,
    );
  }

  @override
  String toString() => 'AppsLoaded(applications: $applications)';

  @override
  List<Object?> get props => [
        applications,
        query,
        schedule,
      ];
}

class NoAppsState extends AppsState {}
