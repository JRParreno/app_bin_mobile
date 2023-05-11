part of 'apps_bloc.dart';

abstract class AppsState extends Equatable {
  const AppsState();

  @override
  List<Object?> get props => [];
}

class AppsLoaded extends AppsState {
  final List<Application> applications;

  const AppsLoaded({
    required this.applications,
  });

  AppsLoaded copyWith({
    List<Application>? applications,
  }) {
    return AppsLoaded(
      applications: applications ?? this.applications,
    );
  }

  @override
  String toString() => 'AppsLoaded(applications: $applications)';

  @override
  List<Object?> get props => [applications];
}

class NoAppsState extends AppsState {}
