import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/base-home-page/bloc/base_home_page_bloc.dart';
import '../../../presentation/Category/categories.dart';
import '../../../presentation/Home/view/home.dart';
import '../../favorite/view/favorite.dart';
import '../../shopping-cart/view/shopping_cart.dart';
import '../../transaction-history/view/transaction_history.dart';

class BaseHomePage extends StatefulWidget {
  const BaseHomePage({Key? key}) : super(key: key);
  static const baseHomePage = 'base-home-page';
  @override
  State<BaseHomePage> createState() => _BaseHomePageState();
}

class _BaseHomePageState extends State<BaseHomePage> {
  int selectedIndex = 0;
  List<Widget> pages = [
    Home(),
    CategoryPage(),
    const ShoppingCart(),
    const Favorite(),
    TransactionHistoryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: BlocConsumer<BaseHomePageBloc, BaseHomeState>(
          listener: (context, state) {
            if (state is BHomeState) {
              selectedIndex = 0;
            } else if (state is BCategoryState) {
              selectedIndex = 1;
            } else if (state is BCartState) {
              selectedIndex = 2;
            } else if (state is BFavoriteState) {
              selectedIndex = 3;
            } else if (state is BProfileState) {
              selectedIndex = 4;
            }
          },
          builder: (context, state) {
            return pages[selectedIndex];
          },
        ),
        bottomNavigationBar: BlocConsumer<BaseHomePageBloc, BaseHomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return BottomNavigationBar(
              selectedItemColor: const Color(0xFFE67F1E),
              unselectedItemColor: const Color(0xFFB1B1B1),
              iconSize: deviceSize.width * 0.08,
              currentIndex: selectedIndex,
              onTap: (value) {
                if (value == 0) {
                  context.read<BaseHomePageBloc>().add(BHomeEvent());
                } else if (value == 1) {
                  context.read<BaseHomePageBloc>().add(BCategoryEvent());
                } else if (value == 2) {
                  context.read<BaseHomePageBloc>().add(BCartEvent());
                } else if (value == 3) {
                  context.read<BaseHomePageBloc>().add(BFavoriteEvent());
                } else if (value == 4) {
                  context.read<BaseHomePageBloc>().add(BProfileEvent());
                }
              },
              items: const [
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.arrow_back),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.shopping_cart),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.person),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
