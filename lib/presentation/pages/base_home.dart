import 'package:flutter/material.dart';
import 'package:grocery/presentation/pages/categories.dart';
import 'package:grocery/presentation/pages/favorite.dart';
import 'package:grocery/presentation/pages/home.dart';
import 'package:grocery/presentation/pages/shopping_cart.dart';
import 'package:grocery/presentation/pages/thank_you.dart';
// import 'package:grocery/pages/categories.dart';
// import 'package:grocery/pages/favorite.dart';
// import 'package:grocery/pages/home.dart';
// import 'package:grocery/pages/item_detail.dart';
// import 'package:grocery/pages/shopping_cart.dart';
// import 'package:grocery/pages/thank_you.dart';

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
    ShoppingCart(),
    Favorite(),
    ThankYouPage(),
  ];
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFE67F1E),
        unselectedItemColor: const Color(0xFFB1B1B1),
        iconSize: deviceSize.width * 0.08,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.home),
            // icon: IconButton(
            //   onPressed: () {
            //     setState(() {
            //       selectedIndex = 0;
            //     });
            //   },
            //   icon: const Icon(Icons.home),
            // ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.arrow_back),
            // icon: IconButton(
            //   onPressed: () {
            //     setState(() {
            //       selectedIndex = 1;
            //     });
            //   },
            //   icon: const Icon(Icons.arrow_back),
            // ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.shopping_cart),
            // icon: IconButton(
            //   onPressed: () {
            //     setState(() {
            //       selectedIndex = 2;
            //     });
            //   },
            //   icon: const Icon(Icons.shopping_cart),
            // ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.favorite),
            // icon: IconButton(
            //   onPressed: () {
            //     setState(() {
            //       selectedIndex = 3;
            //     });
            //   },
            //   icon: const Icon(Icons.favorite),
            // ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.person),
            // icon: IconButton(
            //   onPressed: () {
            //     setState(() {
            //       selectedIndex = 4;
            //     });
            //   },
            //   icon: const Icon(Icons.person),
            // ),
          ),
        ],
      ),
    );
  }
}
