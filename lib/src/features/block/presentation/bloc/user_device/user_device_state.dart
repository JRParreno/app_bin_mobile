part of 'user_device_bloc.dart';

class UserDeviceState extends Equatable {
  const UserDeviceState({
    this.viewStatus = ViewStatus.none,
    required this.devices,
    this.errorMessage,
  });

  final ViewStatus viewStatus;
  final List<Device> devices;
  final String? errorMessage;

  factory UserDeviceState.empty() {
    return const UserDeviceState(devices: []);
  }

  UserDeviceState copyWith({
    ViewStatus? viewStatus,
    List<Device>? devices,
    String? errorMessage,
  }) {
    return UserDeviceState(
      viewStatus: viewStatus ?? this.viewStatus,
      devices: devices ?? this.devices,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [viewStatus, devices, errorMessage];
}

class UserDeviceInitial extends UserDeviceState {
  UserDeviceInitial() : super(devices: UserDeviceState.empty().devices);
}
