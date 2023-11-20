import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/Constants/Images/home_images2.dart';
import '../../domain/Constants/names/category_fruit_names.dart';
import '../../domain/Constants/names/home_fruit_names.dart';
import '../Models/home_model.dart';

class LocalStorage {
//   setFavorite(String fruitName, bool isFav) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.setBool(fruitName, isFav);
//   }

//   Future<bool?> getFavorite(String fruitName) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     return sharedPreferences.getBool(fruitName);
//   }

  // List<HomeModel> fruitModel = List.generate(
  //   HomeImages2.images.length,
  //   (index) => HomeModel(
  //     image: HomeImages2.images[index],
  //     name: HomeFruitNames.fruitNames[index],
  //     amout: '\$${(index * 1.78).toString()}',
  //     category: CategoryFruitNames.fruitName[index],
  //     // addToCart: 'Add to cart',
  //   ),
  // );

  init() {
    loadFavorite(fruitModel);
    loadCartItems(fruitModel);
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

  Future<void> loadFavorite(List<HomeModel> fruitModel) async {
    final prefs = await SharedPreferences.getInstance();
    fruitModel.forEach((element) {
      element.isFavorite = prefs.getBool(element.name) ?? false;
    });
  }

  Future<void> loadCartItems(List<HomeModel> fruitModel) async {
    final prefs = await SharedPreferences.getInstance();
    fruitModel.forEach((element) {
      element.isAddedToCart = prefs.getBool(element.image) ?? false;
    });
  }

  Future<void> toggleFavorite(HomeModel homeModel) async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !homeModel.isFavorite;
    homeModel.isFavorite = newValue;
    await prefs.setBool(homeModel.name, newValue);
  }

  Future<void> addToCart(HomeModel homeModel) async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !homeModel.isAddedToCart;
    homeModel.isAddedToCart = newValue;
    await prefs.setBool(homeModel.image, newValue);
  }
}
