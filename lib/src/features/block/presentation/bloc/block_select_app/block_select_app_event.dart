part of 'block_select_app_bloc.dart';

class BlockSelectAppEvent extends Equatable {
  const BlockSelectAppEvent();

  @override
  List<Object> get props => [];
}

class SetBlockAppsEvent extends BlockSelectAppEvent {
  final List<BlockApp> apps;
  const SetBlockAppsEvent({
    required this.apps,
  });

  @override
  List<Object> get props => [apps];
}

class OnChageBlockAppsEvent extends BlockSelectAppEvent {
  final int index;

  const OnChageBlockAppsEvent(this.index);

  @override
  List<Object> get props => [index];
}

class OnSearchTextEvent extends BlockSelectAppEvent {
  final String query;

  const OnSearchTextEvent(this.query);

  @override
  List<Object> get props => [query];
}
