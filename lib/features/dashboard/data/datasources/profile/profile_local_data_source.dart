import '../../../../auth/data/models/user_model.dart';

abstract class ProfileLocalDataSource {
  /// Cache the authenticated user data locally.
  Future<void> cacheUserData(UserModel user);

  /// Retrieve the cached user data.
  /// Returns `UserModel` if found or `null` if no user is cached.
  Future<UserModel?> getCachedUserData();

  Future<void> updateCachedUserData(UserModel user);

  /// Clear the cached user data.
  Future<void> clearCachedUserData();

  /// Cache the authentication token (optional).
  Future<void> cacheAuthToken(String token);

  /// Retrieve the cached authentication token (optional).
  /// Returns `String` if found or `null` if no token is cached.
  Future<String?> getCachedAuthToken();

  /// Clear the cached Auth Token.
  Future<void> clearCachedAuthToken();
}
