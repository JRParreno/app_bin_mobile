import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/features/device/view_device/data/models/pair_device.dart';
import 'package:app_bin_mobile/src/features/device/view_device/data/repository/view_device_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pair_device_user_event.dart';
part 'pair_device_user_state.dart';

class PairDeviceUserBloc
    extends Bloc<PairDeviceUserEvent, PairDeviceUserState> {
  final ViewDeviceRepository _viewDeviceRepository;

  PairDeviceUserBloc(this._viewDeviceRepository) : super(const InitialState()) {
    on<FetchPairDeviceEvent>(_fetchPairDeviceEvent);
  }

  Future<void> _fetchPairDeviceEvent(
      FetchPairDeviceEvent event, Emitter<PairDeviceUserState> emit) async {
    final results = await _viewDeviceRepository.getPairDevices();

    return emit(PairDeviceUserLoaded(results));
  }
}
