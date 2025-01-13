import '../../../../auth/data/models/user_model.dart';

/// Abstract class for remote data source related to authentication
abstract class ProfileRemoteDataSource {
  Future<UserModel> getCurrentUser();

  Future<UserModel> updateProfile(
      {required UserModel updatedUserModel});
}
