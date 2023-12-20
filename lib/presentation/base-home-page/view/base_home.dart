import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user.dart';
import '../../../presentation/base-home-page/bloc/base_home_page_bloc.dart';
import '../../../presentation/Category/categories.dart';
import '../../../presentation/Home/view/home.dart';
import '../../favorite/view/favorite.dart';
import '../widget/custom_drawer.dart';
import '../../shopping-cart/view/shopping_cart.dart';
import '../../transaction-history/view/transaction_history.dart';

class BaseHomePage extends StatefulWidget {
  static const baseHomePage = 'base-home-page';

  final User user;
  const BaseHomePage({super.key, required this.user});

  @override
  State<BaseHomePage> createState() => _BaseHomePageState();
}

class _BaseHomePageState extends State<BaseHomePage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    List<String> appBarTitle = [
      'Home',
      'Categories',
      'Cart',
      'Favorites',
      'Transaction History'
    ];

    List<Widget> pages = [
      Home(user: widget.user),
      CategoryPage(),
      const ShoppingCart(),
      const Favorite(),
      TransactionHistoryPage(),
    ];
    Size deviceSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: BlocListener<BaseHomePageBloc, BaseHomeState>(
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
        child: BlocBuilder<BaseHomePageBloc, BaseHomeState>(
          builder: (context, state) {
            return Scaffold(
              drawer: Drawer(
                child: CustomDrawer(user: widget.user),
              ),
              backgroundColor: const Color(0xFFF5F5F5),
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                centerTitle: false,
                elevation: 1,
                backgroundColor: Colors.white,
                toolbarHeight: deviceSize.height * 0.08,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appBarTitle[selectedIndex],
                      style: TextStyle(
                        fontSize: deviceSize.width * 0.045,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      size: deviceSize.height * 0.03,
                    ),
                  ),
                ],
              ),
              body: pages[selectedIndex],
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.1,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
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
                      label: 'Home',
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: 'Categories',
                      icon: Icon(Icons.category),
                    ),
                    BottomNavigationBarItem(
                      label: 'Cart',
                      icon: Icon(Icons.shopping_cart),
                    ),
                    BottomNavigationBarItem(
                      label: 'Favorite',
                      icon: Icon(Icons.favorite),
                    ),
                    BottomNavigationBarItem(
                      label: 'History',
                      icon: Icon(Icons.history),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
