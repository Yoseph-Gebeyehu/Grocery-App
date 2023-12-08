import 'package:bloc/bloc.dart';

import '../../../data/models/user.dart';
import '../../../data/service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      List<User> userList = await UserServies.getUserFromDB();

      if (event is LoginEvent &&
          event.email.isNotEmpty &&
          event.password.isNotEmpty) {
        try {
          User matchedUser = userList.firstWhere((user) =>
              event.email == user.email && event.password == user.password);

          emit(AuthLoadingState());
          await Future.delayed(const Duration(seconds: 2));
          emit(AuthLoadedState(userName: matchedUser.userName!));
        } catch (e) {
          emit(AuthErrorState());
        }
      } else {
        emit(AuthErrorState());
      }
    });
  }
}
