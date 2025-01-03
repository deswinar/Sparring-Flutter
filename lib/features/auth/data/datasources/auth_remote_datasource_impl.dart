import 'package:dartz/dartz.dart';
import '../models/user_model.dart';
import 'auth_remote_datasource.dart';
import '../../../../core/errors/failure.dart'; // Import Failure class

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Simulate successful login with mock data
      if (email == "test@example.com" && password == "password123") {
        // Return success with user data (Right side of Either)
        return const Right(
            UserModel(id: "1", name: "Test User", email: "test@example.com"));
      } else {
        // Return specific failure (Left side of Either)
        throw AuthFailure(
            "Invalid credentials"); // Using AuthFailure to specify auth-related error
      }
    } on AuthFailure {
      // Return specific failure (Left side of Either)
      rethrow;
    } catch (e) {
      // Return failure (Left side of Either) in case of any exception
      throw NetworkFailure(
          "Network error occurred"); // Using NetworkFailure for network-related errors
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(
      {required String email,
      required String name,
      required String password}) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Simulate successful registration with mock data
      return Right(UserModel(id: "1", name: name, email: email)); // Success
    } catch (e) {
      // Return failure (Left side of Either) in case of any exception
      return throw ApiFailure(
          "API error occurred"); // Using ApiFailure for API-related errors
    }
  }
}
