import 'package:flutter/material.dart';

typedef OnRoutePushed = Function(
    String route, String previousRoute, Object args);

typedef OnRouteReplaced = Function(
    String route, String previousRoute, Object args);

typedef OnRoutePopped = Function(
    String route, String previousRoute, Object args);

class BdiRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final OnRoutePushed onRoutePushed;
  final OnRouteReplaced onRouteReplaced;
  final OnRoutePopped onRoutePopped;

  /// Enables logging to the console.
  final bool loggingEnabled;

  /// Creates a [BdiRouteObserver].
  ///
  /// Enables app-wide navigation logging for user analytics/reporting.
  ///
  /// If `onGenerateRoute` is overriden with a custom implementation,
  /// the returned [MaterialPageRoute] *must* also include the [RouteSettings]
  /// of the pushed [PageRoute].
  ///
  /// ```dart
  /// return MaterialApp(
  ///    initialRoute: '/',
  ///    navigatorObservers: [
  ///      BdiRouteObserver(
  ///        loggingEnabled: true,
  ///        onRoutePushed: (route, previousRoute, args) {
  ///         // Do something with route details
  ///        },
  ///        onRoutePopped: (route, previousRoute, args) {
  ///         // Do something with route details
  ///        },
  ///        onRouteReplaced: (route, previousRoute, args) {
  ///         // Do something with route details
  ///        },
  ///      )
  ///    ],
  ///  );
  ///
  /// ```
  BdiRouteObserver({
    this.onRoutePushed,
    this.onRouteReplaced,
    this.onRoutePopped,
    this.loggingEnabled = false,
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      onRoutePushed?.call(
        route.settings.name,
        previousRoute?.settings?.name,
        route.settings.arguments,
      );
      _logEvent(
          'Pushed ${route.settings.name}, args: ${route.settings.arguments}');
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      onRouteReplaced?.call(
        newRoute.settings.name,
        oldRoute.settings.name,
        newRoute.settings.arguments,
      );
      _logEvent(
          'Replaced ${oldRoute.settings.name} with ${newRoute.settings.name}, args: ${newRoute.settings.arguments}');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      onRoutePopped?.call(
        route.settings.name,
        previousRoute.settings.name,
        route.settings.arguments,
      );
      _logEvent('Popped ${route.settings.name}');
    }
  }

  void _logEvent(String event) {
    if (loggingEnabled) {
      print('$this $event');
    }
  }

  @override
  String toString() => '::BdiRouteObserver::';
}
