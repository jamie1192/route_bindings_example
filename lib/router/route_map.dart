import 'package:bdi_route_utils/bdi_route.dart';
import 'package:flutter/material.dart';
import 'package:router_bindings/bindings/child_bindings.dart';
import 'package:router_bindings/bindings/home_page_bindings.dart';
import 'package:router_bindings/main.dart';

Widget _slide(Animation animation, Widget child) {
  var begin = Offset(0.0, 1.0);
  var end = Offset.zero;
  var curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}

Map<String, BdiRoute> routeMap = {
  '/': BdiRoute(
    routeBindings: const HomepageBindings(routeName: '/'),
    transitionBuilder: (animation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    child: MyHomePage(),
  ),
  '/child': BdiRoute(
    routeBindings: ChildBindings(routeName: '/child'),
    transitionBuilder: _slide,
    child: ChildPage(),
  )
};
