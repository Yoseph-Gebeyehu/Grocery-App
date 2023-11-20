import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // on<HomeEvent>((event, emit) {
    //   if (event is AddToCartEvent) {
    //     for (int i = 0; i < event.isAddedToCart.length; i++) {
    //       if (event.isAddedToCart[i]) {
    //         emit(AddedToCartState().isAddedToCart.add(event.isAddedToCart[i]));
    //       } else {
    //         emit(NotAddedToCartState());
    //       }
    //     }
    //   }
    // });
    on<HomeEvent>((event, emit) {
      if (event is AddToCartEvent) {
        for (int i = 0; i < event.isAddedToCart.length; i++) {
          if (event.isAddedToCart[i]) {
            emit(AddedToCartState()..isAddedToCart.add(event.isAddedToCart[i]));
          } else {
            emit(NotAddedToCartState());
          }
          ;
        }
      }
    });
  }
}
