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
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthFailure('Failed to sign out: $e');
    }
  }
}
