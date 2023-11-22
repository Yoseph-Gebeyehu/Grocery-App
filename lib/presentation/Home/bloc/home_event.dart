part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CartInitial extends HomeEvent {}

class AddToCartEvent extends HomeEvent {
  final Fruit fruit;

  const AddToCartEvent({required this.fruit});
}

// class FavoriteInitial extends HomeEvent {}

class AddToFavorite extends HomeEvent {
  final Fruit fruit;
  const AddToFavorite({required this.fruit});
}
