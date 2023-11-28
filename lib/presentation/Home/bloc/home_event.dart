part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CartInitial extends HomeEvent {}

// class AddToCartEvent extends HomeEvent {
//   final Fruit fruit;

//   const AddToCartEvent({required this.fruit});
// }
class AddToCartEvent extends HomeEvent {
  final Products products;

  const AddToCartEvent({required this.products});
}

// class AddToFavorite extends HomeEvent {
//   final Fruit fruit;
//   const AddToFavorite({required this.fruit});
// }
class AddToFavorite extends HomeEvent {
  final Products products;
  const AddToFavorite({required this.products});
}

class FetchProductsEvent extends HomeEvent {}
