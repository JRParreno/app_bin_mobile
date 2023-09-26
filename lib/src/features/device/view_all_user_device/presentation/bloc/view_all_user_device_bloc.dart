import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:app_bin_mobile/src/features/device/view_all_user_device/data/repository/view_all_user_device_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'view_all_user_device_event.dart';
part 'view_all_user_device_state.dart';

class ViewAllUserDeviceBloc
    extends Bloc<ViewAllUserDeviceEvent, ViewAllUserDeviceState> {
  final ViewAllUserDeviceRepositoryImpl _viewAllUserDeviceRepositoryImpl;

  ViewAllUserDeviceBloc(this._viewAllUserDeviceRepositoryImpl)
      : super(const InitialState()) {
    on<FetchAllUserDeviceEvent>(_fetchAllUserDevice);
  }

  Future<void> _fetchAllUserDevice(FetchAllUserDeviceEvent event,
      Emitter<ViewAllUserDeviceState> emit) async {
    emit(const LoadingState());

    final results =
        await _viewAllUserDeviceRepositoryImpl.fetchUserAllDevice(event.pk);

    if (results.isNotEmpty) {
      return emit(ViewAllUserDeviceLoaded(results));
    }

    return emit(const EmptyState());
  }
}
