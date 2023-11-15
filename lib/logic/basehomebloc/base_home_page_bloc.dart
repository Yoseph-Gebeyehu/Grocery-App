import 'package:bloc/bloc.dart';

part 'base_home_page_event.dart';
part 'base_home_page_state.dart';

class BaseHomePageBloc extends Bloc<BaseHomePageEvent, BaseHomeState> {
  BaseHomePageBloc() : super(BaseHomeInitial()) {
    on<BaseHomePageEvent>((event, emit) {
      if (event is BHomeEvent) {
        emit(BHomeState());
      } else if (event is BCategoryEvent) {
        emit(BCategoryState());
      } else if (event is BCartEvent) {
        emit(BCartState());
      } else if (event is BFavoriteEvent) {
        emit(BFavoriteState());
      } else if (event is BProfileEvent) {
        emit(BProfileState());
      }
    });
  }
}
