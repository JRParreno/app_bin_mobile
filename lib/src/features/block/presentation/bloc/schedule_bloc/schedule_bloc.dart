import 'package:app_bin_mobile/src/core/bloc/enums/view_status.dart';
import 'package:app_bin_mobile/src/features/block/data/models/schedule.dart';
import 'package:app_bin_mobile/src/features/block/data/repository/schedule_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleBlocEvent, ScheduleBlocState> {
  final ScheduleRepository _scheduleRepository;

  ScheduleBloc(this._scheduleRepository) : super(ScheduleBlocInitial()) {
    on<GetScheduleEvent>(_getScheduleEvent);
    on<UpdateScheduleEvent>(_updateScheduleEvent);
    on<DeleteScheduleEvent>(_deleteScheduleEvent);
    on<CreateScheduleEvent>(_createScheduleEvent);
  }

  Future<void> _createScheduleEvent(
      CreateScheduleEvent event, Emitter<ScheduleBlocState> emit) async {
    try {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      final mySchedule =
          await _scheduleRepository.createSchedule(event.schedule);

      emit(state.copyWith(
          schedule: mySchedule, viewStatus: ViewStatus.successful));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), viewStatus: ViewStatus.failed));
    }
  }

  Future<void> _getScheduleEvent(
      GetScheduleEvent event, Emitter<ScheduleBlocState> emit) async {
    try {
      emit(state.copyWith(viewStatus: ViewStatus.loading));

      final mySchedule = await _scheduleRepository.getSchedule(event.devicePk);

      emit(state.copyWith(
          schedule: mySchedule, viewStatus: ViewStatus.successful));
    } catch (e) {
      final DioException error = e as DioException;
      if (error.response != null && error.response!.statusCode == 404) {
        return emit(state.copyWith(viewStatus: ViewStatus.successful));
      }
      emit(state.copyWith(
          errorMessage: e.toString(), viewStatus: ViewStatus.failed));
    }
  }

  Future<void> _updateScheduleEvent(
      UpdateScheduleEvent event, Emitter<ScheduleBlocState> emit) async {}

  Future<void> _deleteScheduleEvent(
      DeleteScheduleEvent event, Emitter<ScheduleBlocState> emit) async {
    try {
      if (state.schedule.device > 0) {
        emit(state.copyWith(viewStatus: ViewStatus.loading));

        await _scheduleRepository.deleteSchedule(state.schedule.pk.toString());

        emit(state.copyWith(
            schedule: Schedule.empty(), viewStatus: ViewStatus.successful));
      }
    } catch (e) {
      final DioException error = e as DioException;
      if (error.response != null && error.response!.statusCode == 404) {
        return emit(state.copyWith(viewStatus: ViewStatus.successful));
      }
      emit(state.copyWith(
          errorMessage: e.toString(), viewStatus: ViewStatus.failed));
    }
  }
}
