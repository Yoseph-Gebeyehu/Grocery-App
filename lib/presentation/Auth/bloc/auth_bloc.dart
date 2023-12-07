import 'package:bloc/bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        if (event.username.isNotEmpty && event.password.isNotEmpty) {
          emit(AuthLoadingState());
          await Future.delayed(const Duration(seconds: 2), () {
            emit(AuthLoadedState());
          });
        } else {
          emit(AuthErrorState());
        }
      }
    });
  }
}
