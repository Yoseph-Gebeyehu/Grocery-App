part of 'shopping_cart_bloc.dart';

class ShoppingCartEvent extends Equatable {
  const ShoppingCartEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrderEvent extends ShoppingCartEvent {
  Fruit fruit;
  PlaceOrderEvent({required this.fruit});
}
