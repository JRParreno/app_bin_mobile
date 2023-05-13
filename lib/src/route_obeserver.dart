import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyNavigatorObserver extends NavigatorObserver {
  List<Route<dynamic>> routeStack = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.add(route);
    if (kDebugMode) {
      print('ROUTE $routeStack');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
    if (kDebugMode) {
      print('ROUTE $routeStack');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
    if (kDebugMode) {
      print('ROUTE $routeStack');
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    routeStack.removeLast();
    if (newRoute != null) {
      routeStack.add(newRoute);
    }
    if (kDebugMode) {
      print('ROUTE $routeStack');
    }
  }
}
