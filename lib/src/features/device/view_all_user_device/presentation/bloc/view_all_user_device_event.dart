part of 'view_all_user_device_bloc.dart';

class ViewAllUserDeviceEvent extends Equatable {
  const ViewAllUserDeviceEvent();

  @override
  List<Object> get props => [];
}

class FetchAllUserDeviceEvent extends ViewAllUserDeviceEvent {
  final String pk;

  const FetchAllUserDeviceEvent(this.pk);

  @override
  List<Object> get props => [pk];
}
