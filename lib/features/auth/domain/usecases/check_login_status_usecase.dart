import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class CheckLoginStatusUseCase {
  final AuthRepository _repository;

  CheckLoginStatusUseCase(this._repository);

  Future<Either<Failure, User>> call() {
    return _repository.checkUserStatus();
  }
}
