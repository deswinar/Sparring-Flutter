part of 'auth_cubit.dart';

/// Base state for authentication
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action
class AuthInitial extends AuthState {}

/// State when authentication is in progress
class AuthLoading extends AuthState {}

/// State when authentication succeeds
class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

/// State when change password succeeds
class AuthChangePasswordSuccess extends AuthState {
  final User user;

  const AuthChangePasswordSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

/// State when change password fail
class AuthChangePasswordFailure extends AuthState {
  final String message;

  const AuthChangePasswordFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when authentication fails
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
