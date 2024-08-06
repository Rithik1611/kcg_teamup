import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequest>((event, emit) async {
      try {
        emit(AuthLoading());
        final email = event.email;
        final password = event.password;

        if (password.length < 6) {
          return emit(AuthFailure(error: "password is invalid"));
        }

        await Future.delayed(const Duration(seconds: 1), () {
          return emit(AuthSuccess(uid: "$email-$password"));
        });
      } catch (e) {
        return emit(AuthFailure(error: e.toString()));
      }
    });
  }
}
