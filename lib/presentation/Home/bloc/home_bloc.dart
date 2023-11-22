import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery/data/Local/shered_preference.dart';
import 'package:grocery/data/Models/home_model.dart';

import '../../../domain/Constants/Images/home_images2.dart';
import '../../../domain/Constants/names/category_fruit_names.dart';
import '../../../domain/Constants/names/home_fruit_names.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Fruit> fruitList = List.generate(
    HomeImages2.images.length,
    (index) => Fruit(
      image: HomeImages2.images[index],
      name: HomeFruitNames.fruitNames[index],
      amout: index * 1.78,
      category: CategoryNames.fruitName[index],
    ),
  );
  HomeBloc() : super(HomeInitial()) {
    on<CartInitial>((event, emit) async {
      emit(AddedToCartState());
    });

    on<AddToCartEvent>((event, emit) async {
      final newValue = !event.fruit.isAddedToCart;
      event.fruit.isAddedToCart = newValue;
      await LocalStorage.save(event.fruit.image, newValue);

      emit(AddedToCartState());
    });

    on<AddToFavorite>((event, emit) async {
      final newValue = !event.fruit.isFavorite;
      event.fruit.isFavorite = newValue;
      await LocalStorage.save(event.fruit.name, newValue);

      emit(AddedToFavoriteState());
    });
  }
}
