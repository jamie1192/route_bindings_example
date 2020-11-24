import 'package:bdi_route_utils/bdi_route_generator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:router_bindings/model_example.dart';
import 'package:router_bindings/router/bdi_route_observer.dart';
import 'package:router_bindings/router/route_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: BdiRouteGenerator(
        routeMap: routeMap,
        unknownRouteWidget: UnknownRoutePage(),
      ).generateBdiRoute,
      navigatorObservers: [
        BdiRouteObserver(
          loggingEnabled: true,
          onRoutePushed: (route, previousRoute, args) {},
        )
      ],
      title: 'Bindings Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(GetIt.I.get<SomeModel>().data),
            RaisedButton(
              child: Text('Child route'),
              onPressed: () => Navigator.of(context).pushNamed('/child'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChildPage extends StatelessWidget {
  const ChildPage({Key key}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Home model: ${GetIt.I<SomeModel>().data}'),
            Text('Child model: ${GetIt.I<ChildModel>().data}'),
          ],
        ),
      ),
    );
  }
}

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("You dun' goofed."),
      ),
    );
  }
}
