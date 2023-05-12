import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_apps.dart';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'apps_event.dart';
part 'apps_state.dart';

class AppsBloc extends Bloc<AppsEvent, AppsState> {
  AppsBloc() : super(const AppsLoaded(applications: [])) {
    on<AppsLoadEvent>(_appsLoadEvent);
    on<AppsWhiteListEvent>(_appsWhiteListEvent);
    on<AppsSearchEvent>(_appsSearchEvent);
    on<AppsLoadInitEvent>(_appsLoadInitEvent);
  }

  void _appsLoadInitEvent(
      AppsLoadInitEvent event, Emitter<AppsState> emit) async {
    final tempList = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
    );

    final sortTempList = Helper.filterApps(
      tempList
        ..sort(
          (a, b) {
            return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
          },
        ),
    );

    if (event.whiteList.isNotEmpty) {
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
        ),
      );
    }
  }

  void _appsSearchEvent(AppsSearchEvent event, Emitter<AppsState> emit) {
    final state = this.state;

    if (state is AppsLoaded) {
      return emit(
        AppsLoaded(
          applications: state.applications,
          query: event.query,
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
            applications: event.applications),
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
}
