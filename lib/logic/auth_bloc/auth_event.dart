part of 'auth_bloc.dart';

class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  LoginEvent({
    required this.username,
    required this.password,
  });
}
