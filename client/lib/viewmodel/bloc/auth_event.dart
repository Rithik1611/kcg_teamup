part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLoginRequest extends AuthEvent {
  final String email;

  final String password;

  AuthLoginRequest({required this.email, required this.password});
}

class AuthSignUpRequest extends AuthEvent {
  final String username;
  final String email;

  final String password;

  AuthSignUpRequest(
      {required this.username, required this.password, required this.email});
}
