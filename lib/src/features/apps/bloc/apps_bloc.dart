import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'apps_event.dart';
part 'apps_state.dart';

class AppsBloc extends Bloc<AppsEvent, AppsState> {
  AppsBloc() : super(const InitialState()) {
    on<AppsLoadEvent>(_appsLoadEvent);
  }

  void _appsLoadEvent(AppsLoadEvent event, Emitter<AppsState> emit) {
    return emit(AppsLoaded(applications: event.applications));
  }
}
