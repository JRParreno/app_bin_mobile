part of 'user_device_bloc.dart';

class UserDeviceEvent extends Equatable {
  const UserDeviceEvent();

  @override
  List<Object> get props => [];
}

class GetUserDeviceEvent extends UserDeviceEvent {
  final String pk;

  const GetUserDeviceEvent(this.pk);

  @override
  List<Object> get props => [
        pk,
      ];
}
