part of 'block_apps_bloc.dart';

class BlockAppsState extends Equatable {
  const BlockAppsState({
    this.viewStatus = ViewStatus.none,
    required this.apps,
    this.errorMessage,
  });

  final ViewStatus viewStatus;
  final List<BlockApp> apps;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        viewStatus,
        apps,
        errorMessage,
      ];

  BlockAppsState copyWith({
    ViewStatus? viewStatus,
    List<BlockApp>? apps,
    String? errorMessage,
  }) {
    return BlockAppsState(
      viewStatus: viewStatus ?? this.viewStatus,
      apps: apps ?? this.apps,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class BlockAppsInitial extends BlockAppsState {
  BlockAppsInitial() : super(apps: []);
}
