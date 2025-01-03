import 'package:bloc/bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../../../core/errors/failure.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

/// Cubit for managing authentication logic
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit({required this.loginUseCase}) : super(AuthInitial());

  /// Perform login
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result =
        await loginUseCase(LoginParams(email: email, password: password));
    result.fold(
      (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
      (user) => emit(AuthSuccess(user)),
    );
  }

  /// Map Failure to user-friendly messages
  String _mapFailureToMessage(Failure failure) {
    if (failure is AuthFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return "Network connection issue. Please try again.";
    } else {
      return "An unexpected error occurred. Please try again.";
    }
  }
}
