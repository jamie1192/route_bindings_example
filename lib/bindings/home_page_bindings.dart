import 'package:bdi_route_utils/bdi_route_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../model_example.dart';

class HomepageBindings extends BdiRouteBindings {
  const HomepageBindings({@required String routeName})
      : super(routeName: routeName);

  @override
  void inject() {
    GetIt.I.registerSingleton<SomeModel>(SomeModel(data: 'Data string'));
  }

  @override
  Future<void> dispose() async {
    print('Disposed of scope for $routeName');
    GetIt.I.unregister<SomeModel>();
  }
}
