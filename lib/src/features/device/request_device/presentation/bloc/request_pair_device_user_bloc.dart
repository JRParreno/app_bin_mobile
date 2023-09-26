import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/features/device/request_device/data/repository/request_device_repository_impl.dart';
import 'package:app_bin_mobile/src/features/device/view_device/data/models/pair_device.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'request_pair_device_user_event.dart';
part 'request_pair_device_user_state.dart';

class RequestPairDeviceUserBloc
    extends Bloc<RequestPairDeviceUserEvent, RequestPairDeviceUserState> {
  final RequestDeviceRepositoryImpl _requestDeviceRepositoryImpl;

  RequestPairDeviceUserBloc(this._requestDeviceRepositoryImpl)
      : super(const InitialState()) {
    on<FetchRequestPairDeviceEvent>(_fetchRequestPairDeviceEvent);
    on<UpdatePairDeviceEvent>(_updatePairDeviceEvent);
  }

  Future<void> _fetchRequestPairDeviceEvent(FetchRequestPairDeviceEvent event,
      Emitter<RequestPairDeviceUserState> emit) async {
    emit(const LoadingState());

    final results = await _requestDeviceRepositoryImpl.getRequestPairDevices();

    if (results.isNotEmpty) {
      return emit(RequestPairDeviceUserLoaded(pairDevies: results));
    }

    return emit(const EmptyState());
  }

  Future<void> _updatePairDeviceEvent(UpdatePairDeviceEvent event,
      Emitter<RequestPairDeviceUserState> emit) async {
    final state = this.state;

    if (state is RequestPairDeviceUserLoaded) {
      emit(RequestPairDeviceUserLoaded(
        pairDevies: state.pairDevies,
        isUpdating: true,
      ));

      final pairDevices = [...state.pairDevies];
      final device = pairDevices[event.index];

      final updatedDevice = await RequestDeviceRepositoryImpl()
          .updateRequestPairDevices(
              isAccept: event.isAccept, pk: device.pk.toString());

      pairDevices[event.index] = updatedDevice;

      return emit(RequestPairDeviceUserLoaded(pairDevies: [...pairDevices]));
    }
  }
}
