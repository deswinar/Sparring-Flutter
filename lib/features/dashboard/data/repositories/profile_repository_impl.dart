import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile/profile_local_data_source.dart';
import '../datasources/profile/profile_remote_data_source.dart';

/// Implementation of the AuthRepository interface
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> updateProfile(User user) async {
    try {
      if (kDebugMode) print("profile_repository_impl.dart");
      // First, call the remote data source to change the password.
      final updatedUser = await remoteDataSource.updateProfile(
          updatedUserModel: UserModel.fromEntity(user));
      if (kDebugMode) print("Here 1");

      // Update the cached user data if needed.
      final cachedUser = await localDataSource.getCachedUserData();
      if (kDebugMode) print('Here 2');
      if (cachedUser != null) {
        // Optionally, update any relevant user info in the cache.
        await localDataSource.cacheUserData(
            updatedUser); // Assuming you are storing updated user in local data source
      }

      return Right(updatedUser); // Return the updated User entity
    } catch (e) {
      return Left(e as Failure);
    }
  }

  @override
  Future<Either<Failure, User>> getProfile() async {
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
}
