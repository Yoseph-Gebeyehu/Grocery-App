import 'package:flutter/material.dart';

import '../../../data/Models/home_model.dart';
import '../../../presentation/Auth/View/signin.dart';
import '../../../presentation/BaseHomePage/View/base_home.dart';
import '../../../presentation/Category/categories.dart';
import '../../../presentation/favorite.dart';
import '../../../presentation/Home/view/home.dart';
import '../../../presentation/item_detail.dart';
import '../../../presentation/onboarding.dart';
import '../../../presentation/shopping_cart.dart';
import '../../../presentation/thank_you.dart';

class AppRoute {
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
          builder: (_) => ItemDetail(
            fruit: fruit!,
          ),
        );
      case ShoppingCart.shoppingCart:
        return MaterialPageRoute(
          builder: (_) => const ShoppingCart(),
        );
      case SigninPage.signIn:
        return MaterialPageRoute(
          builder: (_) => const SigninPage(),
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
