import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery/data/Models/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/Constants/Images/home_images2.dart';
import '../../../domain/Constants/names/category_fruit_names.dart';
import '../../../domain/Constants/names/home_fruit_names.dart';
// import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<HomeModel> fruitModel = List.generate(
    HomeImages2.images.length,
    (index) => HomeModel(
      image: HomeImages2.images[index],
      name: HomeFruitNames.fruitNames[index],
      amout: index * 1.78,
      category: CategoryFruitNames.fruitName[index],
    ),
  );
  HomeBloc() : super(HomeInitial()) {
    on<CartInitial>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      fruitModel.forEach((element) {
        element.isAddedToCart = prefs.getBool(element.image) ?? false;
      });
      emit(AddedToCartState(isAddedToCart: fruitModel));
    });

    on<AddToCartEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final newValue = !event.homeModel.isAddedToCart;
      event.homeModel.isAddedToCart = newValue;
      await prefs.setBool(event.homeModel.image, newValue);

      fruitModel.forEach((element) {
        element.isAddedToCart = prefs.getBool(element.image) ?? false;
      });

      emit(AddedToCartState(isAddedToCart: fruitModel));
    });

    // on<HomeEvent>((event, emit) {
    //   if (event is AddToCartEvent) {
    //     for (int i = 0; i < event.isAddedToCart.length; i++) {
    //       if (event.isAddedToCart[i]) {
    //         emit(AddedToCartState()..isAddedToCart.add(event.isAddedToCart[i]));
    //       } else {
    //         emit(NotAddedToCartState());
    //       }
    //       ;
    //     }
    //   }
    // });
  }
}
