// lib/features/auth/data/datasources/auth_local_data_source_impl.dart

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:sparring/core/utils/helpers.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../auth/data/models/user_model.dart';
import 'profile_local_data_source.dart';

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final Box _userBox;

  ProfileLocalDataSourceImpl(this._userBox);

  @override
  Future<void> cacheUserData(UserModel user) async {
    await _userBox.put('user', user.toJson());
  }

  @override
  Future<UserModel?> getCachedUserData() async {
    final userData = _userBox.get('user');
    if (userData != null) {
      try {
        final Map<String, dynamic> userMap =
            Helpers().convertToMap<String, dynamic>(userData);
        return UserModel.fromJson(userMap);
      } catch (e) {
        if (kDebugMode) print('Error parsing user data: $e');
        throw CacheFailure('Error parsing user data');
      }
    }
    return null;
  }

  @override
  Future<void> updateCachedUserData(UserModel user) async {
    try {
      await _userBox.put('user', user.toJson());
    } catch (e) {
      if (kDebugMode) print('Error updating cached user data: $e');
      throw CacheFailure('Failed to update cached user data: $e');
    }
  }

  @override
  Future<void> clearCachedUserData() async {
    try {
      await _userBox.delete('user');
    } catch (e) {
      if (kDebugMode) print('Error clearing cached user data: $e');
      throw CacheFailure('Failed to clear cached user data: $e');
    }
  }

  @override
  Future<void> cacheAuthToken(String token) async {
    try {
      await _userBox.put('auth_token', token);
    } catch (e) {
      if (kDebugMode) print('Error caching auth token: $e');
      throw CacheFailure('Failed to cache auth token: $e');
    }
  }

  @override
  Future<String?> getCachedAuthToken() async {
    try {
      return _userBox.get('auth_token');
    } catch (e) {
      if (kDebugMode) print('Error fetching cached auth token: $e');
      throw CacheFailure('Failed to fetch cached auth token: $e');
    }
  }

  @override
  Future<void> clearCachedAuthToken() async {
    try {
      await _userBox.delete('auth_token');
    } catch (e) {
      if (kDebugMode) print('Error clearing cached auth token: $e');
      throw CacheFailure('Failed to clear cached auth token: $e');
    }
  }
}
