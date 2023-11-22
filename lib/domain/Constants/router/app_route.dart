import 'package:flutter/material.dart';

import '../../../presentation/check-out/customer_info.dart';
import '../../../data/Models/home_model.dart';
import '../../../presentation/Auth/View/signin.dart';
import '../../../presentation/base-home-page/View/base_home.dart';
import '../../../presentation/Category/categories.dart';
import '../../../presentation/favorite.dart';
import '../../../presentation/Home/view/home.dart';
import '../../../presentation/item_detail.dart';
import '../../../presentation/onboarding.dart';
import '../../../presentation/shopping_cart.dart';
import '../../../presentation/thank_you.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    Fruit? fruit;
    String title;
    String amount;
    String description;

    if (routeSettings.name == ItemDetail.itemDetail) {
      fruit = routeSettings.arguments as Fruit;
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
        return MaterialPageRoute(builder: (_) => CustomerInformationForm());
      default:
        return null;
    }
  }
}
