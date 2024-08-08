import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequest>((event, emit) async {
      try {
        emit(AuthLoading());
        final username = event.username;
        final password = event.password;

        if (password.length < 6) {
          return emit(
              AuthFailure(error: 'Password must be at least 6 characters'));
        }
        await Future.delayed(const Duration(seconds: 2), () {
          return emit(AuthSuccess());
        });
      } catch (e) {
        return emit(AuthFailure(error: e.toString()));
      }
    });

    on<AuthSignUpRequest>(
      (event, emit) async {
        try {
          emit(AuthLoading());
          final username = event.username;
          final email = event.email;

          final password = event.password;

          if (password.length < 6) {
            return emit(
                AuthFailure(error: 'Password must be at least 6 characters'));
          }
          await Future.delayed(const Duration(seconds: 2), () {
            return emit(AuthSuccess());
          });
        } catch (e) {
          return emit(AuthFailure(error: e.toString()));
        }
      },
    );
  }
}
