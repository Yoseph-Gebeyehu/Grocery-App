import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/new.dart';
import 'package:grocery/presentation/Auth/bloc/auth_bloc.dart';
import 'package:grocery/presentation/BaseHomePage/bloc/base_home_page_bloc.dart';
// import 'package:grocery/presentation/CheckOut/provider.dart';
import 'package:grocery/presentation/Home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

import 'domain/Constants/router/app_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRoute _appRoute = AppRoute();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: HomeBloc()),
        BlocProvider.value(value: BaseHomePageBloc()),
        BlocProvider.value(value: AuthBloc()),
        // BlocProvider.value(value: ChapaProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRoute.onGenerateRoute,
      ),
    );
  }
}
