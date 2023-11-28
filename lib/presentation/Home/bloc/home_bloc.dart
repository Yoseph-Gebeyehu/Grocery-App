import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery/data/models/products.dart';
import 'package:grocery/data/repositories/remote-request/api_client.dart';
import 'package:grocery/data/repositories/remote-request/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final newValue = !event.products.isAddedToCart;
      event.products.isAddedToCart = newValue;
      await LocalStorage.save(event.products.image!, newValue);

      emit(AddedToCartState());
    });

    on<AddToFavorite>((event, emit) async {
      final newValue = !event.products.isFavorite;
      event.products.isFavorite = newValue;
      await LocalStorage.save(event.products.title!, newValue);

      emit(AddedToFavoriteState());
    });

    on<FetchProductsEvent>((event, emit) async {
      ApiClient apiClient = ApiClient();
      List<Products> products = await apiClient.getProduct();

      final prefs = await SharedPreferences.getInstance();
      products.forEach((element) async {
        element.isFavorite = prefs.getBool(element.title!) ?? false;
        element.isAddedToCart = prefs.getBool(element.image!) ?? false;
      });
      emit(FetchProductsState(products: products));
    });
  }
}
