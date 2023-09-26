part of 'view_all_user_device_bloc.dart';

class ViewAllUserDeviceState extends Equatable {
  const ViewAllUserDeviceState();

  @override
  List<Object> get props => [];
}

class ViewAllUserDeviceLoaded extends ViewAllUserDeviceState {
  final List<Device> devices;

  const ViewAllUserDeviceLoaded(this.devices);

  @override
  List<Object> get props => [devices];
}
