part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}


class AuthLoginRequest extends AuthEvent{
  final String username;

  final String password;

  AuthLoginRequest({required this.username, required this.password});
}
