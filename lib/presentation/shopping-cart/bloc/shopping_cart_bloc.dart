import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery/data/local/shered_preference.dart';

import '../../../data/Models/home_model.dart';
// import '../../../domain/Constants/Images/home_images2.dart';
// import '../../../domain/Constants/names/category_fruit_names.dart';
// import '../../../domain/Constants/names/home_fruit_names.dart';

part 'shopping_cart_event.dart';
part 'shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(ShoppingCartInitial()) {
    on<PlaceOrderEvent>((event, emit) async {});
  }
}
