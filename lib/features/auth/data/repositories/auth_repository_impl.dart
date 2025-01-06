import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import '../../../../core/utils/error_handler.dart'; // Import the error handler

/// Implementation of the AuthRepository interface
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    // Use handleErrors to centralize error handling
    return handleErrors(() async {
      // Call the remote data source to perform login
      final result = await remoteDataSource.login(email, password);

      // Map the result to a domain entity (User)
      return result.fold(
        (failure) => throw failure, // Return the failure as is
        (userModel) => userModel.toEntity(), // Convert model to entity
      );
    });
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    // Use handleErrors to centralize error handling
    return handleErrors(() async {
      // Call the remote data source to perform registration
      final result = await remoteDataSource.register(
        email: email,
        password: password,
        name: name,
      );

      // Map the result to a domain entity (User)
      return result.fold(
        (failure) => throw failure, // Return the failure as is
        (userModel) => userModel.toEntity(), // Convert model to entity
      );
    });
  }
}
