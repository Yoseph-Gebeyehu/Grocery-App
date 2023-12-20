part of 'shopping_cart_bloc.dart';

class ShoppingCartEvent extends Equatable {
  const ShoppingCartEvent();

  @override
  List<Object> get props => [];
}

class BuyEvent extends ShoppingCartEvent {
  final String amount;
  final String txRef;
  final String currency;
  final String title;
  final String description;
  const BuyEvent({
    required this.amount,
    required this.txRef,
    required this.currency,
    required this.title,
    required this.description,
  });
}
