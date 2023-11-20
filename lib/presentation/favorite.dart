import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/Models/home_model.dart';
import '../domain/Constants/Images/home_images2.dart';
import '../domain/Constants/names/category_fruit_names.dart';
import '../domain/Constants/names/home_fruit_names.dart';
import '../presentation/item_detail.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);
  static const favorite = 'favorite';
  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    super.initState();
    loadFavorites();
    laodCartItems();
  }

  List<HomeModel> fruitModel = List.generate(
    HomeImages2.images.length,
    (index) => HomeModel(
      image: HomeImages2.images[index],
      name: HomeFruitNames.fruitNames[index],
      // amout: '\$${(index * 1.78).toString()}',
      amout: index * 1.78,
      category: CategoryFruitNames.fruitName[index],
    ),
  );
  List<HomeModel> favortieFruits = [];
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fruitModel.forEach((fruit) {
        fruit.isFavorite = prefs.getBool(fruit.name) ?? false;
      });
      for (int i = 0; i < fruitModel.length; i++) {
        if (fruitModel[i].isFavorite == true) {
          favortieFruits.add(fruitModel[i]);
        }
      }
    });
  }

  Future<void> laodCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fruitModel.forEach((element) {
        element.isAddedToCart = prefs.getBool(element.image) ?? false;
      });
    });
  }

  Future<void> toogleFavorite(HomeModel homeModel) async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !homeModel.isFavorite;
    setState(() {
      homeModel.isFavorite = newValue;
    });
    await prefs.setBool(homeModel.name, newValue);
  }

  Future<void> addToCart(HomeModel homeModel) async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !homeModel.isAddedToCart;
    setState(() {
      homeModel.isAddedToCart = newValue;
    });
    await prefs.setBool(homeModel.image, newValue);
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: deviceSize.height * 0.08,
        backgroundColor: const Color(0xFFFFFFFF),
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: deviceSize.width * 0.1),
          child: const Text(
            'Favorite\'s',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: favortieFruits.isEmpty
          ? const Center(
              child: Text('There is no favorite fruits!'),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                var fruits = favortieFruits[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceSize.width * 0.08,
                    vertical: deviceSize.height * 0.015,
                  ),
                  child: SizedBox(
                    height: deviceSize.height * 0.15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ItemDetail.itemDetail,
                              arguments: favortieFruits[index],
                            );
                          },
                          child: SizedBox(
                            child: Image.asset(
                              favortieFruits[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceSize.width * 0.05,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      favortieFruits[index].name,
                                      style: TextStyle(
                                        fontSize: deviceSize.width * 0.05,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () async {
                                        await toogleFavorite(fruits);
                                        setState(() {
                                          favortieFruits.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Color(0xFFFF2E6C),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    favortieFruits[index].amout.toString(),
                                    style: TextStyle(
                                      fontSize: deviceSize.width * 0.05,
                                      color: const Color(0xFFE67F1E),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      favortieFruits[index].isAddedToCart
                                          ? null
                                          : await addToCart(fruits);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color:
                                            favortieFruits[index].isAddedToCart
                                                ? const Color(0xFFEFEFEF)
                                                : const Color(0xFFFEC54B),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              favortieFruits[index]
                                                      .isAddedToCart
                                                  ? 'Added to cart'
                                                  : 'Add to cart',
                                              style: TextStyle(
                                                fontSize:
                                                    deviceSize.width * 0.03,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: favortieFruits.length,
            ),
    );
  }
}
