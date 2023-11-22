part of 'home_bloc.dart';

//  class HomeState extends Equatable {
//   const HomeState();

//   @override
//   List<Object> get props => [];
// }
class HomeState {}

class HomeInitial extends HomeState {}

class CartInitiaState extends HomeState {
  List<HomeModel> homeModel;
  CartInitiaState({required this.homeModel});
}

class AddedToCartState extends HomeState {
  List<HomeModel> isAddedToCart;
  AddedToCartState({required this.isAddedToCart});
}

//                  //
// //   Favorte  // //
//                  //
class FavoriteInitialState extends HomeState {
  List<HomeModel> homeModel;
  FavoriteInitialState({required this.homeModel});
}

class AddedToFavoriteState extends HomeState {
  List<HomeModel> homeModel;
  AddedToFavoriteState({required this.homeModel});
}
