import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<Either<Failure, UserModel>> login(String email, String password) async {
    try {
      // Use Firebase Authentication to sign in the user
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Fetch user additional data from Firestore
        final userDoc = await firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          final userModel = UserModel.fromJson(userDoc.data()!);
          return Right(userModel);
        } else {
          return Left(AuthFailure('User data not found.'));
        }
      } else {
        return Left(AuthFailure('User not found.'));
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(AuthFailure('Login failed: ${e.message ?? e.code}'));
    } catch (e) {
      return Left(AuthFailure('An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      // Use Firebase Authentication to register the user
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Optionally, update the user's display name
        await user.updateDisplayName(name);

        // Create a UserModel to store in Firestore with required fields
        final userModel = UserModel(
          id: int.parse(user.uid), // Assuming the id comes from Firebase UID
          name: name,
          email: email,
          phone: "", // Set as empty initially
          website: "", // Set as empty initially
        );

        // Save user data to Firestore
        await firestore.collection('users').doc(user.uid).set(userModel.toJson());

        // Return the created user as an entity
        return Right(userModel);
      } else {  
        return Left(AuthFailure('User creation failed.'));
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(AuthFailure('Registration failed: ${e.message ?? e.code}'));
    } catch (e) {
      return Left(AuthFailure('An unexpected error occurred: $e'));
    }
  }
}
