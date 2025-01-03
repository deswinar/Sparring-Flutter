import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../../core/errors/failure.dart';

/// Abstract repository for authentication-related operations
abstract class AuthRepository {
  /// Logs in the user with the given email and password
  Future<Either<Failure, User>> login(String email, String password);

  /// Registers a new user with the given details
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
  });
}
