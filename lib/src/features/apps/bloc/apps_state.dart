part of 'apps_bloc.dart';

abstract class AppsState extends Equatable {
  const AppsState();

  @override
  List<Object?> get props => [];
}

class AppsLoaded extends AppsState {
  final List<AppBinApps> applications;
  final String? query;

  const AppsLoaded({
    required this.applications,
    this.query,
  });

  AppsLoaded copyWith({
    List<AppBinApps>? applications,
    String? query,
  }) {
    return AppsLoaded(
      applications: applications ?? this.applications,
      query: query ?? this.query,
    );
  }

  @override
  String toString() => 'AppsLoaded(applications: $applications)';

  @override
  List<Object?> get props => [applications, query];
}

class NoAppsState extends AppsState {}
