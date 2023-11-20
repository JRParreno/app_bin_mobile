import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_apps.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_model.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device_app.dart';
import 'package:app_bin_mobile/src/features/apps/data/repository/device_repository.dart';
import 'package:app_bin_mobile/src/features/block/data/models/schedule.dart';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'apps_event.dart';
part 'apps_state.dart';

class AppsBloc extends Bloc<AppsEvent, AppsState> {
  final DeviceRepository _deviceRepository;
  AppsBloc(this._deviceRepository) : super(const AppsLoaded(applications: [])) {
    on<AppsLoadEvent>(_appsLoadEvent);
    on<AppsWhiteListEvent>(_appsWhiteListEvent);
    on<AppsSearchEvent>(_appsSearchEvent);
    on<AppsLoadInitEvent>(_appsLoadInitEvent);
    on<AppsScheduleEvent>(_appsScheduleEvent);
    on<AppsDeleteScheduleEvent>(_appsDeleteScheduleEvent);
  }

  void _appsLoadInitEvent(
      AppsLoadInitEvent event, Emitter<AppsState> emit) async {
    final tempList = await Helper.getListOfApps();
    final state = this.state;

    final deviceInfo = await _deviceRepository.getDeviceInfo();

    if (deviceInfo != null) {
      final remoteApps =
          await _deviceRepository.getDeviceApps(deviceInfo.deviceCode);

      if (remoteApps.isNotEmpty) {
        final filteredApps =
            getFilteredApps(currentApps: tempList, remoteApps: remoteApps);
        return emit(
          AppsLoaded(
            applications: filteredApps.appbinApps,
            schedule: state is AppsLoaded ? state.schedule : null,
          ),
        );
      } else {
        final sortTempList = tempList
          ..sort(
            (a, b) {
              return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
            },
          );

        final tempAppBinsApps = convertAppToAppBinsApps(
          appBinApps: [],
          applications: sortTempList,
        );

        final appBinApps = tempAppBinsApps.map(
          (e) {
            final appExists = event.whiteList
                .where((element) => e.application.packageName == element)
                .toList();
            return AppBinApps(
              application: e.application,
              isBlock: appExists.isNotEmpty,
            );
          },
        ).toList();

        return emit(
          AppsLoaded(
            applications: appBinApps,
            schedule: state is AppsLoaded ? state.schedule : null,
          ),
        );
      }
    }
  }

  void _appsSearchEvent(AppsSearchEvent event, Emitter<AppsState> emit) {
    final state = this.state;

    if (state is AppsLoaded) {
      return emit(
        AppsLoaded(
          applications: state.applications,
          query: event.query,
          schedule: state.schedule,
        ),
      );
    }
  }

  void _appsLoadEvent(AppsLoadEvent event, Emitter<AppsState> emit) {
    final state = this.state;

    return emit(
      AppsLoaded(
        applications: convertAppToAppBinsApps(
          appBinApps: state is AppsLoaded ? state.applications : [],
          applications: event.applications,
        ),
        schedule: state is AppsLoaded ? state.schedule : null,
      ),
    );
  }

  void _appsWhiteListEvent(AppsWhiteListEvent event, Emitter<AppsState> emit) {
    List<AppBinApps> appBin = [];
    final state = this.state;

    if (state is AppsLoaded) {
      appBin = state.applications.map((AppBinApps stateApps) {
        final appWhiteList = event.applications
            .where((Application element) =>
                stateApps.application.packageName == element.packageName)
            .toList();

        return stateApps.copyWith(
          application: stateApps.application,
          isBlock: appWhiteList.isNotEmpty,
        );
      }).toList();
    }
    return emit(
      AppsLoaded(
        applications: appBin,
        schedule: state is AppsLoaded ? state.schedule : null,
      ),
    );
  }

  List<AppBinApps> convertAppToAppBinsApps({
    required List<AppBinApps> appBinApps,
    required List<Application> applications,
    bool isBlock = false,
  }) {
    if (appBinApps.isNotEmpty) {
      return appBinApps.map((AppBinApps stateApps) {
        final appWhiteList = applications
            .where((Application element) =>
                stateApps.application.packageName == element.packageName &&
                stateApps.isBlock)
            .toList();
        if (appWhiteList.isNotEmpty) {
          return stateApps.copyWith(
            application: stateApps.application,
            isBlock: true,
          );
        }
        return stateApps;
      }).toList();
    }

    return applications.map((e) {
      return AppBinApps(application: e, isBlock: isBlock);
    }).toList();
  }

  void _appsScheduleEvent(AppsScheduleEvent event, Emitter<AppsState> emit) {
    final state = this.state;

    if (state is AppsLoaded) {
      emit(AppsLoaded(
        applications: [...state.applications],
        query: state.query,
        schedule: event.schedule,
      ));
    }
  }

  void _appsDeleteScheduleEvent(
      AppsDeleteScheduleEvent event, Emitter<AppsState> emit) {
    final state = this.state;

    if (state is AppsLoaded) {
      emit(AppsLoaded(
        applications: [...state.applications],
        query: state.query,
        schedule: null,
      ));
    }
  }

  AppModel getFilteredApps({
    required List<Application> currentApps,
    required List<DeviceApp> remoteApps,
  }) {
    List<Application> inactiveApps = [];
    List<AppBinApps> appBinApps = [];

    // filter current and remote apps
    for (int i = 0; i < currentApps.length; i++) {
      final tempCurrentApp = currentApps[i];
      bool isActive = false;

      for (int j = 0; j < remoteApps.length; j++) {
        final tempRemoteApp = remoteApps[j];

        isActive = tempCurrentApp.packageName == tempRemoteApp.packageName;

        if (isActive) {
          appBinApps.add(
            AppBinApps(
                application: tempCurrentApp, isBlock: tempRemoteApp.isBlock),
          );
          break;
        }
      }

      if (!isActive) {
        inactiveApps.add(tempCurrentApp);
      }
    }

    // inactive apps will be deleted or hide from showing in the mobile app

    return AppModel(
      inactiveApps: inactiveApps,
      appbinApps: appBinApps,
    );
  }
}
