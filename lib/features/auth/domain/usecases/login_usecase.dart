import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/errors/failure.dart';

/// Use case for logging in a user
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, User>> call(LoginParams params) {
    return _repository.login(params.email, params.password);
  }
}

/// Parameters required for login
class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
