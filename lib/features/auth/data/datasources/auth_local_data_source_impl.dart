import 'dart:convert'; // For future use if you decide to handle complex objects
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparring/core/errors/failure.dart';
import 'package:sparring/core/theme/app_theme.dart';
import '../models/user_model.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final _sharedPreferences = GetIt.instance<SharedPreferences>();

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      // Mimic API login logic
      final storedEmail = _sharedPreferences.getString('email');
      final storedPassword = _sharedPreferences.getString('password');
      final storedName = _sharedPreferences.getString('name');
      final storedUsername = _sharedPreferences.getString('username');

      if (storedEmail == null || storedPassword == null) {
        return Left(ApiFailure('No user data found'));
      }

      if (storedEmail != email || storedPassword != password) {
        return Left(ApiFailure('Invalid credentials'));
      }

      // Return the UserModel with the necessary fields from SharedPreferences
      final user = UserModel(
        id: 0, // You can set a default or mock ID for now
        name: storedName!,
        username: storedUsername!,
        email: storedEmail,
        phone: '', // Empty or mock phone as needed
        website: '', // Empty or mock website as needed
      );

      return Right(user);
    } catch (e) {
      return Left(ApiFailure('Failed to login: $e'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      // Mimic registration logic
      await _sharedPreferences.setString('email', email);
      await _sharedPreferences.setString('name', username);
      await _sharedPreferences.setString('password', password);

      // Returning a UserModel mock with the saved details (you can customize the ID)
      final user = UserModel(
        id: 0, // You can set a default or mock ID for now
        name: username,
        username: username,
        email: email,
        phone: '', // Empty or mock phone as needed
        website: '', // Empty or mock website as needed
      );

      return Right(user);
    } catch (e) {
      return Left(ApiFailure('Failed to register: $e'));
    }
  }
}
