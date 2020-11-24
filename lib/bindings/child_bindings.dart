import 'package:bdi_route_utils/bdi_route_bindings.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:router_bindings/model_example.dart';

class ChildBindings extends BdiRouteBindings {
  const ChildBindings({@required String routeName})
      : super(routeName: routeName);

  @override
  void inject() {
    print('Injecting dependencies for scopeName: $routeName');
    GetIt.I
        .registerSingleton<ChildModel>(ChildModel(data: 'Child Data string'));
  }

  @override
  Future<void> dispose() async {
    print('Disposing bindings for $routeName');
    GetIt.I.unregister<ChildModel>();
  }
}
