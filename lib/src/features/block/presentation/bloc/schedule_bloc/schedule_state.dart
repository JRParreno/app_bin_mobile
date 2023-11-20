part of 'schedule_bloc.dart';

class ScheduleBlocState extends Equatable {
  const ScheduleBlocState({
    required this.schedule,
    this.viewStatus = ViewStatus.none,
    this.errorMessage = '',
  });

  final ViewStatus viewStatus;
  final Schedule schedule;
  final String errorMessage;

  ScheduleBlocState copyWith({
    ViewStatus? viewStatus,
    Schedule? schedule,
    String? errorMessage,
  }) {
    return ScheduleBlocState(
      viewStatus: viewStatus ?? this.viewStatus,
      schedule: schedule ?? this.schedule,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [schedule, viewStatus, errorMessage];
}

class ScheduleBlocInitial extends ScheduleBlocState {
  ScheduleBlocInitial() : super(schedule: Schedule.empty());
}
