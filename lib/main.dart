import 'package:flutter/material.dart';
import 'package:grocery/new.dart';

import 'domain/Constants/router/app_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRoute _appRoute = AppRoute();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _appRoute.onGenerateRoute,
    );
  }
}
