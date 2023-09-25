part of 'pair_device_user_bloc.dart';

class PairDeviceUserState extends Equatable {
  const PairDeviceUserState();

  @override
  List<Object> get props => [];
}

class PairDeviceUserLoaded extends PairDeviceUserState {
  final List<PairDevice> pairDevies;

  const PairDeviceUserLoaded(this.pairDevies);

  PairDeviceUserLoaded copyWith({
    List<PairDevice>? pairDevies,
  }) {
    return PairDeviceUserLoaded(
      pairDevies ?? this.pairDevies,
    );
  }

  @override
  List<Object> get props => [pairDevies];
}
