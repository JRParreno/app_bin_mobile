import 'package:app_bin_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CommonState extends Equatable implements ProfileState {
  const CommonState();
  @override
  List<Object> get props => [];
}

// initial state for all blocs
class InitialState extends CommonState {
  const InitialState();
}

// loading state for all blocs
class LoadingState extends CommonState {
  const LoadingState();
}

class ErrorState extends CommonState {
  final String error;
  const ErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class NoInternetConnectionState extends CommonState {
  const NoInternetConnectionState();
}

class ServerExceptionState extends CommonState {
  final String error;
  const ServerExceptionState(this.error);

  @override
  List<Object> get props => [error];
}

class TimeoutExceptionState extends CommonState {
  final String error;
  const TimeoutExceptionState(this.error);

  @override
  List<Object> get props => [error];
}
