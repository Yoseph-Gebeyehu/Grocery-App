part of 'home_bloc.dart';

// class HomeEvent extends Equatable {
//   const HomeEvent();

//   @override
//   List<Object> get props => [];
// }
class HomeEvent {}

class AddToCartEvent extends HomeEvent {
  List<bool> isAddedToCart;
  AddToCartEvent({required this.isAddedToCart});
}
