import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/presentation/BaseHomePage/basehomebloc/base_home_page_bloc.dart';
import 'package:grocery/presentation/Category/categories.dart';
import 'package:grocery/presentation/home.dart';
import 'package:grocery/presentation/shopping_cart.dart';

import '../../favorite.dart';
import '../../thank_you.dart';

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
    Category(),
    // ItemDetail(),
    const ShoppingCart(),
    const Favorite(),
    const ThankYouPage(),
  ];
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
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
              // setState(() {
              //   selectedIndex = value;
              // });
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
    );
  }
}
