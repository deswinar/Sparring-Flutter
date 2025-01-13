import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../auth/data/models/user_model.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  ProfileRemoteDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        // Fetch the user's additional data from Firestore using their UID
        final userDoc =
            await _firestore.collection('users').doc(firebaseUser.uid).get();
        if (userDoc.exists) {
          // Convert the Firestore document data to a UserModel
          final userModel = UserModel.fromJson(userDoc.data()!);
          return userModel;
        } else {
          throw AuthFailure('User data not found.');
        }
      } else {
        throw AuthFailure('No user is currently authenticated.');
      }
    } catch (e) {
      throw AuthFailure('Failed to get current user: $e');
    }
  }

  @override
  Future<UserModel> updateProfile({
    required UserModel updatedUserModel,
  }) async {
    try {
      if (kDebugMode) print(updatedUserModel.toJson());
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw AuthFailure('No user is currently authenticated.');
      }
      if (kDebugMode) print(user.uid);
      // Save the updated user data to Firestore
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update(updatedUserModel.toJson());

      if (kDebugMode) print("Updated");

      // Return the updated user model
      return updatedUserModel;
    } catch (e) {
      throw AuthFailure('Failed to update profile: $e');
    }
  }
}
