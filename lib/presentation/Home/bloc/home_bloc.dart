import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery/data/Local/shered_preference.dart';
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
    // ---------- Cart ------------------//

    on<CartInitial>((event, emit) async {
      emit(AddedToCartState(isAddedToCart: fruitModel));
    });

    on<AddToCartEvent>((event, emit) async {
      final newValue = !event.homeModel.isAddedToCart;
      event.homeModel.isAddedToCart = newValue;
      await LocalStorage.save(event.homeModel.image, newValue);

      emit(AddedToCartState(isAddedToCart: fruitModel));
    });

    // ---------- Favorite ------------------//
    // on<FavoriteInitial>((event, emit) async {
    //   emit(AddedToFavoriteState(homeModel: fruitModel));
    // });

    on<AddToFavorite>((event, emit) async {
      final newValue = !event.homeModel.isFavorite;
      event.homeModel.isFavorite = newValue;
      await LocalStorage.save(event.homeModel.name, newValue);

      emit(AddedToFavoriteState(homeModel: fruitModel));
    });
  }
}
