part of 'block_apps_bloc.dart';

class BlockAppsEvent extends Equatable {
  const BlockAppsEvent();

  @override
  List<Object> get props => [];
}

class GetBlockAppsEvent extends BlockAppsEvent {
  final String deviceCode;

  const GetBlockAppsEvent(this.deviceCode);
}
