import '../models/user_model.dart';

/// Abstract class for remote data source related to authentication
abstract class AuthRemoteDataSource {
  /// Logs in a user with the given email and password
  Future<UserModel> login(String email, String password);

  /// Registers a new user with the provided details
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  });

  Future<String> getAuthToken();

  Future<UserModel> getCurrentUser();

  Future<void> logout();

  Future<bool> changePassword(
      {required String currentPassword, required String newPassword});
}
