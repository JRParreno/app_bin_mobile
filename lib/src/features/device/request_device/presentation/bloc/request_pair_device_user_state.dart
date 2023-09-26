part of 'request_pair_device_user_bloc.dart';

class RequestPairDeviceUserState extends Equatable {
  const RequestPairDeviceUserState();

  @override
  List<Object> get props => [];
}

class RequestPairDeviceUserLoaded extends RequestPairDeviceUserState {
  final List<PairDevice> pairDevies;
  final bool isUpdating;

  const RequestPairDeviceUserLoaded({
    required this.pairDevies,
    this.isUpdating = false,
  });

  RequestPairDeviceUserLoaded copyWith({
    List<PairDevice>? pairDevies,
  }) {
    return RequestPairDeviceUserLoaded(
      pairDevies: pairDevies ?? this.pairDevies,
    );
  }

  @override
  List<Object> get props => [
        pairDevies,
        isUpdating,
      ];
}
