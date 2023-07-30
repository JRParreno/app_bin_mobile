import 'dart:async';
import 'dart:developer' as developer;

import 'package:app_bin_mobile/src/features/app_bin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    WidgetsFlutterBinding.ensureInitialized();
    runApp(const AppBin());
  }, (exception, stackTrace) async {
    developer.log("Something went wrong!",
        error: exception, stackTrace: stackTrace);
  });
}
