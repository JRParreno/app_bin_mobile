part of 'apps_bloc.dart';

abstract class AppsEvent extends Equatable {
  const AppsEvent();

  @override
  List<Object?> get props => [];
}

class AppsLoadEvent extends AppsEvent {
  final List<Application> applications;

  const AppsLoadEvent({
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
