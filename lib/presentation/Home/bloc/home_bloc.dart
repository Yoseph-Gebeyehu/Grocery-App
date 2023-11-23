import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/Local/shered_preference.dart';
import '../../../data/Models/home_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
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
