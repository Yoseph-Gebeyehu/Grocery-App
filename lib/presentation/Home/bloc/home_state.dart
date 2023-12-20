part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

// ******* Cart ****************//
class CartInitiaState extends HomeState {
  final List<Fruit> fruitList;
  const CartInitiaState({required this.fruitList});
}

class AddedToCartState extends HomeState {}

// ******* Favorite ****************//

class FavoriteInitialState extends HomeState {}

class AddedToFavoriteState extends HomeState {}

// ******* Fetch Products ****************//

class FetchProductsState extends HomeState {
  final List<Products> products;
  const FetchProductsState({required this.products});
}

// ******* Api Error ****************//

class ApiErrorState extends HomeState {}

// ******* Network Error ****************//

class NetworkErrorState extends HomeState {}
