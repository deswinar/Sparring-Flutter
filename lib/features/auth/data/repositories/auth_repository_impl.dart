import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

/// Implementation of the AuthRepository interface
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    // Check if user data is cached locally before making a network request
    try {
      final cachedUser = await localDataSource.getCachedUserData();
      if (cachedUser != null) {
        return Right(
            cachedUser.toEntity()); // Return cached user data if available
      } else {
        final result = await remoteDataSource.login(email, password);
        await localDataSource.cacheUserData(result);
        final authToken =
            await remoteDataSource.getAuthToken(); // Get auth token if needed
        await localDataSource.cacheAuthToken(authToken);
        return Right(result.toEntity()); // Convert model to entity
      }
    } catch (e) {
      if (kDebugMode) print(e.toString());
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final result = await remoteDataSource.register(
        email: email,
        password: password,
        name: name,
      );
      // Cache the user data and token after a successful registration
      await localDataSource.cacheUserData(result);
      final authToken =
          await remoteDataSource.getAuthToken(); // Get auth token if needed
      await localDataSource.cacheAuthToken(authToken);
      return Right(result.toEntity());
    } catch (e) {
      return Left(e as Failure);
    }
  }

  // Add any additional methods to clear cached data, if needed
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearCachedUserData(); // Clear user data
      await localDataSource.clearCachedAuthToken(); // Clear auth token
      return const Right(null);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, User>> checkUserStatus() async {
    try {
      final cachedUser = await localDataSource.getCachedUserData();
      final cachedToken = await localDataSource.getCachedAuthToken();

      if (cachedUser != null && cachedToken != null) {
        return Right(cachedUser); // Return the cached user as a Right value
      }

      return Left(AuthFailure(
          'User not authenticated')); // Return failure if user or token is null
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, User>> changePassword(
      String currentPassword, String newPassword) async {
    try {
      // First, call the remote data source to change the password.
      final result = await remoteDataSource.changePassword(
          currentPassword: currentPassword, newPassword: newPassword);

      if (result) {
        // After a successful password change, fetch the updated user data.
        final updatedUser = await remoteDataSource.getCurrentUser();

        // Update the cached user data if needed.
        final cachedUser = await localDataSource.getCachedUserData();
        if (cachedUser != null) {
          // Optionally, update any relevant user info in the cache.
          await localDataSource.cacheUserData(
              updatedUser); // Assuming you are storing updated user in local data source
        }

        return Right(updatedUser); // Return the updated User entity
      } else {
        return Left(AuthFailure('Password change failed'));
      }
    } catch (e) {
      return Left(e as Failure);
    }
  }
}
