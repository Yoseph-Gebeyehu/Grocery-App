part of 'shopping_cart_bloc.dart';

class ShoppingCartState extends Equatable {
  const ShoppingCartState();

  @override
  List<Object> get props => [];
}

class ShoppingCartInitial extends ShoppingCartState {}

class BuySuccessState extends ShoppingCartState {
  final String checkoutUrl;
  const BuySuccessState({required this.checkoutUrl});
}

class BuyErrorState extends ShoppingCartState {}
