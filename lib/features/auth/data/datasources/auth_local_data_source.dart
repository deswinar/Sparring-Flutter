import 'package:dartz/dartz.dart';
import 'package:sparring/core/errors/failure.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  /// Logs in a user with the given email and password
  Future<Either<Failure, UserModel>> login(String email, String password);

  /// Registers a new user with the provided details
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String password,
    required String name,
  });
}
