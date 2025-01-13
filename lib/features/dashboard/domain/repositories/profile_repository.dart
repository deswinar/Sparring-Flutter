import 'package:dartz/dartz.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../auth/domain/entities/user.dart';

/// Abstract repository for authentication-related operations
abstract class ProfileRepository {
  Future<Either<Failure, User>> updateProfile(User user);
  Future<Either<Failure, User>> getProfile();
}
