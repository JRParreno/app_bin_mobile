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

  AppsLoadEvent copyWith({
    List<Application>? applications,
  }) {
    return AppsLoadEvent(
      applications: applications ?? this.applications,
    );
  }

  @override
  String toString() => 'AppsLoadEvent(applications: $applications)';

  @override
  List<Object?> get props => [applications];
}

class AppsWhiteListEvent extends AppsEvent {
  final List<Application> applications;

  const AppsWhiteListEvent({
    required this.applications,
  });

  AppsWhiteListEvent copyWith({
    List<Application>? applications,
  }) {
    return AppsWhiteListEvent(
      applications: applications ?? this.applications,
    );
  }

  @override
  String toString() => 'AppsWhiteListEvent(applications: $applications)';

  @override
  List<Object?> get props => [applications];
}

class AppsSearchEvent extends AppsEvent {
  final String query;

  const AppsSearchEvent({
    required this.query,
  });

  AppsSearchEvent copyWith({
    String? query,
  }) {
    return AppsSearchEvent(
      query: query ?? this.query,
    );
  }

  @override
  String toString() => 'AppsSearchEvent(applications: $query)';

  @override
  List<Object?> get props => [query];
}

class AppsLoadInitEvent extends AppsEvent {
  final List<String> whiteList;

  const AppsLoadInitEvent({
    required this.whiteList,
  });

  AppsLoadInitEvent copyWith({
    List<String>? whiteList,
  }) {
    return AppsLoadInitEvent(
      whiteList: whiteList ?? this.whiteList,
    );
  }

  @override
  String toString() => 'AppsLoadInitEvent(applications: $whiteList)';

  @override
  List<Object?> get props => [whiteList];
}
