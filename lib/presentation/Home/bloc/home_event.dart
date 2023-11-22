part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CartInitial extends HomeEvent {}

class AddToCartEvent extends HomeEvent {
  final HomeModel homeModel;

  const AddToCartEvent({required this.homeModel});
}

// class FavoriteInitial extends HomeEvent {}

class AddToFavorite extends HomeEvent {
  final HomeModel homeModel;
  const AddToFavorite({required this.homeModel});
}
