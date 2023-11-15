import 'package:flutter/material.dart';
// import 'package:grocery/pages/base_home.dart';

// import 'package:grocery/pages/onboarding.dart';

// import 'bloc/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grocery/logic/counter_cubit.dart';
// import 'package:grocery/presentation/pages/_test.dart';
// import 'package:grocery/bloc/cubit/counter_cubit.dart';
import 'package:grocery/presentation/pages/onboarding.dart';
// import 'package:grocery/presentation/route/app_route.dart';
import 'package:grocery/presentation/router/app_route.dart';

// import 'logic/bloc/signin_bloc.dart';

// import 'bloc/page.dart';
// import 'bloc/page/page.dart';

// import 'Bloc/pages/page.dart';
// import 'bloc/app.dart';
// import 'bloc/counter_observer.dart';

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
// void main() {
//   Bloc.observer = SimpleBlocObserver();
//   CounterCubit()
//     ..increment()
//     ..close();
//   StringCubit()
//     ..concatenate()
//     ..close();
//   ListCubit()
//     ..addToList()
//     ..close();
// }
// void main() {
//   runApp(MyApp());
// }
