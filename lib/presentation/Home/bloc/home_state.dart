part of 'home_bloc.dart';

//  class HomeState extends Equatable {
//   const HomeState();

//   @override
//   List<Object> get props => [];
// }
class HomeState {}

class HomeInitial extends HomeState {}

class CartInitiaState extends HomeState {
  List<Fruit> fruitList;
  CartInitiaState({required this.fruitList});
}

class AddedToCartState extends HomeState {}

//                  //
// //   Favorte  // //
//                  //
class FavoriteInitialState extends HomeState {}

class AddedToFavoriteState extends HomeState {}

class FetchProductsState extends HomeState {
  List<Products> products;
  FetchProductsState({required this.products});
}
