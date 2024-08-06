part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLoginRequest extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequest({required this.email, required this.password});
}
