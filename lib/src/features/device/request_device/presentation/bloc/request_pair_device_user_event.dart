part of 'request_pair_device_user_bloc.dart';

class RequestPairDeviceUserEvent extends Equatable {
  const RequestPairDeviceUserEvent();

  @override
  List<Object> get props => [];
}

class FetchRequestPairDeviceEvent extends RequestPairDeviceUserEvent {}

class UpdatePairDeviceEvent extends RequestPairDeviceUserEvent {
  final int index;
  final bool isAccept;

  const UpdatePairDeviceEvent({
    required this.index,
    required this.isAccept,
  });

  @override
  List<Object> get props => [
        index,
        isAccept,
      ];
}
