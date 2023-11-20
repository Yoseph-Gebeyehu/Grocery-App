part of 'home_bloc.dart';

//  class HomeState extends Equatable {
//   const HomeState();

//   @override
//   List<Object> get props => [];
// }
class HomeState {}

class HomeInitial extends HomeState {}

class AddedToCartState extends HomeState {
  List<bool> isAddedToCart = [];
}

class NotAddedToCartState extends HomeState {}
