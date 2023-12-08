import 'package:flutter/material.dart';
import 'package:grocery/data/models/user.dart';

import '/presentation/auth/view/signup.dart';
import '/presentation/auth/view/signin.dart';
import '/presentation/base-home-page/view/base_home.dart';
import '/presentation/Category/categories.dart';
import '/presentation/Home/view/home.dart';
import '/presentation/favorite/view/favorite.dart';
import '/presentation/item-detail/item_detail.dart';
import '/presentation/splash.dart';
import '/presentation/shopping-cart/view/shopping_cart.dart';
import '/presentation/transaction-history/view/transaction_history.dart';
import '/data/models/products.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    Products? products;
    User? user;

    if (routeSettings.name == ItemDetail.itemDetail) {
      products = routeSettings.arguments as Products;
    }
    if (routeSettings.name == BaseHomePage.baseHomePage) {
      user = routeSettings.arguments as User;
    }
    if (routeSettings.name == Home.home) {
      user = routeSettings.arguments as User;
    }
    switch (routeSettings.name) {
      case SplashScreen.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case BaseHomePage.baseHomePage:
        return MaterialPageRoute(builder: (_) => BaseHomePage(user: user!));
      case CategoryPage.category:
        return MaterialPageRoute(builder: (_) => CategoryPage());
      case Favorite.favorite:
        return MaterialPageRoute(builder: (_) => const Favorite());
      case Home.home:
        return MaterialPageRoute(builder: (_) => Home(user: user!));
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
