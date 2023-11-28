import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/products.dart';
import '../../../data/repositories/remote-request/api_client.dart';
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
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        emit(NetworkErrorState());
      }
      ApiClient apiClient = ApiClient();
      var apiResponse = await apiClient.getProduct();

      List<Products> products = [];
      try {
        if (apiResponse.status == 200) {
          for (var productData in apiResponse.body) {
            Products product = Products.fromJson(productData);
            products.add(product);
          }
          final prefs = await SharedPreferences.getInstance();
          products.forEach((element) async {
            element.isFavorite = prefs.getBool(element.title!) ?? false;
            element.isAddedToCart = prefs.getBool(element.image!) ?? false;
          });
          emit(FetchProductsState(products: products));
        } else if (apiResponse.status == 404 || apiResponse.status == 502) {
          emit(ApiErrorState());
        }
      } catch (e) {}
    });
  }
}
