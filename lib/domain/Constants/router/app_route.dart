import 'package:flutter/material.dart';

import '../../../presentation/check-out/customer_info.dart';
import '../../../data/Models/home_model.dart';
import '../../../presentation/auth/view/signin.dart';
import '../../../presentation/base-home-page/view/base_home.dart';
import '../../../presentation/Category/categories.dart';
import '../../../presentation/Home/view/home.dart';
import '../../../presentation/favorite/view/favorite.dart';
import '../../../presentation/item_detail.dart';
import '../../../presentation/onboarding.dart';
import '../../../presentation/shopping_cart.dart';
import '../../../presentation/thank_you.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    Fruit? fruit;
    String? amount;

    if (routeSettings.name == ItemDetail.itemDetail) {
      fruit = routeSettings.arguments as Fruit;
    } else if (routeSettings.name == CustomerInformationForm.customerInfo) {
      amount = routeSettings.arguments as String;
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
      case CategoryPage.category:
        return MaterialPageRoute(
          builder: (_) => CategoryPage(),
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
      case CustomerInformationForm.customerInfo:
        return MaterialPageRoute(
          builder: (_) => CustomerInformationForm(
            amount: amount!,
          ),
        );
      default:
        return null;
    }
  }
}
