part of 'shopping_cart_bloc.dart';

class ShoppingCartEvent extends Equatable {
  const ShoppingCartEvent();

  @override
  List<Object> get props => [];
}

class BuyEvent extends ShoppingCartEvent {
  String amount;
  String txRef;
  String currency;
  BuyEvent({
    required this.amount,
    required this.txRef,
    required this.currency,
  });
}