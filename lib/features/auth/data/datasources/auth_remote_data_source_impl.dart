import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';
import '../../../../core/network/api_client.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      final response = await apiClient.post('/login', {
        'email': email,
        'password': password,
      });
      // final response = await apiClient.get('/users/1');

      final data = response.data; // Dio automatically parses JSON
      final userJson = data;
      // userJson['access_token'] = data['access_token'];
      // userJson['refresh_token'] = data['refresh_token'];

      final user = UserModel.fromJson(userJson);
      return Right(user);
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException(
            'Login failed: ${e.response?.data['message'] ?? e.message}');
      }
      return Left(ApiFailure(e.message.toString()));
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await apiClient.post('/register', {
        'email': email,
        'name': username,
        'password': password,
      });

      final data = response.data; // Dio automatically parses JSON
      final user = UserModel.fromJson(data['user']);
      return Right(user);
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException(
            'Registration failed: ${e.response?.data['message'] ?? e.message}');
      }
      return Left(ApiFailure(e.message.toString()));
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }
}
