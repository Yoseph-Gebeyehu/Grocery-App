import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/shopping-cart/bloc/shopping_cart_bloc.dart';
import 'presentation/Auth/bloc/auth_bloc.dart';
import 'presentation/base-home-page/bloc/base_home_page_bloc.dart';
import 'presentation/Home/bloc/home_bloc.dart';
import 'presentation/transaction-history/bloc/transaction_history_bloc.dart';
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
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => BaseHomePageBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ShoppingCartBloc(),
        ),
        BlocProvider(
          create: (context) => TransactionHistoryBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRoute.onGenerateRoute,
      ),
    );
  }
}
