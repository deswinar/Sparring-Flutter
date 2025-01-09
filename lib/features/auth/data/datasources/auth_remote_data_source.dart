import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';

/// Abstract class for remote data source related to authentication
abstract class AuthRemoteDataSource {
  /// Logs in a user with the given email and password
  Future<Either<Failure, UserModel>> login(String email, String password);

  /// Registers a new user with the provided details
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String username,
  });
}
