// lib/core/utils/error_handler.dart

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../errors/failure.dart';

Future<Either<Failure, T>> handleErrors<T>(
    Future<T> Function() function) async {
  try {
    final result = await function();
    return Right(result);
  } on Failure catch (failure) {
    return Left(failure); // Reuse thrown Failure from data layer
  } catch (_) {
    return Left(GenericFailure('An unknown error occurred.'));
  }
}

/// Maps FirebaseAuthException to domain-specific Failures
Failure mapFirebaseAuthException(FirebaseAuthException e) {
  if (kDebugMode) print(e.code);
  switch (e.code) {
    case 'user-not-found':
      return AuthFailure('User with this email does not exist.');
    case 'user-disabled':
      return AuthFailure('User with this email has been disabled.');
    case 'invalid-credential':
      return AuthFailure('Wrong email or password.');
    case 'wrong-password':
      return AuthFailure('Incorrect password. Please try again.');
    case 'email-already-in-use':
      return AuthFailure('This email is already in use.');
    case 'invalid-email':
      return AuthFailure('The email address is not valid.');
    case 'weak-password':
      return AuthFailure('The password provided is too weak.');
    case 'network-request-failed':
      return NetworkFailure('Network error. Please check your connection.');
    case 'too-many-requests':
      return AuthFailure('Too many login attempts. Please try again later.');
    default:
      return AuthFailure(
          'An unexpected authentication error occurred: ${e.message}');
  }
}
