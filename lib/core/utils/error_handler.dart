// lib/core/utils/error_handler.dart

import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

Future<Either<Failure, T>> handleErrors<T>(Future<T> Function() function) async {
  try {
    final result = await function();
    return Right(result);
  } on Failure catch (failure) {
    return Left(failure); // Reuse thrown Failure from data layer
  } catch (_) {
    return Left(GenericFailure('An unknown error occurred.'));
  }
}
