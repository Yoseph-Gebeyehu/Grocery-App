import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/logic/auth_bloc/auth_bloc.dart';
// import 'package:grocery/logic/bloc/auth_bloc.dart';
// import 'package:grocery/bloc/cubit/counter_cubit.dart';
import 'package:grocery/presentation/pages/base_home.dart';
import 'package:grocery/presentation/pages/categories.dart';
import 'package:grocery/presentation/pages/favorite.dart';
import 'package:grocery/presentation/pages/home.dart';
import 'package:grocery/presentation/pages/item_detail.dart';
import 'package:grocery/presentation/pages/onboarding.dart';
import 'package:grocery/presentation/pages/shopping_cart.dart';
import 'package:grocery/presentation/pages/signin.dart';
import 'package:grocery/presentation/pages/thank_you.dart';

class AppRoute {
  AuthBloc authBloc = AuthBloc();
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case BaseHomePage.baseHomePage:
        return MaterialPageRoute(
          builder: (_) => const BaseHomePage(),
        );
      case Category.category:
        return MaterialPageRoute(
          builder: (_) => Category(),
        );
      case Favorite.favorite:
        return MaterialPageRoute(
          builder: (_) => const Favorite(),
        );
      case Home.home:
        return MaterialPageRoute(
          builder: (_) => Home(),
        );
      case ItemDetail.itemDetail:
        return MaterialPageRoute(
          builder: (_) => ItemDetail(),
        );
      case ShoppingCart.shoppingCart:
        return MaterialPageRoute(
          builder: (_) => const ShoppingCart(),
        );
      case SigninPage.signIn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authBloc,
            child: const SigninPage(),
          ),
        );
      case ThankYouPage.thankyou:
        return MaterialPageRoute(
          builder: (_) => const ThankYouPage(),
        );
      default:
        return null;
    }
  }
}
