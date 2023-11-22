import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../presentation/Home/bloc/home_bloc.dart';
import '../../../data/Models/home_model.dart';
import '../../../domain/Constants/Images/home_images2.dart';
import '../../../domain/Constants/names/category_fruit_names.dart';
import '../../../domain/Constants/names/home_fruit_names.dart';
import '../../item_detail.dart';

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
    loadFavoriteFruits();
  }

  List<Fruit> fruitList = List.generate(
    HomeImages2.images.length,
    (index) => Fruit(
      image: HomeImages2.images[index],
      name: HomeFruitNames.fruitNames[index],
      amout: index.toDouble(),
      category: CategoryNames.fruitName[index],
    ),
  );
  List<Fruit> favortieFruits = [];
  Future<void> loadFavoriteFruits() async {
    favortieFruits = [];
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fruitList.forEach((fruit) {
        fruit.isFavorite = prefs.getBool(fruit.name) ?? false;
      });
      for (int i = 0; i < fruitList.length; i++) {
        if (fruitList[i].isFavorite == true) {
          favortieFruits.add(fruitList[i]);
        }
      }
      favortieFruits.forEach((element) {
        element.isAddedToCart = prefs.getBool(element.image) ?? false;
      });
    });
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
          : BlocListener<HomeBloc, HomeState>(
              listener: (context, state) async {
                if (state is AddedToFavoriteState) {
                  await loadFavoriteFruits();
                } else if (state is AddedToCartState) {
                  await loadFavoriteFruits();
                }
              },
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return ListView.builder(
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
                                onTap: () async {
                                  var pageResponse = await Navigator.pushNamed(
                                    context,
                                    ItemDetail.itemDetail,
                                    arguments: fruits,
                                  );
                                  if (pageResponse is bool) {
                                    await loadFavoriteFruits();
                                  } else {
                                    await loadFavoriteFruits();
                                  }
                                },
                                child: SizedBox(
                                  child: Image.asset(
                                    fruits.image,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            fruits.name,
                                            style: TextStyle(
                                              fontSize: deviceSize.width * 0.05,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () async {
                                              BlocProvider.of<HomeBloc>(context)
                                                  .add(
                                                AddToFavorite(
                                                  fruit: fruits,
                                                ),
                                              );
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
                                          fruits.amout.toString(),
                                          style: TextStyle(
                                            fontSize: deviceSize.width * 0.05,
                                            color: const Color(0xFFE67F1E),
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            fruits.isAddedToCart
                                                ? null
                                                : context.read<HomeBloc>().add(
                                                      AddToCartEvent(
                                                        fruit: fruits,
                                                      ),
                                                    );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: fruits.isAddedToCart
                                                  ? const Color(0xFFEFEFEF)
                                                  : const Color(0xFFFEC54B),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    fruits.isAddedToCart
                                                        ? 'Added to cart'
                                                        : 'Add to cart',
                                                    style: TextStyle(
                                                      fontSize:
                                                          deviceSize.width *
                                                              0.03,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                  );
                },
              ),
            ),
    );
  }
}
