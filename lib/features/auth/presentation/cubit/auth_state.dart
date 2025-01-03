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

/// State when authentication fails
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
