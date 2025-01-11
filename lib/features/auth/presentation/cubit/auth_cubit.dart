import 'package:bloc/bloc.dart';
import 'package:sparring/features/auth/domain/usecases/register_usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/check_login_status_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/logout_usecase.dart';

part 'auth_state.dart';

/// Cubit for managing authentication logic
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckLoginStatusUseCase checkLoginStatusUseCase;

  AuthCubit(
      {required this.loginUseCase,
      required this.registerUseCase,
      required this.logoutUseCase,
      required this.checkLoginStatusUseCase})
      : super(AuthInitial());

  // Check if the user is already logged in when the app starts
  Future<void> checkLoginStatus() async {
    emit(AuthLoading());

    final result = await checkLoginStatusUseCase();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  /// Perform login
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result =
        await loginUseCase(LoginParams(email: email, password: password));
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  // Suggested code may be subject to a license. Learn more: ~LicenseLog:4109811883.
  /// Perform register
  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());
    final result = await registerUseCase(
        RegisterParams(name: name, email: email, password: password));
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await logoutUseCase();
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthInitial()),
    );
  }
}
