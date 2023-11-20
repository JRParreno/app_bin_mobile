import 'package:app_bin_mobile/src/core/bloc/enums/view_status.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:app_bin_mobile/src/features/device/view_all_user_device/data/repository/view_all_user_device_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_device_event.dart';
part 'user_device_state.dart';

class UserDeviceBloc extends Bloc<UserDeviceEvent, UserDeviceState> {
  final ViewAllUserDeviceRepository _viewAllUserDeviceRepository;

  UserDeviceBloc(this._viewAllUserDeviceRepository)
      : super(UserDeviceInitial()) {
    on<GetUserDeviceEvent>(_getUserDeviceEvent);
  }

  Future<void> _getUserDeviceEvent(
      GetUserDeviceEvent event, Emitter<UserDeviceState> emit) async {
    try {
      if (state.viewStatus == ViewStatus.none) {
        emit(state.copyWith(viewStatus: ViewStatus.loading));
      }

      final currentDevice = await _viewAllUserDeviceRepository.getDeviceInfo();

      if (currentDevice == null) {
        return emit(
          state.copyWith(
            errorMessage: "Error retreiving device info.",
            viewStatus: ViewStatus.failed,
          ),
        );
      }

      final devices =
          await _viewAllUserDeviceRepository.fetchFilterUserAllDevice(
              pk: event.pk, deviceCode: currentDevice.deviceCode);

      emit(state.copyWith(viewStatus: ViewStatus.successful, devices: devices));
    } catch (e) {
      state.copyWith(errorMessage: e.toString(), viewStatus: ViewStatus.failed);
    }
  }
}
