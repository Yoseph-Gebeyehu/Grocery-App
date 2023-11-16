import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/data/Models/home_model.dart';
import 'package:grocery/presentation/Auth/View/signin.dart';
import 'package:grocery/presentation/Auth/auth_bloc/auth_bloc.dart';
import 'package:grocery/presentation/BaseHomePage/View/base_home.dart';
import 'package:grocery/presentation/BaseHomePage/basehomebloc/base_home_page_bloc.dart';
import 'package:grocery/presentation/Category/categories.dart';
import 'package:grocery/presentation/favorite.dart';
import 'package:grocery/presentation/home.dart';
import 'package:grocery/presentation/item_detail.dart';
import 'package:grocery/presentation/onboarding.dart';
import 'package:grocery/presentation/shopping_cart.dart';

import '../../../presentation/thank_you.dart';

class AppRoute {
  AuthBloc authBloc = AuthBloc();
  BaseHomePageBloc baseHomePageBloc = BaseHomePageBloc();
  Route? onGenerateRoute(RouteSettings routeSettings) {
    HomeModel? fruit;

    if (routeSettings.name == ItemDetail.itemDetail) {
      fruit = routeSettings.arguments as HomeModel;
    }
    switch (routeSettings.name) {
      case SplashScreen.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case BaseHomePage.baseHomePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: baseHomePageBloc,
            child: const BaseHomePage(),
          ),
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
          builder: (_) => ItemDetail(
            friut: fruit!,
          ),
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
