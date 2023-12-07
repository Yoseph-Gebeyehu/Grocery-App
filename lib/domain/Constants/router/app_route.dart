import 'package:flutter/material.dart';
import 'package:grocery/data/models/products.dart';
import 'package:grocery/presentation/auth/view/signup.dart';

import '../../../presentation/auth/view/signin.dart';
import '../../../presentation/base-home-page/view/base_home.dart';
import '../../../presentation/Category/categories.dart';
import '../../../presentation/Home/view/home.dart';
import '../../../presentation/favorite/view/favorite.dart';
import '../../../presentation/item-detail/item_detail.dart';
import '../../../presentation/splash.dart';
import '../../../presentation/shopping-cart/view/shopping_cart.dart';
import '../../../presentation/transaction-history/view/transaction_history.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    Products? products;

    if (routeSettings.name == ItemDetail.itemDetail) {
      products = routeSettings.arguments as Products;
    }
    switch (routeSettings.name) {
      case SplashScreen.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case BaseHomePage.baseHomePage:
        return MaterialPageRoute(builder: (_) => const BaseHomePage());
      case CategoryPage.category:
        return MaterialPageRoute(builder: (_) => CategoryPage());
      case Favorite.favorite:
        return MaterialPageRoute(builder: (_) => const Favorite());
      case Home.home:
        return MaterialPageRoute(builder: (_) => Home());
      case ItemDetail.itemDetail:
        return MaterialPageRoute(
          builder: (_) => ItemDetail(products: products!),
        );
      case ShoppingCart.shoppingCart:
        return MaterialPageRoute(builder: (_) => const ShoppingCart());
      case SigninPage.signIn:
        return MaterialPageRoute(builder: (_) => const SigninPage());
      case SignUpPage.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case TransactionHistoryPage.txnHistory:
        return MaterialPageRoute(builder: (_) => TransactionHistoryPage());
      default:
        return null;
    }
  }
}
