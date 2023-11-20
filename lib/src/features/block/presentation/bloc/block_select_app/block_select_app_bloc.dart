import 'package:app_bin_mobile/src/core/bloc/enums/view_status.dart';
import 'package:app_bin_mobile/src/features/block/data/models/block_app.dart';
import 'package:app_bin_mobile/src/features/block/data/repository/block_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'block_select_app_event.dart';
part 'block_select_app_state.dart';

class BlockSelectAppBloc
    extends Bloc<BlockSelectAppEvent, BlockSelectAppState> {
  final BlockRepository _blockRepository;

  BlockSelectAppBloc(this._blockRepository) : super(BlockSelectAppInitial()) {
    on<SetBlockAppsEvent>(_setBlockAppsEvent);
    on<OnChageBlockAppsEvent>(_onChageBlockAppsEvent);
    on<OnSearchTextEvent>(_onSearchTextEvent);
  }

  void _setBlockAppsEvent(
      SetBlockAppsEvent event, Emitter<BlockSelectAppState> emit) {
    try {
      emit(state.copyWith(apps: event.apps, viewStatus: ViewStatus.successful));
    } catch (e) {
      emit(state.copyWith(
          viewStatus: ViewStatus.failed, errorMessage: e.toString()));
    }
  }

  void _onSearchTextEvent(
      OnSearchTextEvent event, Emitter<BlockSelectAppState> emit) {
    try {
      emit(state.copyWith(searchText: event.query));
    } catch (e) {
      emit(state.copyWith(
          viewStatus: ViewStatus.failed, errorMessage: e.toString()));
    }
  }

  Future<void> _onChageBlockAppsEvent(
      OnChageBlockAppsEvent event, Emitter<BlockSelectAppState> emit) async {
    try {
      final tempLoadApps = [...state.apps];

      tempLoadApps[event.index] = state.apps[event.index].copyWith(
        viewStatus: ViewStatus.loading,
      );
      emit(BlockSelectAppState(apps: tempLoadApps));

      final tempApps = [...state.apps];

      final blockApp = BlockApp(
          deviceApp: tempLoadApps[event.index]
              .deviceApp
              .copyWith(isBlock: !tempLoadApps[event.index].deviceApp.isBlock),
          viewStatus: ViewStatus.successful);

      await _blockRepository.updateDeviceApp(
          pk: blockApp.deviceApp.pk, isBlock: blockApp.deviceApp.isBlock);

      tempApps[event.index] = blockApp;

      emit(BlockSelectAppState(apps: tempApps));
    } catch (e) {
      emit(state.copyWith(
          viewStatus: ViewStatus.failed, errorMessage: e.toString()));
    }
  }
}
