part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CartInitial extends HomeEvent {}

class AddToCartEvent extends HomeEvent {
  final HomeModel homeModel;
  final int index;
  AddToCartEvent({required this.homeModel, required this.index});
}
