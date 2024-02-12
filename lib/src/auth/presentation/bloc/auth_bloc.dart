import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dashboard_bloc_tdd/core/enums/update_user.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/entities/user.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/usecases/forgot_password.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/usecases/sign_in.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/usecases/sign_up.dart';
import 'package:dashboard_bloc_tdd/src/auth/domain/usecases/update_user.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required ForgotPassword forgotPassword,
    required UpdateUser updateUser,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final ForgotPassword _forgotPassword;
  final UpdateUser _updateUser;

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _signUpHandler(
      SignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUp(
      SignUpParams(
        email: event.email,
        fullName: event.name,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(const SignedUp()),
    );
  }
}
