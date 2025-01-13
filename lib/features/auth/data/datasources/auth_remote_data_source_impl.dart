import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/error_handler.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      // Use Firebase Authentication to sign in the user
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Fetch user additional data from Firestore
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          final userModel = UserModel.fromJson(userDoc.data()!);
          return userModel;
        } else {
          throw AuthFailure('User data not found.');
        }
      } else {
        throw AuthFailure('User not found.');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      // Use the mapping function for detailed error messages
      throw mapFirebaseAuthException(e);
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected error in login: $e');
      }
      throw AuthFailure('An unexpected error occurred: $e');
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      // Use Firebase Authentication to register the user
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Optionally, update the user's display name
        // await user.updateDisplayName(name);
        if (kDebugMode) {
          print(user.uid);
          print(email);
          print(name);
        }

        // Create a UserModel to store in Firestore with required fields
        final userModel = UserModel(
          id: user.uid, // Assuming the id comes from Firebase UID
          name: name,
          email: email,
          photoUrl: "",
          phone: "", // Set as empty initially
          website: "", // Set as empty initially
        );

        if (kDebugMode) print(userModel.toJson().toString());

        // Save user data to Firestore
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJson());

        // Return the created user as an entity
        return userModel;
      } else {
        throw AuthFailure('User creation failed.');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw mapFirebaseAuthException(e);
    }
  }

  // Get the current authentication token for the logged-in user
  @override
  Future<String> getAuthToken() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        // Get the ID token for the current user
        final idToken = await user.getIdToken();
        return idToken!;
      } else {
        throw AuthFailure('No user is currently authenticated.');
      }
    } catch (e) {
      throw AuthFailure('Failed to retrieve auth token: $e');
    }
  }

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
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthFailure('Failed to sign out: $e');
    }
  }

  /// Changes the password of the currently logged-in user.
  @override
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw AuthFailure('No user is currently authenticated.');
      }

      // Reauthenticate the user
      final email = user.email;
      if (email == null) {
        throw AuthFailure('Email is null for the authenticated user.');
      }

      final credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);

      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthFailure('Failed to change password: $e');
    }
  }
}
