part of 'schedule_bloc.dart';

class ScheduleBlocEvent extends Equatable {
  const ScheduleBlocEvent();

  @override
  List<Object> get props => [];
}

class CreateScheduleEvent extends ScheduleBlocEvent {
  final Schedule schedule;

  const CreateScheduleEvent(this.schedule);

  @override
  List<Object> get props => [schedule];
}

class GetScheduleEvent extends ScheduleBlocEvent {
  final String devicePk;
  const GetScheduleEvent(this.devicePk);

  @override
  List<Object> get props => [devicePk];
}

class UpdateScheduleEvent extends ScheduleBlocEvent {
  final Schedule schedule;

  const UpdateScheduleEvent(
    this.schedule,
  );

  @override
  List<Object> get props => [schedule];
}

class DeleteScheduleEvent extends ScheduleBlocEvent {}
