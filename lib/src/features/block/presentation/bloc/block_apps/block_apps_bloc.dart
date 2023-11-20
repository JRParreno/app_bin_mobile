import 'package:app_bin_mobile/src/core/bloc/enums/view_status.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device_app.dart';
import 'package:app_bin_mobile/src/features/apps/data/repository/device_repository.dart';
import 'package:app_bin_mobile/src/features/block/data/models/block_app.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'block_apps_event.dart';
part 'block_apps_state.dart';

class BlockAppsBloc extends Bloc<BlockAppsEvent, BlockAppsState> {
  final DeviceRepository _deviceRepository;

  BlockAppsBloc(this._deviceRepository) : super(BlockAppsInitial()) {
    on<GetBlockAppsEvent>(_getBlockApps);
  }

  Future<void> _getBlockApps(
      GetBlockAppsEvent event, Emitter<BlockAppsState> emit) async {
    emit(state.copyWith(apps: []));
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    try {
      final remoteApps =
          await _deviceRepository.getDeviceApps(event.deviceCode);
      final blockApps = remoteApps
          .map(
            (e) => e.toBlockApp(),
          )
          .toList();

      emit(state.copyWith(apps: blockApps, viewStatus: ViewStatus.successful));
    } catch (e) {
      emit(state.copyWith(
          viewStatus: ViewStatus.failed, errorMessage: e.toString()));
    }
  }
}
