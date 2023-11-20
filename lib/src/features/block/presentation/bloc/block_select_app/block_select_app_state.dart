part of 'block_select_app_bloc.dart';

class BlockSelectAppState extends Equatable {
  const BlockSelectAppState({
    this.viewStatus = ViewStatus.none,
    required this.apps,
    this.errorMessage,
    this.searchText = '',
  });

  final String searchText;
  final ViewStatus viewStatus;
  final List<BlockApp> apps;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        viewStatus,
        apps,
        errorMessage,
        searchText,
      ];

  BlockSelectAppState copyWith({
    String? searchText,
    ViewStatus? viewStatus,
    List<BlockApp>? apps,
    String? errorMessage,
  }) {
    return BlockSelectAppState(
      searchText: searchText ?? this.searchText,
      viewStatus: viewStatus ?? this.viewStatus,
      apps: apps ?? this.apps,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class BlockSelectAppInitial extends BlockSelectAppState {
  BlockSelectAppInitial() : super(apps: []);
}
